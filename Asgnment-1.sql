CREATE TABLE Dept(
DeptNo INT,
Dname VARCHAR(20),
Loc VARCHAR(50),
PRIMARY KEY(DeptNo)
);

CREATE TABLE Emp(
EmpNo INT PRIMARY KEY,
Ename VARCHAR(20),
Sal INT,
Hire_Date DATE,
Commission INT,
DeptNo INT,
Mgr INT);

INSERT INTO Dept VALUES(10 ,'Accounts', 'Bangalore');
INSERT INTO Dept VALUES(20 ,'IT', 'Delhi');
INSERT INTO Dept VALUES(30 ,'Production', 'Chennai');
INSERT INTO Dept VALUES(40 ,'Sales', 'Hyd');
INSERT INTO Dept VALUES(50 ,'Admn', 'London');

INSERT INTO Emp VALUES(1001, 'Sachin', 19000, '1980-01-01', 2100, 20, 1003);
INSERT INTO Emp VALUES(1002, 'Kapil', 15000, '1970-01-01', 2300, 10, 1003);
INSERT INTO Emp VALUES(1003, 'Stefen', 12000, '1990-01-01', 500, 20, 1007);
INSERT INTO Emp VALUES(1004, 'Williams', 9000, '2001-01-01', NULL, 30, 1007);
INSERT INTO Emp VALUES(1005, 'John', 5000, '2005-01-01', NULL, 30, 1006);
INSERT INTO Emp VALUES(1006, 'Dravid', 19000, '1985-01-01', 2400, 10, 1007);
INSERT INTO Emp VALUES(1007, 'Martin', 21000, '2000-01-01', 1040, NULL, NULL);


-- 1. Select employee details  of dept number 10 or 30
SELECT * FROM Emp;
SELECT * FROM Dept;
SELECT *
FROM Emp
WHERE DeptNo = 10 OR DeptNo = 30;

-- 2. Write a query to fetch all the dept details with more than 1 Employee.

SELECT d.DeptNo,d.Dname,d.Loc
FROM Dept d
INNER JOIN Emp e ON d.DeptNo = e.DeptNo
GROUP BY d.DeptNo,d.Dname,d.Loc
HAVING COUNT(e.EmpNo) > 1;

-- 3. Write a query to fetch employee details whose name starts with the letter “S”

SELECT *  
FROM Emp
WHERE Ename LIKE 's%';

-- 4.Select Emp Details Whose experience is more than 2 years

SELECT * 
FROM Emp
WHERE DATEDIFF(CURDATE(), Hire_Date) > 2 ;


-- 5. Write a SELECT statement to replace the char “a” with “#” in Employee Name ( Ex:  Sachin as S#chin)

SELECT Ename, REPLACE(Ename, 'a', '#')  AS Modified_name
FROM Emp;

-- 6.Write a query to fetch employee name and his/her manager name. 

SELECT e.Ename AS Employee_Name, m.Ename AS Manager_Name
FROM Emp e
JOIN Emp m ON e.Mgr = m.EmpNo;

-- 7.Fetch Dept Name , Total Salry of the Dept

SELECT d.Dname AS Department_Name, SUM(e.sal) AS Total_Salary
FROM Dept d
JOIN Emp e ON d.DeptNo = e.DeptNo
GROUP BY Dname;


-- 8.Write a query to fetch ALL the  employee details along with department name, department location, irrespective of employee existance in the department.

SELECT e.EmpNo, e.Ename, e.Sal, e.Hire_Date, e.Commission, e.DeptNo, e.Mgr, d.Dname AS Department_Name, d.Loc AS Department_Location
FROM Emp e
LEFT JOIN Dept d ON e.DeptNo = d.DeptNo;

-- 9.Write an update statement to increase the employee salary by 10 %

UPDATE Emp
SET Sal = Sal + (Sal * 0.1);

-- 10.Write a statement to delete employees belong to Chennai location.

DELETE FROM Emp
WHERE DeptNo IN(
SELECT DeptNo
FROM Dept
WHERE Loc = 'Chennai');

SELECT * FROM Emp;

-- 11.Get Employee Name and gross salary (sal + comission) 

SELECT Ename AS Employee_Name , Sal + COALESCE(Commission,0)  AS Gross_Salary
FROM Emp;

