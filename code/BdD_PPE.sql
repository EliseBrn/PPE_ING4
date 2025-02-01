-- Create User table
CREATE TABLE user (
    id_user INT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    pseudo VARCHAR(255) UNIQUE NOT NULL,
    birth_date DATE NOT NULL,
    gender VARCHAR(255) DEFAULT NULL,
    photo TEXT DEFAULT NULL,
    inscription_date DATE DEFAULT CURRENT_DATE,
    description TEXT DEFAULT NULL
);

-- Create user_setting table
-- user_setting: cascade car dépend entièrement de l'utilisateur
CREATE TABLE user_setting (
    id_user INT,
    profile_visibility BOOLEAN DEFAULT TRUE,
    first_name_visibility BOOLEAN DEFAULT TRUE,
    birth_date_visibility BOOLEAN DEFAULT FALSE,
    notification_enabled BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_user) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create sport table
CREATE TABLE sport (
    id_sport INT PRIMARY KEY,
    logo TEXT,
    description TEXT DEFAULT NULL
);

-- Create sport_user table
-- sport_user: cascade car ce sont des associations
CREATE TABLE sport_user (
    id_user INT,
    id_sport INT,
    club_name VARCHAR(255) DEFAULT NULL,
    skill_level VARCHAR(255) DEFAULT NULL,
    looking_for_partners BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id_user, id_sport),
    FOREIGN KEY (id_user) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_sport) REFERENCES sport(id_sport) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create badge table
CREATE TABLE badge (
    id_badge INT PRIMARY KEY,
    logo TEXT DEFAULT NULL,
    description TEXT NOT NULL,
    requirements TEXT NOT NULL
);

-- Create badge_user table
-- badge_user: cascade car ce sont des associations
CREATE TABLE badge_user (
    id_user INT,
    id_badge INT,
    date_obtained DATE NOT NULL,
    displayed_on_profile BOOLEAN DEFAULT TRUE,
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
CREATE TABLE match (
    id_user_requester INT,
    id_user_liked INT,
    request_status VARCHAR(255) DEFAULT 'Wait',
    PRIMARY KEY (id_user_requester, id_user_liked),
    FOREIGN KEY (id_user_requester) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_user_liked) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create post table
-- post: cascade car dépend de l'utilisateur qui publie
CREATE TABLE post (
    id_post INT PRIMARY KEY,
    id_publisher INT,
    location VARCHAR(255) DEFAULT NULL,
    post_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    photo TEXT,
    status VARCHAR(255) DEFAULT 'Friends Only',
    description VARCHAR(255) DEFAULT NULL,
    FOREIGN KEY (id_publisher) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create like table
-- like: cascade car dépend du post et de l'utilisateur
CREATE TABLE like (
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
    id_comment INT PRIMARY KEY,
    id_user INT,
    id_post INT,
    content VARCHAR(255),
    comment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_user) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_post) REFERENCES post(id_post) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create conversation table
-- conversation: cascade uniquement pour le créateur
CREATE TABLE conversation (
    id_conversation INT PRIMARY KEY,
    conversation_name VARCHAR(255) NOT NULL,
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
    id_message INT PRIMARY KEY,
    id_user_sender INT DEFAULT 0,
    id_conversation INT,
    content TEXT NOT NULL,
    edited BOOLEAN DEFAULT FALSE,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_user_sender) REFERENCES user(id_user) ON DELETE SET DEFAULT ON UPDATE CASCADE,
    FOREIGN KEY (id_conversation) REFERENCES conversation(id_conversation) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create building table
CREATE TABLE building (
    id_building INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    description TEXT DEFAULT NULL,
    photos TEXT DEFAULT NULL
);

-- Create room table
-- room: cascade car dépend du building
CREATE TABLE room (
    id_room INT PRIMARY KEY,
    id_building INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    description TEXT DEFAULT NULL,
    photos TEXT DEFAULT NULL,
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
    id_reservation INT PRIMARY KEY,
    id_room INT NOT NULL,
    id_creator INT NOT NULL,
    reservation_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    reservation_status VARCHAR(255) DEFAULT 'Pending',
    description TEXT DEFAULT NULL,
    FOREIGN KEY (id_room) REFERENCES room(id_room) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_creator) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create reservation_participant table
-- reservation_participant: cascade car ce sont des associations
CREATE TABLE reservation_participant (
    id_reservation INT NOT NULL,
    id_user INT NOT NULL,
    status VARCHAR(255) DEFAULT 'Invited',
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
    is_booked BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (id_room, available_date, start_time, end_time),
    FOREIGN KEY (id_room) REFERENCES room(id_room) ON DELETE CASCADE ON UPDATE CASCADE
);
