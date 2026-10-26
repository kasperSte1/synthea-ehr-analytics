DROP TABLE IF EXISTS core.immunizations CASCADE;

CREATE TABLE core.immunizations (
    date                TIMESTAMPTZ,
    patient             UUID NOT NULL REFERENCES core.patients (id),
    encounter           UUID NOT NULL REFERENCES core.encounters (id),
    code                TEXT,
    description         TEXT,
    base_cost           NUMERIC(12,2),
    PRIMARY KEY (patient, encounter, code, date)
);

INSERT INTO core.immunizations (date, patient, encounter, code,
description, base_cost)
SELECT date::timestamptz, patient::uuid, encounter::uuid, code,
description, base_cost::numeric
FROM raw.immunizations;