-- 12.Increase the data length of the column Ename of Emp table from  100 to 250 using ALTER statement

ALTER TABLE Emp  
MODIFY COLUMN Ename varchar(250);

DESCRIBE Emp;

-- 13.Write query to get current datetime

SELECT current_timestamp() AS CURRENT_DATETIME

-- 14.Write a statement to create STUDENT table, with related 5 columns

CREATE TABLE STUDENT(
Student_ID INT PRIMARY KEY,
FirstName VARCHAR(50),
SecondName VARCHAR(50),
Age INT,
Gender VARCHAR(1)
);

SELECT * FROM STUDENT;
DESCRIBE STUDENT;

--  15.Write a query to fetch number of employees in who is getting salary more than 10000

SELECT COUNT(*) AS Employee_Count
FROM Emp
WHERE Sal > 10000;

-- 16. Write a query to fetch minimum salary, maximum salary and average salary from emp table.

SELECT MIN(Sal) AS Min_Salary,MAX(Sal) AS Max_Salary,AVG(Sal) AS Avg_Salary
FROM Emp;


-- 17.Write a query to fetch number of employees in each location

SELECT Loc AS Location, COUNT(*) AS Employee_Count
FROM Dept d
JOIN Emp e ON d.DeptNo = e.DeptNo
GROUP BY Loc;

-- 18.Write a query to display emplyee names in descending order

select Ename AS EmployeeName
from Emp
order by Ename desc;

-- 19.Write a statement to create a new table(EMP_BKP) from the existing EMP table 

create table Emp_BKP as
select * from Emp;

select * from Emp_BKP;

-- 20.Write a query to fetch first 3 characters from employee name appended with salary.

select concat(left(Ename,3),Sal) as EmployeeName_Salary
from Emp;

 -- 21.Get the details of the employees whose name starts with S
 
select * 
from Emp
where Ename like 's%';

-- 22.Get the details of the employees who works in Bangalore location

select e.*
from Emp e
join Dept d on e.Deptno = d.Deptno
where d.loc ='Bangalore';

-- 23.Write the query to get the employee details whose name started within  any letter between  A and K

Select e.*
from Emp e
where Ename between 'A' and 'K';

-- 24.Write a query in SQL to display the employees whose manager name is Stefen 

-- select * from Emp
-- where Mgr = 1003;

select e.Ename, m.Ename
from Emp e
inner join Emp m on e.Mgr= m.EmpNo
where m.Ename = 'Stefen';

 -- 25.Write a query in SQL to list the name of the managers who is having maximum number of employees working under him

select e2.Ename as Manager_name, count(*) as Employee_count
from Emp e1
join Emp e2 on e1.Mgr = e2.EmpNo
group by e2.Ename
having count(*) = (
select count(*) as maxEmployee_count
from Emp
where Mgr is not null
group by Mgr
order by maxEmployee_count Desc
limit 1
);

-- 26.Write a query to display the employee details, department details and the manager details of the employee who has second highest salary


select e.*,d.Dname,d.Loc
from Emp e
left join Dept d on e.DeptNo = d.DeptNo 
where Sal <(
select max(Sal)
from Emp )
limit 1;

select e.*,d.Dname,d.Loc
from Emp e
left join Dept d on e.DeptNo = d.DeptNo 
order by sal desc
limit 1,1;

-- 27) Write a query to list all details of all the managers

select e.*,m.Ename as Manager_name
from Emp e
inner join Emp m on e.Mgr = m.EmpNo;

select * from Emp;

-- 28) Write a query to list the details and total experience of all the managers

select m.Ename,m.EmpNo,m.Hire_Date as Manager_HireDate, count(datediff(curdate(),m.Hire_Date)) as total_Experience
from Emp e
join Emp m on e.Mgr = m.EmpNo
group by m.EmpNo,m.Ename,m.Hire_Date;

-- 29.Write a query to list the employees who is manager and  takes commission less than 1000 and works in Delhi

select e.EmpNo,e.Ename,e.Commission
from Emp e
join Emp m on e.EmpNo = m.Mgr
join Dept d on e.DeptNo = d.DeptNo
where e.Commission < 3000 and d.Loc = 'Delhi';

-- 30.Write a query to display the details of employees who are senior to Martin 

select e.*
from Emp e
where Hire_date < (
select Hire_date
from Emp
where Ename = 'Martin');


