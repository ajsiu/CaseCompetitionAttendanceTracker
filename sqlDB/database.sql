--CREATE DATABASE ligmadb;

CREATE TABLE attended (
    user_name varchar(510), -- 255 + 255
    email varchar(256) NOT NULL UNIQUE,--rfc standard says 320 however really it's 256
    event_name varchar(255) NOT NULL,
    event_desc text, --optional. `text` should be replaced with `blob` outside of postgres
    CONSTRAINT rec_hash PRIMARY KEY (email,event_name) -- might replace with a hash computed by the app. that might be better performance and usabillity wise
);

-- below are some views. these can be replaced by in app code.
-- but using these is easier and likely safer from injection.

CREATE VIEW user_attended AS
SELECT email, user_name, ARRAY[event_name] 
FROM attended
ORDER BY attended.email;
-- might not work on some databases
-- email might not aggregate right. needs to be tested

CREATE VIEW events AS
SELECT event_name, event_desc
FROM attended
ORDER BY event_name;
