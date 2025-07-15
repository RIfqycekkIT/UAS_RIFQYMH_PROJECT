from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from typing import Optional
from pydantic import BaseModel
import sqlite3

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_headers=["*"],
    allow_methods=["*"],
    allow_origins=["*"],    
    allow_credentials=True,    
)

class PoliRead(BaseModel):
    id: Optional[int|None] = None
    nama: str
    jenis: str

class Poli(BaseModel):
    nama: str
    jenis: str


DB_NAME = "tugas_latihan_uas.db"

@app.get('/init')
def initial():
    conn = sqlite3.connect(DB_NAME)
    cur = conn.cursor()

    query = """
    CREATE TABLE IF NOT EXISTS poli (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama VARCHAR(200),
        jenis VARCHAR(200)
    )
    """
    cur.execute(query)
    conn.commit()

    return ({"status": "success","message":"berhasil"})


@app.get("/poli")
def get_poli():
    conn = sqlite3.connect(DB_NAME)
    cur = conn.cursor()
    query = "SELECT * FROM poli"
    result = []
    cur.execute(query)

    for row in cur.fetchall():
        result.append(PoliRead(id=row[0], nama=row[1], jenis=row[2]))
    
    return ({"data": result})



@app.post("/poli")
def insert_poli(model:Poli):
    conn = sqlite3.connect(DB_NAME)
    cur = conn.cursor()
    query = """
    INSERT INTO poli (nama, jenis) VALUES ('{}', '{}');
    """.format(model.nama, model.jenis)

    cur.execute(query)
    conn.commit()

    return ({"status":"success", "message":"berhasil tambah data"})
