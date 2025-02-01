-- Creation des différentes tables

-- Create User table
CREATE TABLE user (
    id_user INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    pseudo VARCHAR(50) UNIQUE NOT NULL,
    birth_date DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other', 'No Answer') DEFAULT 'No Answer',
    photo VARCHAR(255) DEFAULT NULL,
    inscription_date DATE DEFAULT CURRENT_DATE,
    description TEXT DEFAULT NULL
);

-- Create user_setting table
-- user_setting: cascade car dépend entièrement de l'utilisateur
CREATE TABLE user_setting (
    id_user INT PRIMARY KEY,
    profile_visibility TINYINT(1) DEFAULT 1,
    first_name_visibility TINYINT(1) DEFAULT 1,
    birth_date_visibility TINYINT(1) DEFAULT 0,
    notification_enabled TINYINT(1) DEFAULT 0,
    FOREIGN KEY (id_user) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create sport table
CREATE TABLE sport (
    id_sport INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    logo VARCHAR(255) DEFAULT NULL,
    description TEXT DEFAULT NULL
);

-- Create sport_user table
-- sport_user: cascade car ce sont des associations
CREATE TABLE sport_user (
    id_user INT,
    id_sport INT,
    club_name VARCHAR(100) DEFAULT NULL,
    skill_level ENUM('Beginner', 'Intermediate', 'Advanced', 'High Level') DEFAULT 'Beginner',
    looking_for_partners TINYINT(1) DEFAULT 1,
    PRIMARY KEY (id_user, id_sport),
    FOREIGN KEY (id_user) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_sport) REFERENCES sport(id_sport) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create badge table
CREATE TABLE badge (
    id_badge INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    logo VARCHAR(255) DEFAULT NULL,
    description TEXT NOT NULL,
    requirements TEXT NOT NULL
);

-- Create badge_user table
-- badge_user: cascade car ce sont des associations
CREATE TABLE badge_user (
    id_user INT,
    id_badge INT,
    date_obtained DATE NOT NULL,
    displayed_on_profile TINYINT(1) DEFAULT 1,
    PRIMARY KEY (id_user, id_badge),
    FOREIGN KEY (id_user) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_badge) REFERENCES badge(id_badge) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create friendship table
-- friendship: cascade car dépend des utilisateurs
CREATE TABLE friendship (
    id_user_follower INT,
    id_user_followed INT,
    follow_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_user_follower, id_user_followed),
    FOREIGN KEY (id_user_follower) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_user_followed) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create match table
-- match: cascade car dépend des utilisateurs
CREATE TABLE `match` (
    id_user_requester INT,
    id_user_liked INT,
    request_status ENUM('Wait', 'Accepted', 'Declined') DEFAULT 'Wait',
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_user_requester, id_user_liked),
    FOREIGN KEY (id_user_requester) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_user_liked) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create post table
-- post: cascade car dépend de l'utilisateur qui publie
CREATE TABLE post (
    id_post INT AUTO_INCREMENT PRIMARY KEY,
    id_publisher INT,
    location VARCHAR(255) DEFAULT NULL,
    post_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    photo VARCHAR(255) DEFAULT NULL,
    status ENUM('Private', 'Friends', 'Public') DEFAULT 'Friends',
    description VARCHAR(500) DEFAULT NULL,
    FOREIGN KEY (id_publisher) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create like table
-- like: cascade car dépend du post et de l'utilisateur
CREATE TABLE `like` (
    id_user INT DEFAULT 0,
    id_post INT,
    like_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_user, id_post),
    FOREIGN KEY (id_user) REFERENCES user(id_user) ON DELETE SET DEFAULT ON UPDATE CASCADE,
    FOREIGN KEY (id_post) REFERENCES post(id_post) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create comment table
-- comment: cascade car dépend du post et de l'utilisateur
CREATE TABLE comment (
    id_comment INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT,
    id_post INT,
    content VARCHAR(500) NOT NULL,
    comment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_user) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_post) REFERENCES post(id_post) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create conversation table
-- conversation: cascade uniquement pour le créateur
CREATE TABLE conversation (
    id_conversation INT AUTO_INCREMENT PRIMARY KEY,
    conversation_name VARCHAR(100) NOT NULL,
    id_creator INT,
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_creator) REFERENCES user(id_user) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Create conversation_participant table
-- conversation_participant: cascade car ce sont des associations
CREATE TABLE conversation_participant (
    id_conversation INT,
    id_user INT,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_conversation, id_user),
    FOREIGN KEY (id_conversation) REFERENCES conversation(id_conversation) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_user) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create message table
-- message: cascade car dépend de la conversation
CREATE TABLE message (
    id_message INT AUTO_INCREMENT PRIMARY KEY,
    id_user_sender INT DEFAULT 0,
    id_conversation INT,
    content TEXT NOT NULL,
    edited TINYINT(1) DEFAULT 0,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_user_sender) REFERENCES user(id_user) ON DELETE SET DEFAULT ON UPDATE CASCADE,
    FOREIGN KEY (id_conversation) REFERENCES conversation(id_conversation) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create building table
CREATE TABLE building (
    id_building INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL,
    description TEXT DEFAULT NULL,
    photos VARCHAR(255) DEFAULT NULL
);

-- Create room table
-- room: cascade car dépend du building
CREATE TABLE room (
    id_room INT AUTO_INCREMENT PRIMARY KEY,
    id_building INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL,
    description TEXT DEFAULT NULL,
    photos VARCHAR(255) DEFAULT NULL,
    FOREIGN KEY (id_building) REFERENCES building(id_building) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create sport_in_room table
-- sport_in_room: cascade car ce sont des associations
CREATE TABLE sport_in_room (
    id_room INT NOT NULL,
    id_sport INT NOT NULL,
    PRIMARY KEY (id_room, id_sport),
    FOREIGN KEY (id_room) REFERENCES room(id_room) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_sport) REFERENCES sport(id_sport) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create reservation table
-- reservation: cascade pour la salle
CREATE TABLE reservation (
    id_reservation INT AUTO_INCREMENT PRIMARY KEY,
    id_room INT NOT NULL,
    id_creator INT NOT NULL,
    reservation_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    reservation_status ENUM('Pending', 'Confirmed', 'Canceled') DEFAULT 'Pending',
    description TEXT DEFAULT NULL,
    FOREIGN KEY (id_room) REFERENCES room(id_room) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_creator) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create reservation_participant table
-- reservation_participant: cascade car ce sont des associations
CREATE TABLE reservation_participant (
    id_reservation INT NOT NULL,
    id_user INT NOT NULL,
    status ENUM('Invited', 'Confirmed', 'Declined') DEFAULT 'Invited',
    PRIMARY KEY (id_reservation, id_user),
    FOREIGN KEY (id_reservation) REFERENCES reservation(id_reservation) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_user) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create room_availability table
-- room_availability: cascade car dépend de la salle
CREATE TABLE room_availability (
    id_room INT NOT NULL,
    available_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    is_booked TINYINT(1) DEFAULT 0,
    PRIMARY KEY (id_room, available_date, start_time, end_time),
    FOREIGN KEY (id_room) REFERENCES room(id_room) ON DELETE CASCADE ON UPDATE CASCADE
);
