# PangBai-HTTP

This is the challenge for NewStarCTF 2024 in the category of Web, Week 2.

This challenge requires participants to leak `.git` directory by GitHacker, and find backdoor files in stash to take exploit.

The challenge doesn't provide source code to participants.

## Deployment

> [!NOTE]
> If the development is at ichunqiu platform, please modify [docker-compose.yml](docker-compose.yml) to change `Dockerfile` into `Dockerfile.icq` and the environment variable `FLAG` to `ICQ_FLAG`.

Docker is provided. You can run the following command to start the environment quickly:

```bash
docker compose build # Build the image
docker compose up -d # Start the container
```

## License

Copyright (c) Cnily03. All rights reserved.

Licensed under the [MIT](LICENSE) License.
