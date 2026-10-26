DROP TABLE IF EXISTS core.providers CASCADE;

CREATE TABLE core.providers (
    id              UUID PRIMARY KEY,
    organization    UUID REFERENCES core.organizations (id),
    name            TEXT,
    gender          TEXT,
    speciality      TEXT,
    address         TEXT,
    city            TEXT,
    state           TEXT,
    zip             TEXT,
    lat             FLOAT,
    lon             FLOAT,
    encounters      INTEGER,
    procedures      INTEGER
);

INSERT INTO core.providers (id, organization, name,
gender, speciality, address, city, state, zip, lat,
lon, encounters, procedures)
SELECT id::uuid, organization::uuid, name, gender,
speciality, address, city, state, zip, lat::float,
lon::float, encounters::integer, procedures::integer
FROM raw.providers;