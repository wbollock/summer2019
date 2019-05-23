-- A1 / LIS3784 / WILL BOLLOCK
-- #1
-- old-style join
select emp_id, emp_fname, emp_lname,
    CONCAT(emp_street, ",", emp_city, ",", emp_state, " ", substring(emp_zip,1,5),'-', substring(emp_zip,6,4)) as address,
    CONCAT('(', substring(emp_phone,1,3), ')',substring(emp_phone,4,3),'-',substring(emp_phone,7,4)) as phone_num,
    CONCAT(substring(emp_ssn,1,3),'-',substring(emp_ssn,4,2),'-',substring(emp_ssn,6,4)) as emp_ssn, job_title
from job as j, employee as e
where j.job_id = e.job_id
order by emp_lname desc;

+--------+-----------+-----------+--------------------------------------------------+---------------+-------------+-----------+
| emp_id | emp_fname | emp_lname | address                                          | phone_num     | emp_ssn     | job_title |
+--------+-----------+-----------+--------------------------------------------------+---------------+-------------+-----------+
|      2 | Ayanna    | Munoz     | 460-7598 Semper Street,Lexington,KY 10237-8890   | (701)368-2592 | 338-72-6106 | CEO       |
|      5 | Craig     | Mejia     | Ap #402-7165 Imperdiet, Rd.,Joliet,IL 82188-4321 | (815)290-3216 | 814-98-7867 | Plumber   |
|      3 | Deacon    | Cohen     | 9866 Arcu Rd.,Laramie,WY 95749-1234              | (364)357-4152 | 266-16-7708 | Secretary |
|      4 | Adrienne  | Castillo  | 7348 Erat. Road,Nampa,ID 23153-2231              | (151)956-3599 | 156-14-1441 | Janitor   |
|      1 | Ann       | Bolton    | 194-8220 Integer Rd.,Augusta,ME 21017-1231       | (642)106-5243 | 528-41-6512 | IT        |
+--------+-----------+-----------+--------------------------------------------------+---------------+-------------+-----------+
5 rows in set (0.00 sec)

-- join only has some starting syntax




-- #2
SELECT e.emp_id, emp_fname, emp_lname, eht_date, eht_job_id, job_title, eht_emp_salary, eht_notes
from employee e, emp_hist h, job j
where e.emp_id = h.emp_id
    and eht_job_id = j.job_id
order by emp_id, eht_date;

+--------+-----------+-----------+---------------------+------------+-----------+----------------+-----------+
| emp_id | emp_fname | emp_lname | eht_date            | eht_job_id | job_title | eht_emp_salary | eht_notes |
+--------+-----------+-----------+---------------------+------------+-----------+----------------+-----------+
|      1 | Ann       | Bolton    | 2005-07-18 12:00:00 |          1 | IT        |       35000.00 | Lorem     |
|      2 | Ayanna    | Munoz     | 2011-08-31 09:00:00 |          2 | CEO       |       47000.00 | Ipsum     |
|      3 | Deacon    | Cohen     | 2016-04-30 08:30:00 |          3 | Secretary |       39000.00 | Loreum    |
|      4 | Adrienne  | Castillo  | 2017-05-19 11:00:00 |          4 | Janitor   |       60000.00 | Ipsum     |
|      5 | Craig     | Mejia     | 2009-11-11 14:30:00 |          5 | Plumber   |       80000.00 | Lorem     |
+--------+-----------+-----------+---------------------+------------+-----------+----------------+-----------+
5 rows in set (0.01 sec)


-- or with formatted date
select e.emp_id, emp_fname, emp_lname, DATE_FORMAT(eht_date,'%m%/%d%/%y %h:%i:%p')
as formatted_date, eht_job, job_title, eht_emp_salary, ehT_notes
from employee e, emp_hist h, job j
where e.emp_id = h.emp_idgit p
    and eht_job_id = j.job_id
order by emp_id, eht_date;
    

-- #3
SELECT emp_fname, emp_lname, emp_dob,
DATE_FORMAT(NOW(), '%Y') -
DATE_FORMAT(emp_dob, '%Y') -
(DATE_FORMAT(NOW(), '00-%m-%d') <
DATE_FORMAT(emp_dob, '00-%m-%d')) AS emp_age,

dep_fname, dep_lname, dep_relation, dep_dob,
DATE_FORMAT(NOW(), '%Y') -
DATE_FORMAT(dep_dob, '%Y') -
(DATE_FORMAT(NOW(), '00-%m-%d') <
DATE_FORMAT(dep_dob, '00-%m-%d')) AS dep_age,

from employee
    NATURAL JOIN dependent
