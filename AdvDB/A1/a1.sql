-- A1 / LIS3784 / WILL BOLLOCK
-- #1
-- old-style join
select emp_id, emp_fname, emp_lname,
    CONCAT (emp_street, ",", emp_city, ",", emp_state, " ", substring(emp_zip,1,5),'-', substring(emp_zip,6,4)) as address,
    CONCAT ('(', substring(emp_phone,1,3), ')',substring(emp_phone,4,3),'-',substring(emp_phone(7,4)) as phone_num,
    CONCAT(substring(emp_ssn,1,3),'-',substring(emp_ssn,4,2),'-',substring(emp_ssn,6,4)) as emp_ssn,job_title
from job as j, employee as e
where j.job_id = e.job_id
order by emp_lname desc;
-- join only has some starting syntax


-- #2
select e.emp_id, emp_fname, emp_lname, eht_date, eht_job, job_title, eht_emp_salary, ehT_notes
from employee e, emp_hist h, job j
where e.emp_id = h.emp_id
    and eht_job_id = j.job_id
order by emp_id, eht_date.

-- or with formatted date
select e.emp_id, emp_fname, emp_lname, DATE_FORMAT(eht_date,'%m%/%d%/%y %h:%i:%p')
as formatted_date, eht_job, job_title, eht_emp_salary, ehT_notes
from employee e, emp_hist h, job j
where e.emp_id = h.emp_id
    and eht_job_id = j.job_id
order by emp_id, eht_date.
    

-- #3

--  test
-- #4

START TRANSACTION;
    select * from job;
    UPDATE job set job_title='owner' WHERE job_id=1;
    select * from job;
COMMIT;