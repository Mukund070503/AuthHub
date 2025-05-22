Drop table clients;
Drop table client_challenges;
drop table tokens;
CREATE DATABASE AuthHub;
USE AuthHub;
CREATE TABLE clients (
    id INT PRIMARY KEY,
    service_id VARCHAR(100) NOT NULL UNIQUE,
    client_id VARCHAR(100) NOT NULL UNIQUE,
    Client_name VARCHAR(100) NOT NULL,
    client_secret VARCHAR(255) NOT NULL
);

CREATE TABLE client_challenges (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id VARCHAR(100) NOT NULL,
    challenge_type VARCHAR(50) NOT NULL CHECK (challenge_type IN ('adhar', 'pan')),
    token_type VARCHAR(50) NOT NULL CHECK (token_type IN ('Access', 'Session')),
    FOREIGN KEY (client_id) REFERENCES clients(client_id) 
);

CREATE TABLE tokens (
    id SERIAL PRIMARY KEY,
    client_challenge_id INT NOT NULL,
    token_type VARCHAR(50) NOT NULL CHECK (token_type IN ('Access', 'Session')),
    token_value TEXT NOT NULL,
	challenge_value VARCHAR(100) NOT NULL UNIQUE,
    issued_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (client_challenge_id) REFERENCES client_challenges(id)
);

SHOW TABLES;

SELECT * FROM clients;
SELECT * FROM client_challenges;
SELECT * FROM tokens;

INSERT INTO clients (id, service_id, client_id, Client_name, client_secret)
VALUES 
(1, 'svc_001', 'cl_001', 'Client One', 'secret_123'),
(2, 'svc_002', 'cl_002', 'Client Two', 'secret_456');

INSERT INTO client_challenges (client_id, challenge_type, token_type)
VALUES 
('cl_001', 'adhar', 'Access'),
('cl_001', 'pan', 'Session');

INSERT INTO client_challenges (client_id, challenge_type, token_type)
VALUES 
('cl_002', 'adhar', 'Session'),
('cl_002', 'pan', 'Access');

DELETE FROM client_challenges;
SET SQL_SAFE_UPDATES = 0;

INSERT INTO tokens (client_challenge_id, token_type, token_value, challenge_value)
VALUES
(1, 'Access', 'token_val_1', '35545665'),
(2, 'Session', 'token_val_2', '2444I54A'),
(3, 'Session', 'token_val_3', '95574643'),
(4, 'Access', 'token_val_4', '67435PAN');

ALTER TABLE client_challenges ADD Challenge_order int;

UPDATE client_challenges SET Challenge_order=1 WHERE id=2;

ALTER TABLE clients
CHANGE COLUMN Client_name client_name VARCHAR(100) NOT NULL;

update tokens set token_value=null where client_challenge_id=3;

ALTER TABLE tokens MODIFY token_value TEXT NULL;
UPDATE tokens SET token_value = NULL WHERE client_challenge_id = 4;

UPDATE client_challenges 
SET challenge_type = 'adhar' 
WHERE id = 3 OR id = 5;