order by emp_lname;

-- ez way, not the answer
SELECT emp_fname, emp_lname, emp_dob,
TIMESTAMPDIFF(year, emp_dob, curdate()) as emp_age


-- #4
START TRANSACTION;
    select * from job;
    UPDATE job set job_title='owner' WHERE job_id=1;
    select * from job;
COMMIT;


-- #5
DROP PROCEDURE IF EXISTS insert_benefit;
DELIMITER //
CREATE PROCEDURE insert_benefit()

BEGIN
    SELECT * FROM benefit;

    INSERT INTO benefit
    (ben_name,ben_notes)
    VALUES
    ('new benefit','testing');

    SELECT * FROM benefit;
END //
DELIMITER ;


-- paste it then call it
CALL insert_benefit();
DROP PROCEDURE IF EXISTS insert_benefit;

+--------+------------+-----------+
| ben_id | ben_name   | ben_notes |
+--------+------------+-----------+
|      1 | Dental     | NULL      |
|      2 | Vision     | NULL      |
|      3 | Healthcare | NULL      |
|      4 | Dental     | NULL      |
|      5 | Vision     | NULL      |
+--------+------------+-----------+
5 rows in set (0.00 sec)

+--------+-------------+-----------+
| ben_id | ben_name    | ben_notes |
+--------+-------------+-----------+
|      1 | Dental      | NULL      |
|      2 | Vision      | NULL      |
|      3 | Healthcare  | NULL      |
|      4 | Dental      | NULL      |
|      5 | Vision      | NULL      |
|      6 | new benefit | testing   |
+--------+-------------+-----------+
6 rows in set (0.01 sec)





-- #6
SELECT emp_id, emp_lname, emp_fname, emp_ssn, emp_email,
dep_lname, dep_fname, dep_ssn, dep_street, emp_city, dep_state, dep_zip, dep_phone
FROM employee
    NATURAL LEFT OUTER JOIN dependent
ORDER BY emp_lname;

+--------+-----------+-----------+-----------+----------------------------------------------+-----------+-----------+-----------+-----------------------------+-----------+-----------+---------+------------+
| emp_id | emp_lname | emp_fname | emp_ssn   | emp_email                                    | dep_lname | dep_fname | dep_ssn   | dep_street                  | emp_city  | dep_state | dep_zip | dep_phone  |
+--------+-----------+-----------+-----------+----------------------------------------------+-----------+-----------+-----------+-----------------------------+-----------+-----------+---------+------------+
|      1 | Bolton    | Ann       | 528416512 | laoreet.posuere.enim@lobortisClass.com       | Hyde      | Callum    | 528416512 | 789-497 Sem, Ave            | Augusta   | CO        |   43516 | 3238717455 |
|      4 | Castillo  | Adrienne  | 156141441 | mauris.elit@mattisvelitjusto.ca              | Baird     | Tucker    | 156141441 | Ap #285-497 Erat. Avenue    | Nampa     | MO        |   21153 | 1301154909 |
|      3 | Cohen     | Deacon    | 266167708 | fermentum.metus.Aenean@velpedeblandit.org    | Pitts     | Megan     | 266167708 | P.O. Box 910, 7866 Et Rd.   | Laramie   | AR        |   72193 | 4638757058 |
|      5 | Mejia     | Craig     | 814987867 | nunc.nulla@actellusSuspendisse.edu           | Gilmore   | Vance     | 814987867 | Ap #469-9360 Lectus St.     | Joliet    | VA        |   62363 | 8126912889 |
|      2 | Munoz     | Ayanna    | 338726106 | cursus.vestibulum@Integertinciduntaliquam.ca | Benjamin  | Valentine | 338726106 | P.O. Box 139, 8455 Cras St. | Lexington | TX        |   76690 | 5314755340 |
+--------+-----------+-----------+-----------+----------------------------------------------+-----------+-----------+-----------+-----------------------------+-----------+-----------+---------+------------+
5 rows in set (0.00 sec)


-- answer step 2
SELECT emp_id,
    concat(emp_lname, ",",emp_fname) as employee,
    concat(substring(emp_ssn,1,3), '-', substring(emp_ssn,4,2),'-',substring(emp_ssn,6,4)) as emp_ssn,
    emp_email as email,

    concat(dep_lname,",",dep_fname) as dependent,
    concat(substring(dep_ssn,1,3),'-',substring(dep_ssn,4,2),'-',substring(dep_ssn,6,4)) as dep_ssn,
    concat(dep_street,",",emp_city,",",dep_state," ",substring(dep_zip,1,5),'-',substring(dep_zip,6,4)) as address,
    concat('(',substring(dep_phone,1,3), ')',substring(dep_phone,4,3),'-',substring(dep_phone,7,4)) as phone_num

    FROM employee
        NATURAL LEFT OUTER JOIN dependent
    ORDER BY emp_lname;

