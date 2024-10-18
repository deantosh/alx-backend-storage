-- Write a SQL script that creates a stored procedure ComputeAverageWeightedScore
-- ForUser that computes and store the average weighted score for a student.
-- Requirements:
--    Procedure ComputeAverageScoreForUser is taking 1 input:
--    user_id, a users.id value (you can assume user_id is linked to an
--    existing users)


DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUser (
    IN user_id INT
)
BEGIN
    DECLARE weighted_avg FLOAT;

    -- Calculate the weighted average score for the given user
    SELECT SUM(c.score * p.weight) / SUM(p.weight) INTO weighted_avg
    FROM corrections c
    JOIN projects p ON c.project_id = p.id
    WHERE c.user_id = user_id;

    -- Update the user's average_score in the users table
    UPDATE users
    SET average_score = IFNULL(weighted_avg, 0)
    WHERE id = user_id;

END; //

DELIMITER ;
