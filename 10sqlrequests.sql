--Знайти 5 студентів із найбільшим середнім балом з усіх предметів.
SELECT s.fullname, AVG(g.grade) as avg_grade   
FROM grades g
LEFT JOIN students s ON s.id = g.student_id 
GROUP BY s.id
ORDER BY avg_grade DESC  
LIMIT 5;

--Знайти студента із найвищим середнім балом з певного предмета.
SELECT sbj.name, s.fullname, ROUND(AVG(g.grade), 2) as avg_grade
FROM grades g
LEFT JOIN students s ON s.id = g.student_id 
LEFT JOIN subjects sbj ON sbj.id = g.subject_id 
WHERE sbj.id = 4
GROUP BY s.id
ORDER BY avg_grade DESC  
LIMIT 1;

--Знайти середній бал у групах з певного предмета.
SELECT g.name as group_name, ROUND(AVG(gd.grade), 2) as avg_grade
FROM groups g
JOIN students s ON s.group_id = g.id
JOIN grades gd ON gd.student_id = s.id
JOIN subjects sbj ON sbj.id = gd.subject_id
WHERE sbj.id = 4
GROUP BY g.id;

--Знайти середній бал на потоці (по всій таблиці оцінок).
SELECT ROUND(AVG(grade), 2) as avg_grade
FROM grades;

--Знайти, які курси читає певний викладач.
SELECT t.fullname as teacher_name, sbj.name as subject_name
FROM teachers t
JOIN subjects sbj ON sbj.teacher_id = t.id
WHERE t.id = 3;

--Знайти список студентів у певній групі.
SELECT s.fullname as student_name
FROM students s
JOIN groups g ON g.id = s.group_id
WHERE g.id = 2;

--Знайти оцінки студентів в окремій групі з певного предмета.
SELECT s.fullname as student_name, g.grade
FROM students s
JOIN groups g ON g.id = s.group_id
JOIN grades gd ON gd.student_id = s.id
JOIN subjects sbj ON sbj.id = gd.subject_id
WHERE g.id = 2 AND sbj.id = 4

--Знайти середній бал, який ставить певний викладач зі своїх предметів:
SELECT t.fullname as teacher_name, ROUND(AVG(g.grade), 2) as avg_grade
FROM teachers t
JOIN subjects sbj ON sbj.teacher_id = t.id
JOIN grades g ON g.subject_id = sbj.id
WHERE t.id = 3
GROUP BY t.id;

--Знайти список курсів, які відвідує студент. Наприклад, студента з ідентифікатором:
SELECT sbj.name as subject_name
FROM students s
JOIN grades g ON g.student_id = s.id
JOIN subjects sbj ON sbj.id = g.subject_id
WHERE s.id = 1;


--Список курсів, які певному студенту читає певний викладач
SELECT sbj.name as subject_name
FROM students s
JOIN grades g ON g.student_id = s.id
JOIN subjects sbj ON sbj.id = g.subject_id
JOIN teachers t ON t.id = sbj.teacher_id
WHERE s.id = 1 AND t.id = 3;








