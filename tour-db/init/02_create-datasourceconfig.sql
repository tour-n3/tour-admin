-- Tạo SCHEMA mặc định là demo trong db sevenhallo để run các app Java

\connect sevenhallo;

CREATE SCHEMA IF NOT EXISTS config;

CREATE TABLE if not exists config.DATASOURCECONFIG
(
    id              bigint PRIMARY KEY,
    driverclassname VARCHAR(255),
    url             VARCHAR(255),
    name            VARCHAR(255),
    username        VARCHAR(255),
    password        VARCHAR(255),
    initialize      BOOLEAN
);

-- Chỉ insert dữ liệu nếu nó chưa tồn tại
INSERT INTO config.DATASOURCECONFIG (id, driverclassname, url, name, username, password, initialize)
SELECT 1,
       'org.postgresql.Driver',
       'jdbc:postgresql://localhost:5432/tenant1?ApplicationName=MultiTenant',
       'tenant_01',
       'postgres',
       'postgres',
       true
WHERE NOT EXISTS (SELECT 1 FROM config.DATASOURCECONFIG WHERE id = 1);

INSERT INTO config.DATASOURCECONFIG (id, driverclassname, url, name, username, password, initialize)
SELECT 2,
       'org.postgresql.Driver',
       'jdbc:postgresql://localhost:5432/tenant2?ApplicationName=MultiTenant',
       'tenant_02',
       'postgres',
       'postgres',
       true
WHERE NOT EXISTS (SELECT 1 FROM config.DATASOURCECONFIG WHERE id = 2);
