-- 1. Devuelve una lista con el primer apellido, segundo apellido y nombre de todos los estudiantes. La lista debe estar ordenada alfabéticamente de menor a mayor por primer apellido, segundo apellido y nombre.
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1, apellido2, nombre;
-- 2. Encuentra los nombres y apellidos de los estudiantes que no han registrado su número de teléfono en la base de datos.
SELECT nombre, apellido1, apellido2 FROM persona WHERE telefono IS NULL AND tipo = 'alumno';
-- 3. Devuelve la lista de estudiantes que nacieron en 1999.
SELECT nombre, apellido1, apellido2 FROM persona WHERE YEAR(fecha_nacimiento) = 1999 AND tipo = 'alumno';
-- 4. Devuelve la lista de profesores que no han registrado su número de teléfono en la base de datos y cuyo NIF termina en K.
SELECT * FROM persona WHERE telefono IS NULL AND nif LIKE '%K' AND tipo = 'profesor';
-- 5. Devuelve la lista de asignaturas que se imparten en el primer semestre, en el tercer año del grado con identificador 7.
SELECT nombre FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
-- 6. Devuelve una lista de profesores junto con el nombre del departamento al que están vinculados. La lista debe mostrar cuatro columnas: primer apellido, segundo apellido, nombre y nombre del departamento. El resultado debe estar ordenado alfabéticamente de menor a mayor por apellido y nombre.
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre AS departamento_nombre FROM persona
JOIN profesor ON persona.id = profesor.id_profesor JOIN departamento ON profesor.id_departamento = departamento.id
ORDER BY persona.apellido1, persona.apellido2, persona.nombre;
-- 7. Devuelve una lista con el nombre de las asignaturas, el año de inicio y el año de finalización del curso escolar del estudiante con NIF 26902806M.
SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin
FROM alumno_se_matricula_asignatura JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id 
JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id 
WHERE persona.nif = '26902806M';
-- 8. Devuelve una lista con el nombre de todos los departamentos que tienen profesores que enseñan una asignatura en el Grado en Ingeniería Informática (Plan 2015).
SELECT DISTINCT departamento.nombre FROM departamento JOIN profesor ON departamento.id = profesor.id_departamento 
JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor JOIN grado ON asignatura.id_grado = grado.id 
WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';
-- 9. Devuelve una lista de todos los estudiantes que se han matriculado en una asignatura durante el curso escolar 2018/2019.
SELECT DISTINCT persona.nombre, persona.apellido1, persona.apellido2 FROM persona
INNER JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno
INNER JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
WHERE curso_escolar.anyo_inicio = 2018 AND curso_escolar.anyo_fin = 2019;


-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.
-- 1. Devuelve una lista con los nombres de todos los profesores y los departamentos a los que están vinculados. La lista también debe mostrar a aquellos profesores que no tienen ningún departamento asociado. La lista debe contener cuatro columnas: nombre del departamento, primer apellido, segundo apellido y nombre del profesor. El resultado debe estar ordenado alfabéticamente de menor a mayor por nombre del departamento, apellido y nombre del profesor.
SELECT departamento.nombre AS "Nombre departamento", persona.apellido1, persona.apellido2, persona.nombre
FROM persona
LEFT JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN departamento ON profesor.id_departamento = departamento.id
ORDER BY "Nombre departamento", persona.apellido1, persona.apellido2, persona.nombre ASC;
-- 2. Devuelve una lista de profesores que no están asociados a ningún departamento.
SELECT persona.nombre AS profesor FROM persona LEFT JOIN profesor 
ON persona.id = profesor.id_profesor LEFT JOIN departamento 
ON profesor.id_departamento = departamento.id WHERE departamento.id IS NULL;
-- 3. Devuelve una lista de departamentos que no tienen profesores asociados.
SELECT departamento.nombre AS "Nombre departamento"
FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento
WHERE  profesor.id_departamento IS NULL;
-- 4. Devuelve una lista de profesores que no enseñan ninguna asignatura.
SELECT persona.nombre, persona.apellido1, persona.apellido2, asignatura.nombre AS asignatura
FROM persona
LEFT JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
WHERE asignatura.id IS NULL;
-- 5. Devuelve una lista de asignaturas que no tienen un profesor asignado.
SELECT asignatura.nombre FROM asignatura
LEFT JOIN profesor ON asignatura.id_profesor = profesor.id_profesor
WHERE profesor.id_profesor IS NULL;
-- 6. Devuelve una lista de todos los departamentos que no han enseñado asignaturas en ningún curso escolar.
SELECT DISTINCT departamento.nombre AS departamento
FROM departamento 
LEFT JOIN profesor ON departamento.id = profesor.id_departamento 
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor 
LEFT JOIN alumno_se_matricula_asignatura AS ma ON asignatura.id = ma.id_asignatura
LEFT JOIN curso_escolar ON ma.id_curso_escolar = curso_escolar.id
WHERE curso_escolar.id IS NULL;

