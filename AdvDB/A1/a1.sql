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



-- #4
START TRANSACTION;
    select * from job;
    UPDATE job set job_title='owner' WHERE job_id=1;
    select * from job;
COMMIT;