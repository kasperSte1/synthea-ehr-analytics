DROP TABLE IF EXISTS core.organizations CASCADE;

CREATE TABLE core.organizations(
    id          UUID PRIMARY KEY,
    name        TEXT,
    address     TEXT,
    city        TEXT,
    state       TEXT,
    zip         TEXT,
    lat         FLOAT,
    lon         FLOAT,
    phone       TEXT,
    revenue     NUMERIC(12,2),
    utilization INTEGER
);

INSERT INTO core.organizations (id, name, address, city,
state, zip, lat, lon, phone, revenue, utilization)
SELECT id::uuid, name, address, city, state, zip, lat::float,
lon::float, phone, revenue::numeric, utilization::integer
FROM raw.organizations;