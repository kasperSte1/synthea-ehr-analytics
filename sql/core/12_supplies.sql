DROP TABLE IF EXISTS core.supplies CASCADE;

CREATE TABLE core.supplies (
    date                DATE,
    patient             UUID NOT NULL REFERENCES core.patients (id),
    encounter           UUID NOT NULL REFERENCES core.encounters (id),
    code                TEXT,
    description         TEXT,
    quantity            INTEGER,
    PRIMARY KEY (patient, encounter, code, date)
);

INSERT INTO core.supplies (date, patient, encounter, code, description, quantity)
SELECT date::date, patient::uuid, encounter::uuid, code, description,
SUM(quantity::integer)
FROM raw.supplies
GROUP BY date, patient, encounter, code, description;