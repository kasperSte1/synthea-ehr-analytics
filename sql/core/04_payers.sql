DROP TABLE IF EXISTS core.payers CASCADE;

CREATE TABLE core.payers (
    id                      UUID PRIMARY KEY,
    name                    TEXT,
    ownership               TEXT,
    address                 TEXT,
    city                    TEXT,
    state_headquartered     TEXT,
    zip                     TEXT,
    phone                   TEXT,
    amount_covered          NUMERIC(12,2),
    amount_uncovered        NUMERIC(12,2),
    revenue                 NUMERIC(12,2),
    covered_encounters      INTEGER,
    uncovered_encounters    INTEGER,
    covered_medications     INTEGER,
    uncovered_medications   INTEGER,
    covered_procedures      INTEGER,
    uncovered_procedures    INTEGER,
    covered_immunizations   INTEGER,
    uncovered_immunizations INTEGER,
    unique_customers        INTEGER,
    qols_avg                FLOAT,
    member_months           INTEGER
);

INSERT INTO core.payers (id, name, ownership, address, city,
state_headquartered, zip, phone, amount_covered, amount_uncovered, revenue,
covered_encounters, uncovered_encounters, covered_medications,
uncovered_medications, covered_procedures, uncovered_procedures,
covered_immunizations, uncovered_immunizations, unique_customers,
qols_avg, member_months)
SELECT id::uuid, name, ownership, address, city,
state_headquartered, zip, phone, amount_covered::numeric,
amount_uncovered::numeric, revenue::numeric,
covered_encounters::integer, uncovered_encounters::integer,
covered_medications::integer, uncovered_medications::integer,
covered_procedures::integer, uncovered_procedures::integer,
covered_immunizations::integer, uncovered_immunizations::integer,
unique_customers::integer, qols_avg::float, member_months::integer
FROM raw.payers;