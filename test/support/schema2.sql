DROP TABLE IF EXISTS "Users";
CREATE TABLE "Users" (
  "Id" SERIAL PRIMARY KEY,
  email TEXT,
  phone TEXT,
  token TEXT,
  attempts INT,
  created_on DATE,
  updated_at TIMESTAMP,
  ip TEXT,
  name TEXT,
  nonsense TEXT,
  untouchable TEXT,
  "column_with_punctuation?" BOOLEAN
);

DROP TABLE IF EXISTS posts CASCADE;
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title TEXT
);

DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  post_id INTEGER REFERENCES posts(id)
);
ALTER TABLE comments ALTER CONSTRAINT comments_post_id_fkey DEFERRABLE;

DROP TABLE IF EXISTS robots;
CREATE TABLE robots (
  id SERIAL PRIMARY KEY,
  name TEXT
);
CREATE OR REPLACE FUNCTION nope()
RETURNS trigger AS
$$
BEGIN
  RAISE EXCEPTION 'Nope!';
END;
$$
LANGUAGE plpgsql;
CREATE TRIGGER nope_trigger BEFORE INSERT OR UPDATE ON robots FOR EACH ROW EXECUTE PROCEDURE nope();