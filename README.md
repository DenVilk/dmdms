# Модели данных и систему управления базами данных

### Студент: Великович Владимир Сергеевич

### Группа: 153503

----

## Проект: Система регистрации пользователей на олимпиаду

### Функциональные требования:

1. Авторизация пользователей
2. Система ролей
3. Логгирование действий пользователей
4. Управление пользователями
5. Создание олимпиад
6. Регистрация участников на олимпиаду
7. Регистрация команды на олимпиаду
8. Панель администратора

    - Изменение статуса команды
    - Создание аккаунта в тестирующей системе для команды
    - Создание таблиц с информацией для организаторов

        - Учетные записи команд
        - Расположение команд по аудиториям
        - Распределение участников по командам

    - Создание изменение шаблонов писем для рассылки пользователям

---

### Список таблиц:

1. User - пользователь
    - username - varchar(30) NOT NULL, UNIQUE
    - email - varchar(60) NOT NULL, must be valid email, UNIQUE
    - firstname - varchar(50) NOT NULL
    - midname - varchar(50) NOT NULL
    - lastname - varchar(50) NOT NULL
    - education - varchar(200) NOT NULL
    - password - varchar(200) NOT NULL
    - salt - varchar(100) NOT NULL
2. Role - роли пользователей
    - name - varchar(50) NOT NULL, UNIQUE
3. Coach - тренеры 
    - email - varchar(60) NOT NULL, must be valid email, UNIQUE
    - firstname - varchar(50) NOT NULL
    - midname - varchar(50) NOT NULL
    - lastname - varchar(50) NOT NULL
    - tshirt_size - MtO(TShirt size) NOT NULL
    - team - MtM(Team) NOT NULL
4. Participant - участник олимпиады
    - user - OtO(User) NOT NULL
    - firstname - varchar(50) NOT NULL 
    - midname - varchar(50) NOT NULL
    - lastname - varchar(50) NOT NULL
    - email - varchar(60) NOT NULL, must be valid email
    - education - varchar(200) NOT NULL
    - team - MtO(Team)
    - tshirt_size - MtO(TShirt size)
5. Team - команда
    - name - varchar(50) NOT NULL, UNIQUE
    - status - varchar('not done', 'pending', 'approved', 'disqualified') NOT NULL
    - type - MtO(Team type) NOT NULL
    - code - varchar(8) NOT NULL
    - stage - MtO(Olymp stage)
    - tag - varchar(20)
    - olympiad - MtO(Olympiad) NOT NULL
6. Team type - типа команды, может быть школьной или студенческой
    - name - varchar(20) NOT NULL, UNIQUE
7. Olymp stage - стадия олимпиады
    - name - varchar(20) NOT NULL, UNIQUE
    - olympiad - MtO(Olympiad) NOT NULL
    - date - datetime()
8. Email Template - шаблон для писем участникам
    - Olymp Stage - OtO(Olymp Stage) NOT NULL
    - content - text() NOT NULL
9. Olympiad - олимпиада
    - name - varchar(100) NOT NULL, UNIQUE
    - is_opened_registration - boolean default=false
    - type - varchar('ICPC', 'IOI') NOT NULL
10. Logs - журнал действий пользователя
    - user - MtO(User) NOT NULL
    - operation - varchar('create', 'delete', 'update') NOT NULL
    - timestamp - timestamp NOT NULL
    - old - text()
    - new - text()
11. TShirt Size - размеры маек
    - name - varchar(5) NOT NULL, UNIQUE
