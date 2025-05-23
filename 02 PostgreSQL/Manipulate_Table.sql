-- Create a table called job_aplied so we can track all the jobs we've applied to.

-- Create a job_applied table

CREATE TABLE job_applied(
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);

-- Include information about the job title, company name, date applied, and status of the application.

INSERT INTO job_applied (
    job_id,
    application_sent_date,
    custom_resume,
    resume_file_name,
    cover_letter_sent,
    cover_letter_file_name,
    status
)

VALUES (1,
        '2024-02-01',
        TRUE,
        'resume_01.pdf',
        TRUE,
        'cover_letter_01.pdf',
        'Submitted'),  
        (2,
        '2024-02-02',
        FALSE,
        'resume_02.pdf',
        FALSE,
        NULL,
        'interview scheduled'),  
        (3,
        '2024-02-03',
        TRUE,
        'resume_03.pdf',
        TRUE,
        'cover_letter_03.pdf',
        'Accepted'),  
        (4,
        '2024-02-04',
        FALSE,        
        NULL,
        FALSE,
        NULL,
        'Submited'),  
        (5,
        '2024-02-05',
        FALSE,
        'resume_05.pdf',
        TRUE,
        'cover_letter_05.pdf',
        'Rejected');

-- Let's check the data in the job_applied table
SELECT * 
FROM job_applied;

-- ALTER TABLE: used to select the table that you will add,
-- delete, or modify columns in the table.

-- Add a column to the job_applied table to track the company name.
ALTER TABLE job_applied
ADD contact VARCHAR(255);

-- UPDATE: used to modify the existing records in a table.
UPDATE job_applied
SET contact = 'Google'
WHERE job_id = 1;

UPDATE job_applied
SET contact = 'APPLE'
WHERE job_id = 2;

UPDATE job_applied
SET contact = 'SAMSUNG'
WHERE job_id = 3;

UPDATE job_applied
SET contact = 'ACUITY'
WHERE job_id = 4;

UPDATE job_applied
SET contact = 'AMAZON'
WHERE job_id = 5;

SELECT*
FROM job_applied;

-- RENAME COLUMN: used to rename a column in an existing table.
ALTER TABLE job_applied
RENAME contact TO contact_name;

SELECT*
FROM job_applied;

-- ALTER COLUMN TO CHANGE TYPE (NUMERIC, INT, VARCHAR)

ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;

-- DROP COLUMN: used to delete a column in an existing table.

ALTER TABLE job_applied
DROP COLUMN contact_name;

-- DROP TABLE: used to delete a table in the database.

DROP TABLE job_applied;


