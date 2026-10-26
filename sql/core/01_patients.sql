DROP TABLE IF EXISTS core.patients CASCADE;

CREATE TABLE core.patients (
    id                  UUID PRIMARY KEY,
    birthdate           DATE NOT NULL,
    deathdate           DATE,
    ssn                 TEXT,
    drivers             TEXT,
    passport            TEXT,
    prefix              TEXT,
    first               TEXT,
    middle              TEXT,
    last                TEXT,
    suffix              TEXT,
    maiden              TEXT,
    marital             CHAR,
    race                TEXT,
    ethnicity           TEXT,
    gender              TEXT,
    birthplace          TEXT,
    address             TEXT,
    city                TEXT,
    state               TEXT,
    county              TEXT,
    fips                TEXT,
    zip                 TEXT,
    lat                 FLOAT,
    lon                 FLOAT,
    healthcare_expenses NUMERIC(12,2),
    healthcare_coverage NUMERIC(12,2),
    income              INTEGER
);

INSERT INTO core.patients (id, birthdate, deathdate,
ssn, drivers, passport, prefix, first, middle,
last, suffix, maiden, marital, race, ethnicity,
gender, birthplace, address, city, state,
county, fips, zip, lat, lon, healthcare_expenses,
healthcare_coverage, income)
SELECT
id::uuid, birthdate::date, deathdate::date,
ssn, drivers, passport, prefix, first, middle,
last, suffix, maiden, marital, race, ethnicity,
gender, birthplace, address, city, state,
county, fips, NULLIF(zip, '00000'), lat::float, lon::float, healthcare_expenses::numeric,
healthcare_coverage::numeric, income::integer
FROM raw.patients;