-- Consultes resum:
-- 1. Devuelve el número total de estudiantes en la base de datos.
SELECT COUNT(*) FROM persona WHERE tipo = 'alumno';
-- 2. Calcula cuántos estudiantes nacieron en 1999.
SELECT COUNT(*) FROM persona WHERE tipo = 'alumno' and  YEAR(fecha_nacimiento) = 1999;
-- 3. Calcula cuántos profesores hay en cada departamento. El resultado debe mostrar solo dos columnas: nombre del departamento y número de profesores en ese departamento. Deben incluirse solo los departamentos que tienen profesores asociados y ordenarse de mayor a menor por el número de profesores.
SELECT departamento.nombre AS departamento , COUNT(*) AS profesores FROM departamento 
JOIN profesor ON departamento.id = profesor.id_departamento 
GROUP BY departamento ORDER BY profesores DESC;
-- 4. Devuelve una lista con el nombre de todos los departamentos y el número de profesores en cada uno de ellos. Ten en cuenta que puede haber departamentos que no tienen profesores asociados. Esos departamentos también deben aparecer en la lista.
SELECT d.nombre AS 'Departamento', IFNULL(COUNT(p.id_profesor), 0) AS 'profesores' FROM departamento d LEFT JOIN profesor p ON d.id = p.id_departamento GROUP BY Departamento ORDER BY profesores DESC;
-- 5. Devuelve una lista con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que cada uno tiene. Ten en cuenta que puede haber grados que no tienen asignaturas asociadas. Los grados también deben aparecer en la lista. El resultado debe estar ordenado de mayor a menor por el número de asignaturas.
SELECT g.nombre AS 'Grado', IFNULL(COUNT(a.nombre), 0) AS 'asignaturas' FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY Grado ORDER BY asignaturas DESC;
-- 6. Devuelve una lista con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que cada uno tiene, de los grados que tienen más de 40 asignaturas asociadas.
SELECT g.nombre AS 'Grado', IFNULL(COUNT(a.nombre), 0) AS 'asignaturas' FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY Grado HAVING COUNT(a.nombre) > 40;
-- 7. Devuelve una lista que muestre el nombre de los grados y la suma del número total de créditos para cada tipo de asignatura. El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y suma de los créditos de todas las asignaturas de ese tipo.
SELECT g.nombre, a.tipo, SUM(a.creditos) AS 'Total_creditos' FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.id, a.tipo; 
-- 8. Devuelve una lista que muestre cuántos estudiantes se han matriculado en una asignatura en cada uno de los años escolares. El resultado debe mostrar dos columnas: año de inicio del año escolar y número de estudiantes matriculados.
SELECT ce.anyo_inicio, COUNT(asm.id_alumno) AS 'estudiantes_matriculados' FROM curso_escolar ce LEFT JOIN alumno_se_matricula_asignatura asm ON ce.id = asm.id_curso_escolar GROUP BY ce.anyo_inicio;
-- 9. Devuelve una lista con el número de asignaturas enseñadas por cada profesor. La lista debe tener en cuenta a los profesores que no enseñan ninguna asignatura. El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. Debe estar ordenado de mayor a menor por el número de asignaturas.
SELECT p.id, p.nombre, p.apellido1, p.apellido2, IFNULL(COUNT(a.nombre), 0) AS 'asignaturas' FROM persona p LEFT JOIN asignatura a ON p.id = a.id_profesor GROUP BY p.id ORDER BY asignaturas DESC;
-- 10. Devuelve todos los datos del estudiante más joven.
select * from persona Where tipo = 'alumno' ORDER BY fecha_nacimiento DESC limit 1 ;
-- 11. Devuelve una lista de profesores que tienen un departamento asociado y que no enseñan ninguna asignatura.
SELECT p.id, p.nombre, prof.id_departamento, a.nombre AS 'asignatura' FROM persona p JOIN profesor prof ON p.id = prof.id_profesor LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor WHERE a.nombre IS NULL;