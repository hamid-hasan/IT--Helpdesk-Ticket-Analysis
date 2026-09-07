create database it_helpdesk;
use it_helpdesk;

CREATE TABLE employees (
    employee_id VARCHAR(10) PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50)
);
CREATE TABLE engineers (
    engineer_id VARCHAR(10) PRIMARY KEY,
    engineer_name VARCHAR(100),
    specialization VARCHAR(50)
);
CREATE TABLE tickets (
    ticket_id VARCHAR(10) PRIMARY KEY,
    employee_id VARCHAR(10),
    category VARCHAR(50),
    priority VARCHAR(20),
    status VARCHAR(30),
    engineer_id VARCHAR(10),
    created_at DATETIME,
    assigned_at DATETIME,
    resolved_at DATETIME,
    resolution_notes VARCHAR(255),

    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (engineer_id) REFERENCES engineers(engineer_id)
);
INSERT INTO employees (employee_id, employee_name, department)
VALUES
('E001', 'Rahul Sharma', 'Finance'),
('E002', 'Aisha Khan', 'HR'),
('E003', 'Sameer Patel', 'Sales'),
('E004', 'Neha Singh', 'Marketing'),
('E005', 'Arjun Mehta', 'Finance'),
('E006', 'Sara Ali', 'Operations'),
('E007', 'Rohan Shah', 'Sales'),
('E008', 'Priya Nair', 'HR'),
('E009', 'Adil Khan', 'IT'),
('E010', 'Sneha Joshi', 'Marketing');

INSERT INTO engineers (engineer_id, engineer_name, specialization)
VALUES
('IT001', 'Arjun Kumar', 'Network'),
('IT002', 'Priya Verma', 'Hardware'),
('IT003', 'Ahmed Khan', 'Software'),
('IT004', 'Rohan Desai', 'Access'),
('IT005', 'Neha Kapoor', 'Network');

SELECT status, count(*) as t_t
FROM tickets
group by status
order by t_t;

USE it_helpdesk;

SELECT
    category,
    COUNT(*) AS total_tickets
FROM tickets
GROUP BY category
ORDER BY total_tickets DESC;

SELECT
    priority,
    COUNT(*) AS total_tickets
FROM tickets
GROUP BY priority
ORDER BY total_tickets DESC;

SELECT
    priority,
    status,
    COUNT(*) AS total_tickets
FROM tickets
GROUP BY priority, status
ORDER BY priority, total_tickets DESC;

SELECT
    engineer_id,
    COUNT(*) AS total_tickets
FROM tickets
GROUP BY engineer_id
ORDER BY total_tickets DESC;

SELECT
    engineer_id,
    COUNT(*) AS resolved_tickets
FROM tickets
WHERE status = 'Resolved'
GROUP BY engineer_id
ORDER BY resolved_tickets DESC;

SELECT
    engineer_id,
    COUNT(*) AS total_tickets,
    SUM(status = 'Resolved') AS resolved_tickets,
    ROUND(
        SUM(status = 'Resolved') * 100.0 / COUNT(*),
        2
    ) AS resolution_rate
FROM tickets
GROUP BY engineer_id

ORDER BY resolution_rate DESC;

SELECT
    category,
    status,
    COUNT(*) AS total_tickets
FROM tickets
GROUP BY category, status
ORDER BY category, total_tickets DESC;

SELECT
    COUNT(*) AS total_tickets,
    SUM(status = 'Resolved') AS resolved_tickets,
    SUM(status = 'Open') AS open_tickets,
    SUM(status = 'In Progress') AS in_progress_tickets,
    ROUND(SUM(status = 'Resolved') * 100.0 / COUNT(*), 2) AS resolution_rate
FROM tickets;


