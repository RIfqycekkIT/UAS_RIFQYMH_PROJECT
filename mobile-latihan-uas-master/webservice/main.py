from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# Agar bisa diakses dari Flutter
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Jika ingin lebih aman, isi dengan URL app Flutter-mu
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Data contoh (bisa disambungkan ke database jika mau)
covid_data = {
    "global": {
        "cases": 700000000,
        "deaths": 6000000,
        "recovered": 680000000
    },
    "indonesia": {
        "cases": 7000000,
        "deaths": 160000,
        "recovered": 6800000
    }
}

@app.get("/")
def read_root():
    return {"message": "API COVID-19 Lokal Berjalan"}

@app.get("/covid/global")
def get_global_data():
    return covid_data["global"]

@app.get("/covid/indonesia")
def get_indonesia_data():
    return covid_data["indonesia"]
