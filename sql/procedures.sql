-- create or replace procedure tshirt_count_for_olymp(
--     IN olymp_name varchar(150)
-- )
-- as $$
-- begin
--     select tshirt_size.name, count(*)
--     from participant
--     join team on participant.team_id = team.id
--     join olympiad on team.olympiad_id = olympiad.id
--     join tshirt_size on participant.tshirt_id = tshirt_size.id
--     where olympiad.name = olymp_name
--     group by tshirt_size.name;
-- end;
-- $$ language plpgsql;

-- call tshirt_count_for_olymp('BSUIR OPEN X');

CREATE OR REPLACE PROCEDURE add_olympiad(
  IN p_name VARCHAR(150),
  IN p_type VARCHAR(10)
)
AS $$
BEGIN
  INSERT INTO olympiad (name, type) VALUES (p_name, p_type);
END;
$$ LANGUAGE plpgsql;

call add_olympiad('bit-cup 2023', 'IOI');

CREATE OR REPLACE PROCEDURE move_user_to_participant(
  IN p_user_id INTEGER,
  IN p_team_id INTEGER,
  IN p_tshirt_size INTEGER
)
AS $$
DECLARE
  user_record RECORD;
BEGIN
  SELECT * INTO user_record
  FROM users
  WHERE id = p_user_id;

  INSERT INTO participant (user_id, firstname, midname, lastname, education, tshirt_id, team_id)
  VALUES (p_user_id, user_record.firstname, user_record.midname, user_record.lastname, user_record.education, p_tshirt_size, p_team_id);
END;
$$ LANGUAGE plpgsql;

call move_user_to_participant(11, 4, 1);

CREATE OR REPLACE PROCEDURE add_user(
  IN p_username VARCHAR(30),
  IN p_email VARCHAR(60),
  IN p_firstname VARCHAR(50),
  IN p_midname VARCHAR(50),
  IN p_lastname VARCHAR(50),
  IN p_education VARCHAR(200),
  IN p_password VARCHAR(200),
  IN p_salt VARCHAR(50)
)
AS $$
BEGIN
  INSERT INTO users (username, email, firstname, midname, lastname, education, password, salt)
  VALUES (p_username, p_email, p_firstname, p_midname, p_lastname, p_education, p_password, p_salt);
END;
$$ LANGUAGE plpgsql;

CALL add_user('john_doe', 'john@example.com', 'John', 'Middle', 'Doe', 'Computer Science', 'hashed_password', 'random_salt');
