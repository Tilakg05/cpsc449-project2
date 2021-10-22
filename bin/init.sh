#!/bin/bash

sqlite-utils insert ./var/users.db users --csv ./share/users.csv --detect-types --pk=id
sqlite-utils create-index ./var/users.db id username bio email password --unique
ATTACH DATABASE 'tables.db' AS 'tables';
ATTACH DATABASE 'post_0.db' AS 'posts1';
ATTACH DATABASE 'post_1.db' AS 'posts2';
ATTACH DATABASE 'post_2.db' AS 'posts3';

CREATE TABLE IF NOT EXISTS tables.Forums (
  forum_id        INTEGER NOT NULL,
  forum_title     TEXT,
  creator         TEXT,
  PRIMARY KEY (forum_id),
  FOREIGN KEY (creator) REFERENCES Users(username)
);

CREATE TABLE IF NOT EXISTS tables.Threads (
  forum_id        INTEGER,
  thread_id       INTEGER NOT NULL,
  thread_key      TEXT,
  thread_title    TEXT,
  thread_text     TEXT,
  creator         TEXT,
  thread_time     TEXT,
  PRIMARY KEY (thread_key, thread_id),
  FOREIGN KEY (creator) REFERENCES Users(username)  ,
  FOREIGN KEY (forum_id) REFERENCES Forums(forum_id)
);

CREATE TABLE IF NOT EXISTS tables.Users (
  username        TEXT,
  password        TEXT,
  PRIMARY KEY (username)
);

CREATE TABLE IF NOT EXISTS posts1.Posts (
  post_key        TEXT,
  author          TEXT,
  post_text       TEXT,
  post_time       TEXT    
);

CREATE TABLE IF NOT EXISTS posts2.Posts (
  post_key        TEXT,
  author          TEXT,
  post_text       TEXT,
  post_time       TEXT    
);

CREATE TABLE IF NOT EXISTS posts3.Posts (
  post_key        TEXT,
  author          TEXT,
  post_text       TEXT,
  post_time       TEXT    
);

INSERT INTO tables.Users (username, password)
VALUES