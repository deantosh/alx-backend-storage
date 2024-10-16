-- Write a SQL script that creates a stored procedure ComputeAverageScoreForUser that
-- computes and store the average score for a student. Note: An average score can be a decimal
-- Requirements:
--   Procedure ComputeAverageScoreForUser is taking 1 input:
--   user_id, a users.id value (you can assume user_id is linked to an existing users)


DELIMITER //

CREATE PROCEDURE ComputeAverageScoreForUser (
    IN input_user_id INT
)
BEGIN
    DECLARE average_score FLOAT;

    -- Compute the average student score
    SELECT AVG(score) INTO average_score
    FROM corrections
    WHERE user_id = input_user_id;

    -- Insert into users
    UPDATE users
    SET average_score = average_score
    WHERE id = input_user_id;

END; //

DELIMITER ;
