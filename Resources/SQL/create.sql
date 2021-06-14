CREATE TABLE IF NOT exists google_email
(
    "ID"            SERIAL NOT NULL PRIMARY KEY,
    "user_id"       INT    NOT NULL,
    "access_token"  TEXT   NOT NULL,
    "refresh_token" TEXT   NOT NULL,
    "email_address" TEXT   NOT NULL,
    "chat_id"       INT
);