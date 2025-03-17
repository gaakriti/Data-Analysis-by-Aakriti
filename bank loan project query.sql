select * from bank_loan_data

---total loan application
select COUNT(id) as 'total loan application' from bank_loan_data

----- MTD loan application
select COUNT(id) as 'MTD loan application' from bank_loan_data
where MONTH(issue_date)=12 and YEAR(issue_date)= 2021


-----previous month PMTD loan application {(MTD-PMTD)/PMTD}
select COUNT(id) as 'PMTD loan application' from bank_loan_data
where MONTH(issue_date)=11 and YEAR(issue_date)= 2021

---- total funded amount
select sum(loan_amount) as 'total funded amount' from bank_loan_data

---- total funded amount MTD
select sum(loan_amount) as ' MTD total funded amount' from bank_loan_data
where MONTH(issue_date)= 12 and YEAR(issue_date)=2021


---- total funded amount PMTD
select sum(loan_amount) as ' PMTD total funded amount' from bank_loan_data
where MONTH(issue_date)= 11 and YEAR(issue_date)=2021

-----total recieved amount
select sum(total_payment) as 'total recieved amount' from bank_loan_data

---- total recieved amount MTD
select sum(total_payment) as ' MTD total recieved amount' from bank_loan_data
where MONTH(issue_date)= 12 and YEAR(issue_date)=2021


---- total recieved amount PMTD
select sum(total_payment) as ' PMTD total recieved amount' from bank_loan_data
where MONTH(issue_date)= 11 and YEAR(issue_date)=2021


-------average interest rate across all loans
select round(avg(int_rate), 4) *100 as 'average interest rate' from bank_loan_data


-------MOM average interest rate across all loans
select round(avg(int_rate), 4) *100 as 'MOM average interest rate' from bank_loan_data
where month(issue_date)= 12 and YEAR(issue_date)=2021


-------PMTD average interest rate across all loans
select round(avg(int_rate), 4) *100 as 'PMTD average interest rate' from bank_loan_data
where month(issue_date)= 11 and YEAR(issue_date)=2021


-------DTI average of all loans
select round(avg(dti), 4) *100 as 'average dti' from bank_loan_data

-------MOM dti of all loans
select round(avg(dti), 4) *100 as 'MoM dti' from bank_loan_data
where month(issue_date)= 12 and YEAR(issue_date)=2021


-------PMTD dti of all loans
select round(avg(dti), 4) *100 as 'PMTD dti' from bank_loan_data
where month(issue_date)= 11 and YEAR(issue_date)=2021


---------good loan percentage
select 
	(COUNT (case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end)*100)
	/
	count(id) as 'Good_loan_percentage'
	
From bank_loan_data

---------- Good Loan Applications
select COUNT(id) as 'Good loan application' from bank_loan_data
where loan_status= 'Fully Paid' or loan_status='Current'


----------Good Loan Funded Amount
select sum(loan_amount) as 'Good loan Funded Amount' from bank_loan_data
where loan_status= 'Fully Paid' or loan_status='Current'


----------Good Loan Total Received Amount
select sum(total_payment) as 'Good loan Total Received Amount' from bank_loan_data
where loan_status= 'Fully Paid' or loan_status='Current'



--Bad Loan Application Percentage
select 
	(COUNT (case when loan_status = 'Charged off' then id end)*100)
	/
	count(id) as 'Bad_loan_percentage'
From bank_loan_data

--Bad Loan Applications
select COUNT(id) as 'Bad loan application' from bank_loan_data
where loan_status= 'Charged off'

--Bad Loan Funded Amount
select sum(loan_amount) as 'Bad loan Funded Amount' from bank_loan_data
where loan_status= 'Charged off'


--Bad Loan Total Received Amount
select sum(total_payment) as 'Bad loan Total Received Amount' from bank_loan_data
where loan_status= 'Charged off'

------loan status

SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG (dti* 100) AS DTI
    FROM
        bank_loan_data
    GROUP BY
        loan_status

--Monthly Trends by Issue Date 

select
	MONTH(issue_date) as 'Month_number',
	DATENAME(month,issue_date) as Month_name,
	COUNT(id) as Total_Loan_Applications,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Amount_Recieved
from bank_loan_data
group by MONTH(issue_date), DATENAME(month,issue_date)
order by month(issue_date)


--Regional Analysis by State

select
    address_state as State,
	COUNT(id) as Total_Loan_Applications,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Amount_Recieved
from bank_loan_data
group by address_state
order by address_state


--Loan Term Analysis 

select
    term as Loan_Term,
	COUNT(id) as Total_Loan_Applications,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Amount_Recieved
from bank_loan_data
group by term
order by term

--Employee Length Analysis 

select
    emp_length as Employee_length,
	COUNT(id) as Total_Loan_Applications,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Amount_Recieved
from bank_loan_data
group by emp_length
order by COUNT(id) desc


--Loan Purpose Breakdown 
select
    purpose as Loan_purpose,
	COUNT(id) as Total_Loan_Applications,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Amount_Recieved
from bank_loan_data
group by purpose
order by COUNT(id) desc
  

--Home Ownership Analysis 

select
    home_ownership,
	COUNT(id) as Total_Loan_Applications,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Amount_Recieved
from bank_loan_data
group by home_ownership
order by COUNT(id) desc