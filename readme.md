# Description

The repository contains a simple example of the containerization of the Symfony and Nginx.
Based on fpm-alpine.

# Components

- Symfony 7.2
- Nginx 1.27
- Composer
- Git
- Nano editor

# Setting up DEV env

You can use .env, but it's better to use a local file that doesn't fall under git: .env.local

```bash
docker-compose --env-file .env.local up -d
```

After that, you need to install composer dependencies.

```bash
docker compose exec app composer install
```
