DROP TABLE IF EXISTS core.procedures CASCADE;

CREATE TABLE core.procedures (
    start               TIMESTAMPTZ,
    stop                TIMESTAMPTZ,
    patient             UUID NOT NULL REFERENCES core.patients (id),
    encounter           UUID NOT NULL REFERENCES core.encounters (id),
    system              TEXT,
    code                TEXT,
    description         TEXT,
    base_cost           NUMERIC(12,2),
    reasoncode          TEXT,
    reasondescription   TEXT,
    PRIMARY KEY (patient, encounter, code, start, stop)
);

INSERT INTO core.procedures (start, stop, patient, encounter,
system, code, description, base_cost, reasoncode, reasondescription)
SELECT start::timestamptz, stop::timestamptz, patient::uuid, encounter::uuid,
system, code, description, base_cost::numeric, reasoncode, reasondescription
FROM raw.procedures;