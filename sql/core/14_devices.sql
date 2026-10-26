DROP TABLE IF EXISTS core.devices CASCADE;

CREATE TABLE core.devices (
    id                  BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    start               TIMESTAMPTZ,
    stop                TIMESTAMPTZ,
    patient             UUID NOT NULL REFERENCES core.patients (id),
    encounter           UUID NOT NULL REFERENCES core.encounters (id),
    code                TEXT,
    description         TEXT,
    udi                 TEXT,
    UNIQUE NULLS NOT DISTINCT (patient, code, start, stop)
);

INSERT INTO core.devices (start, stop, patient, encounter, code,
description, udi)
SELECT start::timestamptz, stop::timestamptz, patient::uuid, encounter::uuid,
code, description, udi
FROM raw.devices;