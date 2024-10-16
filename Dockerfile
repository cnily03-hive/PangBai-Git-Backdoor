FROM oven/bun:1.1.20-slim AS prod-deps

RUN apt update && apt install -y git
RUN git config --global init.defaultBranch main
RUN git config --global user.email "newstar@openctf.net"
RUN git config --global user.name "NewStarCTF 2024"

RUN mkdir -p /build/
COPY . /build/
WORKDIR /build/

RUN git init && git add . && \
    git reset assets/backdoor.js backdoor.php && \
    git commit -m "Initial commit"

# minify css
RUN sed -i ':a;N;$!ba;s/\s\+/ /g' assets/index.css
# rename css & replace css in html
RUN mv assets/index.css assets/index.$(md5sum assets/index.css | cut -d ' ' -f 1 | cut -c 8-24).css
RUN sed -i 's_assets/index.css_assets/'$(ls assets | grep index.*.css)'_' index.html

RUN git add . && \
    git reset assets/backdoor.js backdoor.php && \
    git commit -m "Minify CSS"

# minify js & rename js
RUN bun build --minify --target browser --entry-naming '[name].[hash].[ext]' --outdir dist assets/index.js assets/backdoor.js
RUN rm -f assets/index.js assets/backdoor.js assets/listen-block.js
RUN cp -r dist/* assets/ && rm -rf dist

# replace js in html and php
RUN sed -i 's_assets/index.js_assets/'$(ls assets | grep index.*.js)'_' index.html
RUN sed -i 's_assets/index.js_assets/'$(ls assets | grep index.*.js)'_' backdoor.php
RUN sed -i 's_assets/backdoor.js_assets/'$(ls assets | grep backdoor)'_' backdoor.php

RUN sed -i 's_o31uGSgxKmj7_'$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)'_' backdoor.php
RUN mv backdoor.php BacKd0or.$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1).php

RUN git init && git add . && \
    git reset BacKd0or.*.php assets/backdoor.*.js && \
    git commit -m "Minify JS"

RUN mkdir -p /another/ /another/assets/
RUN cp BacKd0or.*.php /another/
RUN cp assets/backdoor.*.js /another/assets/

# stash the backdoor
RUN git stash push -u -m "Backdoor"

FROM php:7.4-apache

ENV FLAG=flag{test_flag}

COPY --from=prod-deps /build/ /var/www/html/
COPY --from=prod-deps /another/ /var/www/html/

RUN useradd -m ctf
RUN chown -R ctf:ctf /var/log/apache2/

USER ctf
CMD [ "apache2-foreground" ]

EXPOSE 80