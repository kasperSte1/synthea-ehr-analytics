DROP TABLE IF EXISTS core.payer_transitions CASCADE;

CREATE TABLE core.payer_transitions (
    patient             UUID NOT NULL REFERENCES core.patients (id),
    memberid            UUID,
    start_date          TIMESTAMPTZ,
    end_date            TIMESTAMPTZ,
    payer               UUID NOT NULL REFERENCES core.payers (id),
    secondary_payer     UUID REFERENCES core.payers (id),
    plan_ownership      TEXT,
    owner_name          TEXT,
    PRIMARY KEY (patient, start_date, end_date)
);

INSERT INTO core.payer_transitions (patient, memberid, start_date, end_date,
payer, secondary_payer, plan_ownership, owner_name)
SELECT patient::uuid, memberid::uuid, start_date::timestamptz,
end_date::timestamptz, payer::uuid, secondary_payer::uuid,
plan_ownership, owner_name
FROM raw.payer_transitions;