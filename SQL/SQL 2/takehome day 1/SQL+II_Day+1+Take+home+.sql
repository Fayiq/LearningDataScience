# Datasets used: employee_details.csv and Department_Details.csv
# Use subqueries to answer every question

use sql2takehome1;

#Q1. Retrive employee_id , first_name , last_name and salary details of those employees whose salary is greater than the average salary of all the employees.

SELECT 
    employee_id, first_name, salary
FROM
    employee_details
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            employee_details);

#Q2. Display first_name , last_name and department_id of those employee where the location_id of their department is 1700

SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS Ename,
    j.department_id
FROM
    employee_details e
        JOIN
    (SELECT 
        DEPARTMENT_ID, location_id
    FROM
        department_details
    WHERE
        location_id = 1700) j ON e.DEPARTMENT_ID = j.DEPARTMENT_ID;

#Q3. From the table employees_details, extract the employee_id, first_name, last_name, job_id and department_id who work in  any of the departments of Shipping, Executive and Finance.


SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name),
    e.job_id,
    j.department_id,
    j.department_name
FROM
    employee_details e
        JOIN
    (SELECT 
        department_name, department_id
    FROM
        department_details
    WHERE
        DEPARTMENT_NAME LIKE 'ship%'
            OR DEPARTMENT_NAME LIKE 'admi%'
            OR DEPARTMENT_NAME LIKE 'finan%'
    GROUP BY DEPARTMENT_NAME) j ON e.department_id = j.department_id;

#Q4. Extract employee_id, first_name, last_name,salary, phone_number and email of the CLERKS who earn more than the salary of any IT_PROGRAMMER.

SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name),
    e.salary,
    e.phone_number,
    e.email
FROM
    employee_details e
WHERE
    e.job_id LIKE '%clerk%'
        AND e.salary > any (SELECT 
            salary
        FROM
            employee_details
        WHERE
            job_id LIKE '%IT_PROG%');

#Q5. Extract employee_id, first_name, last_name,salary, phone_number, email of the AC_ACCOUNTANTs who earn a salary more than all the AD_VPs.

SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name),
    e.salary,
    e.phone_number,
    e.email
FROM
    employee_details e
WHERE
    e.job_id LIKE '%accountant%'
        AND e.salary > any (SELECT 
            salary
        FROM
            employee_details
        WHERE
            job_id LIKE '%vp%');

#Q6. Write a Query to display the employee_id, first_name, last_name, department_id of the employees who have been recruited in the recent half timeline since the recruiting began. 

SELECT 
    employee_id,
    CONCAT(first_name, ' ', last_name),
    department_id
FROM
    employee_details
WHERE
    hire_date > (SELECT 
            AVG(hire_date)
        FROM
            employee_details);

#Q7. Extract employee_id, first_name, last_name, phone_number, salary and job_id of the employees belonging to the 'Contracting' department 

SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name),
    e.phone_number,
    e.salary,
    e.job_id
FROM
    employee_details e
        JOIN
    (SELECT 
        department_id
    FROM
        department_details
    WHERE
        department_name LIKE 'contracting') j ON e.department_id = j.department_id;

#Q8. Extract employee_id, first_name, last_name, phone_number, salary and job_id of the employees who does not belong to 'Contracting' department

SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name),
    e.phone_number,
    e.salary,
    e.job_id
FROM
    employee_details e
        JOIN
    (SELECT 
        department_id
    FROM
        department_details
    WHERE
        department_name NOT LIKE 'contracting') j ON e.department_id = j.department_id;

#Q9. Display the employee_id, first_name, last_name, job_id and department_id of the employees who were recruited first in the department

SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name),
    e.job_id,
    e.department_id
FROM
    employee_details e
        JOIN
    (SELECT 
        employee_id, department_id, MIN(hire_date)
    FROM
        employee_details
    GROUP BY department_id
    ORDER BY department_id) j ON e.EMPLOYEE_ID = j.EMPLOYEE_ID;

#Q10. Display the employee_id, first_name, last_name, salary and job_id of the employees who earn maximum salary for every job.

SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name),
    e.salary,
    e.job_id
FROM
    employee_details e
WHERE
    e.salary IN (SELECT 
            t.sal
        FROM
            (SELECT 
                job_id, MAX(salary) AS sal
            FROM
                employee_details
            GROUP BY job_id) t);