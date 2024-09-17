# PangBai-HTTP

This is the challenge for NewStarCTF 2024 in the category of Web, Week 2.

This challenge requires participants to leak `.git` directory by GitHacker, and find backdoor files in stash to take exploit.

The challenge doesn't provide source code to participants.

## Deployment

> [!NOTE]
> The FLAG is initially given by the environment variable `ICQ_FLAG`.

Docker is provided. You can run the following command to start the environment quickly:

```bash
docker compose build # Build the image
docker compose up -d # Start the container
```

## License

Copyright (c) Cnily03. All rights reserved.

Licensed under the [MIT](LICENSE) License.
