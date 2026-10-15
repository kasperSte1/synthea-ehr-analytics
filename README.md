# Synthea EHR Analytics

Project includes synthetic patient health records generated with Synthea, loaded into PostgreSQL and analyzed.

## Data
All data is synthetic, generated with [Synthea™](https://github.com/synthetichealth/synthea)
by The MITRE Corporation. No real patient data is used.

## Environment
- Python 3.13.5
- Java 21 (Eclipse Temurin), Synthea requires 17+
- Docker, PostgreSQL 16
- Synthea v4.0.0, `synthea-with-dependencies.jar`,
  SHA-256: `ed43c20ad40ba5c3bc724503a5af032715fe3c491620b766148e7c2361e6ecc1`

## Reproducing the project

1. **Download Synthea v4.0.0**
   Get `synthea-with-dependencies.jar` from the
   [v4.0.0 release](https://github.com/synthetichealth/synthea/releases/tag/v4.0.0)
   and place it in `tools/`. Verify the SHA-256 above.
2. **Generate data**
   Command: `java -jar tools/synthea-with-dependencies.jar -c config/synthea.properties -p 1000 -s 42 -r 20261015`
3. **Start the database**
   Copy `.env.example` to `.env` and set your own password (change_me), then: `docker compose up -d`

## Project structure
- `config/` – Synthea configuration
- `data/raw/` – generated CSV files (not tracked)
- `sql/` – SQL scripts
- `notebooks/` – analysis
- `docs/` – decisions, data overview, audit
- `tools/` – Synthea binary (not tracked)
