CREATE TABLE patients(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE,
);

CREATE TABLE mediacal_histories(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE treatments(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type VARCHAR(255),
    name VARCHAR(255),
);

CREATE TABLE invoices(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    mediacal_history_id INT,
    FOREIGN KEY (mediacal_history_id) REFERENCES mediacal_histories(id)
);

CREATE TABLE invoice_items(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT,
    treatment_id INT,
    FOREIGN KEY (invoice_id) REFERENCES invoices(id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(id),
);

CREATE TABLE mediacal_histories_treatments(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    mediacal_histories_id INT,
    treatments_id INT,
    FOREIGN KEY (mediacal_histories_id) REFERENCES mediacal_histories(id),
    FOREIGN KEY (treatments_id) REFERENCES treatments(id)
);

CREATE INDEX patient_id_asc ON mediacal_histories(patient_id);
CREATE INDEX mediacal_history_id_asc ON invoices(mediacal_history_id);
CREATE INDEX invoice_id_asc ON invoice_items(invoice_id);
CREATE INDEX treatment_id_asc ON invoice_items(treatment_id);
CREATE INDEX mediacal_histories_id_asc ON mediacal_histories_treatments(mediacal_histories_id);
CREATE INDEX treatments_id_asc ON mediacal_histories_treatments(treatments_id);
