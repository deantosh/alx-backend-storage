-- Write a SQL script that creates a stored procedure ComputeAverageWeightedScoreForUsers
-- that computes and store the average weighted score for all students.
-- Requirements:
--     Procedure ComputeAverageWeightedScoreForUsers is not taking any input.


DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE current_user_id INT;
    DECLARE weighted_avg FLOAT;
    DECLARE user_cursor CURSOR FOR SELECT id FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open the cursor to iterate through each user
    OPEN user_cursor;

    read_loop: LOOP
        FETCH user_cursor INTO current_user_id;

        -- If no more rows, exit the loop
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Calculate the weighted average score for the current user
        SELECT SUM(c.score * p.weight) / SUM(p.weight) INTO weighted_avg
        FROM corrections c
        JOIN projects p ON c.project_id = p.id
        WHERE c.user_id = current_user_id;

        -- Update the user's average_score in the users table
        UPDATE users
        SET average_score = IFNULL(weighted_avg, 0)
        WHERE id = current_user_id;
    END LOOP;

    -- Close the cursor
    CLOSE user_cursor;
END; //

DELIMITER ;
