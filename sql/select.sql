select tag, name, status, code from team;
select content from email_template;
select name from tshirt_size;
select count(*) from team;
select team_id, count(*) from participant group by team_id;
select id, name from olympiad;
select name, to_char(start, 'dd.MM.yyyy HH24.MI') from olymp_stage where olympiad_id = 1;
select distinct id, name from olymp_stage;
select username, password, salt from users where username ilike '%A%' LIMIT 2 offset 1;
select name from team where stage_id = 2;
select content from email_template where olymp_stage_id = 2;
select name, to_char(start, 'dd.MM.yyyy HH24.MI') from olymp_stage order by start desc;
select * from participant where user_id = 10;
select * from users where id = 10;

