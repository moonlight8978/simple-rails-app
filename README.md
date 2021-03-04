### SRA - Simple Rails App

Simple Rails Application for learning deployment

##### Development

- Run the server

```sh
cp .env.example .env
docker-compose build
yarn install
docker-compose up -d
```

- Testing

  - Unit tests

  ```sh
  docker-compose run --rm web rails spec
  ```

  - System tests: Make sure `system-test-web` is running

  ```sh
  yarn test
  ```

##### Deployment

Things to setup

- MySQL database
- SSM Parameter Store (`USE_SSM=1`) - Set ENV variables
- Redis (`USE_REDIS=1`) - Session storage
- S3 Bucket (`USE_S3=1`) - File upload
- SMTP Mailer
- CICD

TODO: More features to setup
