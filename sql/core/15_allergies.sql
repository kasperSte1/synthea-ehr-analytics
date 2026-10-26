DROP TABLE IF EXISTS core.allergies CASCADE;

CREATE TABLE core.allergies (
    start               DATE,
    stop                DATE,
    patient             UUID NOT NULL REFERENCES core.patients (id),
    encounter           UUID NOT NULL REFERENCES core.encounters (id),
    code                TEXT,
    system              TEXT,
    description         TEXT,
    type                TEXT,
    category            TEXT,
    reaction1           TEXT,
    description1        TEXT,
    severity1           TEXT,
    reaction2           TEXT,
    description2        TEXT,
    severity2           TEXT,
    PRIMARY KEY (patient, code, start)
);

INSERT INTO core.allergies (start, stop, patient, encounter, code, system,
description, type, category, reaction1, description1, severity1,
reaction2, description2, severity2)
SELECT start::date, stop::date, patient::uuid, encounter::uuid, code, system,
description, type, category, reaction1, description1, severity1,
reaction2, description2, severity2
FROM raw.allergies;