-- Fonction pour vérifier les réservations actives
DELIMITER //

CREATE FUNCTION user_has_active_reservations(user_id INT) 
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE has_reservations BOOLEAN;
    
    SELECT EXISTS (
        SELECT 1
        FROM reservation r
        WHERE r.id_creator = user_id
          AND r.reservation_date >= CURDATE()
          AND r.reservation_status != 'Canceled'
    ) OR EXISTS (
        SELECT 1
        FROM reservation_participant rp
        JOIN reservation r ON rp.id_reservation = r.id_reservation
        WHERE rp.id_user = user_id
          AND r.reservation_date >= CURDATE()
          AND r.reservation_status != 'Canceled'
          AND rp.status != 'Declined'
    ) INTO has_reservations;
    
    RETURN has_reservations;
END //

DELIMITER ;

-- Trigger pour empêcher la suppression d'un utilisateur avec des réservations actives
DELIMITER //

CREATE TRIGGER before_user_delete
BEFORE DELETE ON user
FOR EACH ROW
BEGIN
    IF user_has_active_reservations(OLD.id_user) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete user with active reservations.';
    END IF;
END //

DELIMITER ;
