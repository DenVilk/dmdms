select id, name
from team
where (select count(*) from participant where team_id=team.id) = 3;

select
    lastname,
    firstname,
    midname,
    (select name from tshirt_size where id = participant.tshirt_id) as tshirt_size,
    (select name from team where id = participant.team_id) as team
from participant
where team_id is not null;


select
    name,
    (select count(*) from participant where team_id=team.id) as cnt
from team;

select lastname, firstname, midname, (select name from team where id = participant.team_id)
from participant
where team_id = (select id from team where name = 'EVS ne KSIS');

select name
from olymp_stage
where olympiad_id = (select id from olympiad where name = 'BSUIR OPEN X');

select
    id,
    username
--     (select name from role where (select role_id from role_to_user where role_to_user.role_id = users.id) = role.id) as role
from users;

select participant.lastname, participant.firstname, participant.midname, team.name
from participant
left join team on participant.team_id = team.id
where team.name = 'EVS ne KSIS';

select lastname, firstname, midname, team.name
from participant
left join team on participant.team_id = team.id
where (select count(*) from participant where team_id = team.id) = 1 and
      (select name from olympiad where id = team.olympiad_id) = 'BSUIR OPEN X';

explain analyse select
    name,
    cnt,
    case
        when cnt = 1 then 'You can register 2 more participants to this team'
        when cnt = 2 then 'You can register 1 more participant to this team'
        when cnt = 3 then 'You cannot register any more to this team'
        else 'Empty team'
    end
from (select id, name, (select count(*) from participant where team_id = team.id) as cnt from team) t;


select firstname, lastname from users
union
select firstname, lastname from participant;

select team.name, participant.firstname from team
full join participant on participant.team_id = team.id;

select users.username, role.name
from users
inner join role_to_user rtu on users.id = rtu.user_id
inner join role on role.id = rtu.role_id;

select users.username, rtu.role_id
from users
right join role_to_user rtu on users.id = rtu.user_id;

select role.name, rtu.role_id
from role
right outer join role_to_user rtu on role.id = rtu.user_id;

select team.name, participant.firstname
from team cross join participant;

select olympiad.name, olymp_stage.name, email_template.content
from email_template
join olymp_stage on email_template.olymp_stage_id = olymp_stage.id
join olympiad on olymp_stage.olympiad_id = olympiad.id;

select participant.firstname, participant.midname, participant.lastname, team.name, olympiad.name, tshirt_size.name
from participant
join team on participant.team_id = team.id
join olympiad on team.olympiad_id = olympiad.id
join tshirt_size on participant.tshirt_id = tshirt_size.id;

select team.name, count(*)
from participant
join team on team.id = participant.team_id
group by team.name
having count(*) < 3;

select
    team_id
--     count(*) as avg_count
from participant
group by team_id
having count(*) = 3;

select
    team.name,
    exists(select team_id from participant where team.id = team_id group by team_id having count(*) = 3) as is_full
from team;

select
    (select name from team where id=team_id) as nm,
    (select name from tshirt_size where id=tshirt_id),
    count(*)
from participant
group by tshirt_id, team_id
order by nm;
