DROP TABLE IF EXISTS core.encounters CASCADE;

CREATE TABLE core.encounters (
    id                  UUID PRIMARY KEY,
    start               TIMESTAMPTZ,
    stop                TIMESTAMPTZ,
    patient             UUID NOT NULL REFERENCES core.patients (id),
    organization        UUID NOT NULL REFERENCES core.organizations (id),
    provider            UUID NOT NULL REFERENCES core.providers (id),
    payer               UUID NOT NULL REFERENCES core.payers (id),
    encounterclass      TEXT,
    code                TEXT,
    description         TEXT,
    base_encounter_cost NUMERIC(12,2),
    total_claim_cost    NUMERIC(12,2),
    payer_coverage      NUMERIC(12,2),
    reasoncode          TEXT,
    reasondescription   TEXT
);

INSERT INTO core.encounters (id, start, stop, patient, organization,
provider, payer, encounterclass, code, description,
base_encounter_cost, total_claim_cost, payer_coverage,
reasoncode, reasondescription)
SELECT id::uuid, start::timestamptz, stop::timestamptz, patient::uuid, organization::uuid,
provider::uuid, payer::uuid, encounterclass, code, description,
base_encounter_cost::numeric, total_claim_cost::numeric,
payer_coverage::numeric, reasoncode, reasondescription
FROM raw.encounters;