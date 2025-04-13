# https://github.com/astral-sh/uv/issues/7758#issuecomment-2682178084

ARG PYTHON_VERSION=3.13

FROM ghcr.io/astral-sh/uv:bookworm-slim AS builder

ENV UV_COMPILE_BYTECODE=1 
ENV UV_LINK_MODE=copy
ENV UV_PYTHON_INSTALL_DIR=/python
ENV UV_PYTHON_PREFERENCE=only-managed

RUN uv python install ${PYTHON_VERSION}

WORKDIR /app

COPY uv.lock pyproject.toml /app/
COPY ./src/ /app/

RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-dev


FROM cgr.dev/chainguard/python:latest AS runtime

WORKDIR /app

COPY --from=builder --chown=python:python /python /python

COPY --from=builder /app /app

ENV PATH="/app/.venv/bin:$PATH"

EXPOSE 80

ENTRYPOINT [ "" ]
CMD ["fastapi", "run", "/app/main.py", "--port", "80"]
