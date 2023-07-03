import sqlite3
from datetime import datetime
from random import randint, choice

import faker import Faker

fake = Faker('uk-UA')

subjects = [
    "Coding",
    "Math",
    "Geometry",
    "Physic",
    "Phylosophie",
    "Chemie",
    "Sociology",
    "Singing",
    "Aikido"

]


groups = ["XX-23", "YY-11", "ZZ-44"]


NUMBERS_TEACHERS = 5
NUMBERS_STUDENTS = 25


connect = sqlite3.connect('hw06.sqlite')
cursor = connect.cursor()


def seed_teacher():
    teachers = [fake.name() for _in range(NUMBERS_TEACHERS)]
    sql = "INSERT INTO teachers(fullname) VALUES (?)"
    cursor.executemany(sql, zip(teachers,))


def seed_groups():
    sql = "INSERT INTO groups(name) VALUES (?)"
    cursor.executemany(sql, zip(groups,))


def seed_students():
    students = [fake.name() for _ in range(NUMBERS_STUDENTS)]
    list_group_id = [randint(1, len(groups)) for _ in range(NUMBERS_STUDENTS)]
    sql = "INSERT INTO students(fullname, group_id) VALUES (?, ?);"
    cursor.executemany(sql, zip(students, list_group_id))


def seed_subjects():
    list_teacher_id = [randint(1, NUMBERS_TEACHERS)
                       for _ in range(len(subjects))]
    sql = "INSERT INTO subjects(name, teacher_id) VALUES (?, ?);"
    cursor.executemany(sql, zip(subjects, list_teacher_id))


def seed_grades():
    start_date = datetime.strptime("2022-09-01", "%Y-%m-%d")
    finish_date = datetime.strptime("2023-05-31", "%Y-%m-%d")
    sql = "INSERT INTO grades(student_id, subject_id, grade, date_of) VALUES(?, ?, ?, ?);"

    def get_list_date(start_date, finish_date) -> List[date]:
        result = []
        current_day: date = start_date
        while current_day < finish_date:
            if current_day.isoweekday() < 6:
                result.append(current_day)
            current_day += timedelta(1)
        return result

    list_date = get_list_date(start_date, finish_date)

    grades = []
    for day in list_date:
        random_subject = randint(1, len(subjects))
        random_students = [randint(1, NUMBERS_STUDENTS) for _ in range(7)]
        for student in random_students:
            grades.append((student, random_subject,
                          randint(1, 12), day.date()))

    cursor.executemany(sql, grades)


if _name_ == ' _main_ ':
    seed_teacher()
    seed_groups()
    seed_students()
    seed_subjects()
    seed_grades()
    connect.commit()
    connect.close()
