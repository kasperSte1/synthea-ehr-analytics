from db import get_connection
import pathlib

PROJECT_ROOT = pathlib.Path(__file__).parent.parent
SQL_DIR = PROJECT_ROOT / "sql" / "core"
path = sorted(SQL_DIR.glob("*.sql"))

with get_connection() as conn:
    with conn.cursor() as cur:
        for f in path:
            print(f.name)
            cur.execute(f.read_text(encoding="utf-8"))
        cur.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'core';")
        rows = cur.fetchall()

        for row in rows:
            table_name = row[0]
            cur.execute(f"SELECT count(*) FROM core.{table_name};")
            print(table_name, cur.fetchone()[0])