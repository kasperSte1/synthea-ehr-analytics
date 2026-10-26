DROP TABLE IF EXISTS core.conditions CASCADE;

CREATE TABLE core.conditions (
    start               DATE,
    stop                DATE,
    patient             UUID NOT NULL REFERENCES core.patients (id),
    encounter           UUID NOT NULL REFERENCES core.encounters (id),
    system              TEXT,
    code                TEXT,
    description         TEXT,
    PRIMARY KEY (patient, encounter, code)
);

INSERT INTO core.conditions (start, stop, patient, encounter,
system, code, description)
SELECT start::date, stop::date, patient::uuid, encounter::uuid,
system, code, description
FROM raw.conditions;