+--------+-------------------+-------------+----------------------------------------------+--------------------+-------------+-------------------------------------------------+---------------+
| emp_id | employee          | emp_ssn     | email                                        | dependent          | dep_ssn     | address                                         | phone_num     |
+--------+-------------------+-------------+----------------------------------------------+--------------------+-------------+-------------------------------------------------+---------------+
|      1 | Bolton,Ann        | 528-41-6512 | laoreet.posuere.enim@lobortisClass.com       | Hyde,Callum        | 528-41-6512 | 789-497 Sem, Ave,Augusta,CO 43516-              | (323)871-7455 |
|      4 | Castillo,Adrienne | 156-14-1441 | mauris.elit@mattisvelitjusto.ca              | Baird,Tucker       | 156-14-1441 | Ap #285-497 Erat. Avenue,Nampa,MO 21153-        | (130)115-4909 |
|      3 | Cohen,Deacon      | 266-16-7708 | fermentum.metus.Aenean@velpedeblandit.org    | Pitts,Megan        | 266-16-7708 | P.O. Box 910, 7866 Et Rd.,Laramie,AR 72193-     | (463)875-7058 |
|      5 | Mejia,Craig       | 814-98-7867 | nunc.nulla@actellusSuspendisse.edu           | Gilmore,Vance      | 814-98-7867 | Ap #469-9360 Lectus St.,Joliet,VA 62363-        | (812)691-2889 |
|      2 | Munoz,Ayanna      | 338-72-6106 | cursus.vestibulum@Integertinciduntaliquam.ca | Benjamin,Valentine | 338-72-6106 | P.O. Box 139, 8455 Cras St.,Lexington,TX 76690- | (531)475-5340 |
+--------+-------------------+-------------+----------------------------------------------+--------------------+-------------+-------------------------------------------------+---------------+








-- #7
-- triggers: in mySQL, can have up to 6 triggers
-- 3 before, 3 after

drop trigger if exists trg_employee_after_insert;

delimiter //
create trigger trg_employee_after_insert
    AFTER INSERT on employee
    FOR EACH ROW
    BEGIN
    INSERT INTO emp_hist
    (emp_id,eht_date,eht_type,eht_job_id,eht_emp_salary,eht_usr_changed,eht_reason,eht_notes)
    values(NEW.emp_id,now(),'i',NEW.job_id,NEW.emp_salary,user(),"new employee",NEW.emp_notes);
END//
delimiter ;


-- trigger test


select * from employee;
select * from emp_hist;

insert into employee
(job_id, emp_ssn, emp_fname, emp_lname, emp_dob, emp_start_date, emp_end_date, emp_salary, emp_street, emp_city, emp_state, emp_zip, emp_phone, emp_email, emp_notes)
values
(3, 12345678, 'Rocky', 'Balboa', '1976-07-25','1999-11-07',null,59000.00,'457 Main Street','Boise','ID',837074532,
9876544321, 'rbalboa@aol.com','meat packer');

-- test after

select * from employee;
select * from emp_hist;

+--------+--------+---------------------+----------+------------+----------------+------------------+--------------+-------------+
| eht_id | emp_id | eht_date            | eht_type | eht_job_id | eht_emp_salary | eht_usr_changed  | eht_reason   | eht_notes   |
+--------+--------+---------------------+----------+------------+----------------+------------------+--------------+-------------+
|      1 |      1 | 2005-07-18 12:00:00 | i        |          1 |       35000.00 | web15c           | Fired        | Lorem       |
|      2 |      2 | 2011-08-31 09:00:00 | i        |          2 |       47000.00 | km12n            | Fired        | Ipsum       |
|      3 |      3 | 2016-04-30 08:30:00 | u        |          3 |       39000.00 | jmpf12           | Increase Pay | Loreum      |
|      4 |      4 | 2017-05-19 11:00:00 | u        |          4 |       60000.00 | feb16c           | Retirement   | Ipsum       |
|      5 |      5 | 2009-11-11 14:30:00 | d        |          5 |       80000.00 | jorge16          | Fired        | Lorem       |
|      6 |      9 | 2019-05-23 16:54:06 | i        |          3 |       59000.00 | web15c@localhost | new employee | meat packer |
+--------+--------+---------------------+----------+------------+----------------+------------------+--------------+-------------+
6 rows in set (0.00 sec)

