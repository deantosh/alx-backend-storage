-- Write a SQL script that creates a trigger that resets the attribute valid_email
-- only when the email has been changed.

DELIMITER //

CREATE TRIGGER reset_email_on_update
    AFTER UPDATE ON users
	FOR EACH ROW
BEGIN
    IF NEW.email <> OLD.email THEN
        UPDATE users
	    SET valid_email = DEFAULT;
	    WHERE id = NEW.id
	END IF;
END; //

DELIMITER ;
