# Docker Task Manager (Node.js + PostgreSQL)

A small CRUD web app for learning Docker, Dockerfiles, images, containers, networks, volumes, and Docker Compose.

## Requirements

- Docker Desktop (Windows/macOS) or Docker Engine + Docker Compose (Linux)
- No local Node.js or PostgreSQL installation is required when using Docker Compose.

## Run the application

From this folder:

```bash
docker compose up --build
```

Open http://localhost:3000

Try adding tasks, marking them complete, and deleting them.

## Check the containers and logs

```bash
docker compose ps
docker compose logs -f
docker compose logs -f app
docker compose logs -f db
```

## Stop the application

```bash
docker compose down
```

The named volume `postgres_data` is retained, so your tasks remain when you start the project again.

To remove the containers AND database data:

```bash
docker compose down -v
```

Warning: `-v` deletes the database volume and all tasks stored in it.

## Useful Docker learning commands

```bash
# List running containers
docker ps

# List all containers
docker ps -a

# List local images
docker images

# Open a shell in the Node.js container
docker exec -it task-app sh

# Open PostgreSQL's interactive SQL shell
docker exec -it task-db psql -U appuser -d taskdb

# Inspect the Docker network
docker network ls

# Inspect the database volume
docker volume ls

# Build only the app image
docker compose build app

# Recreate the app after changing source code
docker compose up --build -d app
```

## Architecture

```text
Browser
  |
  | http://localhost:3000
  v
Node.js / Express container (task-app)
  |
  | Docker Compose network; hostname: db
  v
PostgreSQL container (task-db)
  |
  v
Named volume (postgres_data)
```

- The browser talks to the Node.js backend through published host port `3000`.
- The Node.js app connects to PostgreSQL using hostname `db` (the Compose service name).
- PostgreSQL data is stored in the named volume `postgres_data`.
- The database port is not published to the host in this beginner example.

## Important learning notes

- `Dockerfile` describes how to build the Node.js image.
- `compose.yaml` describes the two services, their configuration, and persistent volume.
- `EXPOSE 3000` documents the container port; `ports: "3000:3000"` publishes it on the host.
- `depends_on` with `service_healthy` waits for the database health check before starting the app.
- The credentials in this demo are for local learning only. Do not use them in production; use secrets and stronger credentials.
