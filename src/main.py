from typing import Union
from fastapi import FastAPI
import duckdb

app = FastAPI()

@app.get("/")
def read_root():
    record = duckdb.sql("SELECT 42").fetchone()
    return {"Hello": "World", "duck": str(record)}


@app.get("/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}
