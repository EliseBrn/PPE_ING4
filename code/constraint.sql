-- Table user
ALTER TABLE user
ADD CONSTRAINT check_email CHECK (email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
ADD CONSTRAINT check_birth_date CHECK (birth_date <= CURRENT_DATE),
ADD CONSTRAINT check_password_length CHECK (LENGTH(password) >= 8);

-- Table sport_user
ALTER TABLE sport_user
ADD CONSTRAINT check_skill_level CHECK (skill_level IN ('Beginner', 'Intermediate', 'Advanced', 'High Level'));

-- Table reservation
ALTER TABLE reservation
ADD CONSTRAINT check_reservation_time CHECK (start_time < end_time);

-- Table room_availability
ALTER TABLE room_availability
ADD CONSTRAINT check_availability_time CHECK (start_time < end_time);
