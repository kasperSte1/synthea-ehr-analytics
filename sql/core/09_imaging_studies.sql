DROP TABLE IF EXISTS core.imaging_studies CASCADE;

CREATE TABLE core.imaging_studies (
    instance_uid         TEXT PRIMARY KEY, -- one row = one image
    study_id             UUID NOT NULL, -- "id" in source; one study has many images
    date                 TIMESTAMPTZ,
    patient              UUID NOT NULL REFERENCES core.patients (id),
    encounter            UUID NOT NULL REFERENCES core.encounters (id),
    series_uid           TEXT,
    bodysite_code        TEXT,
    bodysite_description TEXT,
    modality_code        TEXT,
    modality_description TEXT,
    sop_code             TEXT,
    sop_description      TEXT,
    procedure_code       TEXT
);

INSERT INTO core.imaging_studies (instance_uid, study_id, date, patient,
encounter, series_uid, bodysite_code, bodysite_description, modality_code,
modality_description, sop_code, sop_description, procedure_code)
SELECT instance_uid, id::uuid, date::timestamptz, patient::uuid,
encounter::uuid, series_uid, bodysite_code, bodysite_description,
modality_code, modality_description, sop_code, sop_description,
procedure_code
FROM raw.imaging_studies;