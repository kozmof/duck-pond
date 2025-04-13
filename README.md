# Duck Pond
Duck Pond = DuckDB + FastAPI Container

## Quick Start
### Dev Container
```sh
uv sync
source .venv/bin/activate
fastapi dev src/main.py --port 80
```
### WSL
```sh
docker build -t quack-image .
docker run -d --name quack-container -p 80:80 quack-image
```
