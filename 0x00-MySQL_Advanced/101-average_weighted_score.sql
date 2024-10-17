-- Write a SQL script that creates a stored procedure ComputeAverageWeightedScoreForUsers
-- that computes and store the average weighted score for all students.
-- Requirements:
--     Procedure ComputeAverageWeightedScoreForUsers is not taking any input.


DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers ()
BEGIN
    -- Declare variables
    DECLARE user_id INT;
    DECLARE weighted_avg FLOAT;
    
    -- Declare a cursor for iterating through all users
    DECLARE user_cursor CURSOR FOR
    SELECT id FROM users;
    
    -- Declare a handler for the cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET user_id = NULL;
    
    -- Open the cursor
    OPEN user_cursor;
    
    -- Fetch each user_id from the cursor
    user_loop: LOOP
        FETCH user_cursor INTO user_id;
        
        -- If there are no more rows, exit the loop
        IF user_id IS NULL THEN
            LEAVE user_loop;
        END IF;
        
        -- Calculate the weighted average score for the current user
        SELECT SUM(score * weight) / SUM(weight) INTO weighted_avg
        FROM corrections
        WHERE user_id = users_id;
        
        -- Store or output the weighted average for the user
        SELECT user_id AS UserID, weighted_avg AS AverageWeightedScore;
    END LOOP user_loop;
    
    -- Close the cursor
    CLOSE user_cursor;
END; //

DELIMITER ;
