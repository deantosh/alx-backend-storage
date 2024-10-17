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

    -- Calculate the weighted average score
    SELECT SUM(score * weight) / SUM(weight) INTO weighted_avg
    FROM corrections
    WHERE user_id = users_id;

    -- Return the weighted average
    SELECT weighted_avg AS AverageWeightedScore;
END; //

DELIMITER ;
