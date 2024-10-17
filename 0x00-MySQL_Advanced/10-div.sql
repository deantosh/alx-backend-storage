-- Write a SQL script that creates a function SafeDiv that divides (and returns)
-- the first by the second number or returns 0 if the second number is equal to 0.
-- Requirements:
--   You must create a function
--   The function SafeDiv takes 2 arguments:
--   a, INT
--   b, INT
--   And returns a / b or 0 if b == 0


DELIMITER //

CREATE FUNCTION SafeDiv(a INT, b INT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE results FLOAT
	
	-- If second value not 0
    IF b <> 0 THEN
	    SET results = a / b;
	ELSE
	    SET results = 0;
	END IF

	RETURNS results;
	
END; //

DELIMITER ;
