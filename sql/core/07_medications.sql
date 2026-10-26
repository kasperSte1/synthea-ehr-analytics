DROP TABLE IF EXISTS core.medications CASCADE;

CREATE TABLE core.medications (
    id                  BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    start               TIMESTAMPTZ,
    stop                TIMESTAMPTZ,
    patient             UUID NOT NULL REFERENCES core.patients (id),
    payer               UUID NOT NULL REFERENCES core.payers (id),
    encounter           UUID NOT NULL REFERENCES core.encounters (id),
    code                TEXT,
    description         TEXT,
    base_cost           NUMERIC(12,2),
    payer_coverage      NUMERIC(12,2),
    dispenses           INTEGER,
    totalcost           NUMERIC(12,2),
    reasoncode          TEXT,
    reasondescription   TEXT,
    UNIQUE NULLS NOT DISTINCT (patient, encounter, code, start, stop)
);

INSERT INTO core.medications (start, stop, patient, payer, encounter,
code, description, base_cost, payer_coverage, dispenses, totalcost,
reasoncode, reasondescription)
SELECT start::timestamptz, stop::timestamptz, patient::uuid, payer::uuid,
encounter::uuid, code, description, base_cost::numeric,
payer_coverage::numeric, dispenses::integer, totalcost::numeric,
reasoncode, reasondescription
FROM raw.medications;
