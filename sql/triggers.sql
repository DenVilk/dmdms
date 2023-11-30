CREATE OR REPLACE FUNCTION check_participant_limit()
RETURNS TRIGGER AS $$
DECLARE
  team_count INT;
BEGIN
  SELECT COUNT(*) INTO team_count
  FROM participant
  WHERE NEW.team_id is not null and team_id = NEW.team_id;

  IF team_count >= 3 THEN
    RAISE EXCEPTION 'Команда уже имеет максимальное количество участников (3).';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_participant_limit_trigger
BEFORE INSERT or UPDATE ON participant
FOR EACH ROW
EXECUTE FUNCTION check_participant_limit();

insert into participant (user_id, lastname, firstname, midname, education, tshirt_id, team_id) values (10, 'Carr', 'Jen', 'EdD', 'University of California, Berkeley (UC Berkeley)', 3, 4);

delete from participant where user_id = 10;



CREATE OR REPLACE FUNCTION check_olympiad_registration_on_status_change()
RETURNS TRIGGER AS $$
DECLARE
  olympiad_status boolean;
BEGIN
  SELECT is_opened_registration INTO olympiad_status
  FROM olympiad
  WHERE id = NEW.olympiad_id;

  IF NEW.status = 'pending' AND NOT olympiad_status THEN
    RAISE EXCEPTION 'Регистрация для олимпиады закрыта. Нельзя подать заявку на рассмотрение команды для участия.';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_olympiad_registration_on_status_change_trigger
BEFORE UPDATE ON team
FOR EACH ROW
WHEN (OLD.status = 'not done' AND NEW.status = 'pending')
EXECUTE FUNCTION check_olympiad_registration_on_status_change();


update team
set status = 'pending'
where name='EVS ne KSIS';


CREATE OR REPLACE FUNCTION create_olympiad_stages()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO olymp_stage (name, olympiad_id, start)
  VALUES ('Stage 1', NEW.id, NOW()),
         ('Stage 2', NEW.id, NOW() + INTERVAL '1 month'),
         ('Stage 3', NEW.id, NOW() + INTERVAL '2 months');

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER create_olympiad_stages_trigger
AFTER INSERT ON olympiad
FOR EACH ROW
EXECUTE FUNCTION create_olympiad_stages();

CREATE OR REPLACE FUNCTION create_email_template_on_stage_creation()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO email_template (olymp_stage_id, content)
  VALUES (NEW.id, NEW.name);

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER create_email_template_trigger
AFTER INSERT ON olymp_stage
FOR EACH ROW
EXECUTE FUNCTION create_email_template_on_stage_creation();


insert into olympiad (name, is_opened_registration, type) VALUES ('BITCAP', false, 'IOI');