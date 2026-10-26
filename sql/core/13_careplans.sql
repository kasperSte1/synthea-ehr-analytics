DROP TABLE IF EXISTS core.careplans CASCADE;

CREATE TABLE core.careplans (
    id                  UUID PRIMARY KEY,
    start               DATE,
    stop                DATE,
    patient             UUID NOT NULL REFERENCES core.patients (id),
    encounter           UUID NOT NULL REFERENCES core.encounters (id),
    code                TEXT,
    description         TEXT,
    reasoncode          TEXT,
    reasondescription   TEXT
);

INSERT INTO core.careplans (id, start, stop, patient, encounter,
code, description, reasoncode, reasondescription)
SELECT id::uuid, start::date, stop::date, patient::uuid, encounter::uuid,
code, description, reasoncode, reasondescription
FROM raw.careplans;