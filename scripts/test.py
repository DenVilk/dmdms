from mimesis import Person
import random
import string


def randomword(length):
    letters = string.ascii_lowercase
    return ''.join(random.choice(letters) for i in range(length))


sql_users = "insert into users (username, email, lastname, firstname, midname, education, password, salt) values ('{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}');"

for i in range(10):
    person = Person()
    username = person.username()
    email = person.email(domains=['gmail.com', 'yandex.ru', 'mail.ru', 'prodigy.by'])
    first_name = person.first_name()
    lastname = person.last_name()
    midname = person.title()
    education = person.university()
    password = randomword(50)
    salt = randomword(50)

    print(sql_users.format(username, email, lastname, first_name, midname, education, password, salt))

sql_coach = "insert into coach (email, lastname, firstname, midname, tshirt_id, team_id) values ('{}','{}','{}','{}','{}','{}');"