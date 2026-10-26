DROP TABLE IF EXISTS core.observations CASCADE;

CREATE TABLE core.observations (
    id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date            TIMESTAMPTZ,
    patient         UUID NOT NULL REFERENCES core.patients (id),
    encounter       UUID REFERENCES core.encounters (id),
    category        TEXT,
    code            TEXT,
    description     TEXT,
    value           TEXT,
    units           TEXT,
    type            TEXT
);

INSERT INTO core.observations (date, patient, encounter,
category, code, description, value, units, type)
SELECT DISTINCT date::timestamptz, patient::uuid, encounter::uuid,
category, code, description, value, units, type
FROM raw.observations;
