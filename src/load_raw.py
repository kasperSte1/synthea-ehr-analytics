import pathlib
import pandas as pd
import psycopg
from dotenv import load_dotenv
import os

load_dotenv()

PROJECT_ROOT = pathlib.Path(__file__).parent.parent
CSV_DIR = PROJECT_ROOT / "data" / "raw" / "csv"
path = pathlib.Path(CSV_DIR).glob("*.csv")

CONN = (f"host={os.environ['POSTGRES_HOST']} "
        f"port={os.environ['POSTGRES_PORT']} "
        f"dbname={os.environ['POSTGRES_DB']} "
        f"user={os.environ['POSTGRES_USER']} "
        f"password={os.environ['POSTGRES_PASSWORD']}"
        )

with psycopg.connect(CONN) as conn:
    with conn.cursor() as cursor:
        cursor.execute("DROP SCHEMA IF EXISTS raw CASCADE;")
        cursor.execute("CREATE SCHEMA IF NOT EXISTS raw;")
        for f in path:
            table_name = f.stem
            cols = [c.lower() for c in pd.read_csv(f, nrows=0).columns]
            col_defs = [f"{c} TEXT" for c in cols]
            cols_defs_sql = ', '.join(col_defs)
            query = f"CREATE TABLE raw.{table_name} ({cols_defs_sql});"
            cursor.execute(query)

            with cursor.copy(f"COPY raw.{table_name} FROM STDIN WITH (FORMAT csv, HEADER true)") as cp:
                with open(f, "rb") as file:
                    while True:
                        chunk = file.read(1024*1024) #~1MB
                        if not chunk:
                            break
                        cp.write(chunk)
            cursor.execute(f"SELECT COUNT(*) FROM raw.{table_name};")
            print(f"raw.{table_name}: {cursor.fetchone()[0]}")