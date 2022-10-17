-- Starting with customer table
-- Creating customer using stored funciton
CREATE FUNCTION adding_customer(
    customer_id INTEGER,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
)
RETURNS VOID
LANGUAGE plpgsql
AS
$MAIN$
BEGIN
    INSERT INTO customer(customer_id, first_name, last_name)
    VALUES(customer_id, first_name, last_name);
END
$MAIN$;

SELECT adding_customer(45, 'Diante', 'Dowdell');
SELECT adding_customer(33, 'Richard', 'Davis');

INSERT INTO customer(
    first_name,
    last_name,
    phone,
    email
)
VALUES (
    'Shay',
    'Cook',
    '(712) 654-5620',
    NULL
),
(
    'Stewart',
    'Highborne',
    NULL,
    'shighborne@email.com'
),
(
    'Finnegan',
    'Rose',
    '(555) 687-0026',
    'roses@email.com'
);

INSERT INTO car(
    make,
    model,
    isNew,
    customer_id
)
VALUES (
    'Hyundai',
    'Elantra',
    False,
    45
),
(
    'Volkswagen',
    'Jetta',
    False,
    1
);

-- Adding cars to car table
-- Stored function to add car easily
CREATE FUNCTION adding_car(
    make VARCHAR(50),
    model VARCHAR(50),
    isNew BOOLEAN,
    customer_id INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
AS
$MAIN$
BEGIN
    INSERT INTO car(make, model, isNew, customer_id)
    VALUES(make, model, isNew, customer_id);
END
$MAIN$;

SELECT adding_car('Bentley', 'Bentayga', True, 1);
SELECT adding_car('Cadillac', 'CTS', True, 3);
SELECT adding_car('Acura', 'EL', FALSE, 2);
SELECT adding_car('BMW', '750I', FALSE, 33);

-- Adding function to add cars with no customers, as we are a dealership that has cars on hand.

CREATE FUNCTION adding_car_no_customer(
    make VARCHAR(50),
    model VARCHAR(50),
    isNew BOOLEAN
)
RETURNS VOID
LANGUAGE plpgsql
AS
$MAIN$
BEGIN
    INSERT INTO car(make, model, isNew)
    VALUES(make, model, isNew);
END
$MAIN$;

SELECT adding_car_no_customer('Nissan','Altima',FALSE);
SELECT adding_car_no_customer('Lexus', 'RX', True);

-- Adding employees
INSERT INTO employees(
    first_name,
    last_name,
    job_title
)
VALUES (
    'Kenneth',
    'Beasley',
    'Mechanic'
),
(
    'Davis',
    'Cole',
    'Mechanic'
),
(
    'Joseph',
    'Vespar',
    'Mechanic'
),
(
    'Josh',
    'Spinella',
    'Salesperson'
),
(
    'Ashley',
    'Daniels',
    'Salesperson'
),
(
    'LL',
    'Cool J',
    'Salesperson'
);

-- Adding invoices
CREATE FUNCTION adding_invoices(
    employee_id INTEGER,
    customer_id INTEGER,
    car_id INTEGER
)
RETURNS VOID
LANGUAGE plpgsql
AS
$MAIN$
BEGIN
    INSERT INTO invoice(employee_id, customer_id, car_id)
    VALUES(employee_id, customer_id, car_id);
END
$MAIN$;

SELECT adding_invoices (1,45,1);
SELECT adding_invoices (4,45,1);
 
-- Deleting data from invoice table as I added mechanic id instead of salesperson id
DELETE FROM invoice
WHERE employee_id = 1;

SELECT adding_invoices (4,1,2);
SELECT adding_invoices (4,1,3);
SELECT adding_invoices (4,3,6);

DELETE FROM invoice
WHERE employee_id = 4 AND car_id = 6;

SELECT adding_invoices (6,3,6);

DELETE FROM invoice
WHERE employee_id = 4 AND car_id = 2;

SELECT adding_invoices (5,1,2);

-- Added minor complications (from deleting inside of table) with invoice id 
-- changing, but overall still correct information

-- Adding service tickets

CREATE FUNCTION adding_service_ticket(
    employee_id INTEGER,
    customer_id INTEGER,
    car_id INTEGER,
    service_rendered VARCHAR(100)
)
RETURNS VOID
LANGUAGE plpgsql
AS
$MAIN$
BEGIN
    INSERT INTO service_ticket(employee_id, customer_id, car_id, service_rendered)
    VALUES(employee_id, customer_id, car_id, service_rendered);
END
$MAIN$;

SELECT adding_service_ticket(1,2,7,'Tire Rotation and Oil Change.');
SELECT adding_service_ticket(3,1,3,'Recalibrated Wheel and Oil Change');
SELECT adding_service_ticket(2,1,3,'Recalibrated Wheel and Oil Change');
