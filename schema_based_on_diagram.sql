-- create patients table with id as parent key
CREATE TABLE patients (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(75) NOT NULL,
	date_of_birth DATE NOT NULL
);
--extra info: The patients table shares a one to many relationship with the medical histories tsblr

-- create medical histories table, make id its primary key and patient_id its foreign keywhich references the id column from the patients table


CREATE TABLE medical_histories (
id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	admitted_at TIMESTAMP,
	patient_id INT NOT NULL,
	status VARCHAR(75),
	CONSTRAINT fk_patient
	FOREIGN KEY(patient_id)
	REFERENCES patients(id)
);


-- create treatments table with id as parent key
CREATE TABLE treatments (
id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	type VARCHAR(75) NOT NULL,
	name VARCHAR(75) NOT NULL
);
-- extra info: The treatments table shares a many to many relationship with the medical histories table and a one to many relationship with the invoice items table

-- create invoices table with id as its primary key and medical_history_id as its foreign key which references the medical_histories table
CREATE TABLE invoices (
id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	total_amount DECIMAL,
	generated_at TIMESTAMP,
	payed_at TIMESTAMP,
	medical_history_id INT,
	CONSTRAINT fk_med_history
	FOREIGN KEY(medical_history_id)
	REFERENCES medical_histories(id)
);
-- extra info: The invoices table shares a one and only one relationship with the medical_histories table and also a one to many relationship with the invoice items table


-- create the invoice_items table with id as its primary key, then invoice_id and treatment_id columns as foreign keys which references the invoices and treatments tables respectively
CREATE TABLE invoice_items (
id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	unit_price DECIMAL NOT NULL,
	quantity INT NOT NULL,
	total_price DECIMAL,
	invoice_id INT,
	treatment_id INT,
	CONSTRAINT fk_invoice
	FOREIGN KEY(invoice_id)
	REFERENCES invoices(id),
	CONSTRAINT fk_treatment
	FOREIGN KEY(treatment_id)
	REFERENCES treatments(id)
);
-- extra info: The invoice items table has a many to one relationship with both the invoices and treatments tables