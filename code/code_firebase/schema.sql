-- Creation des différentes tables

-- Create User table
CREATE TABLE app_user (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    first_name VARCHAR(50) NOT NULL,
    pseudo VARCHAR(50) UNIQUE NOT NULL,
    birth_date DATE NOT NULL,
    gender TEXT CHECK (gender IN ('Male', 'Female', 'Other', 'No Answer')) DEFAULT 'No Answer',
    photo VARCHAR(255) DEFAULT NULL,
    inscription_date DATE DEFAULT CURRENT_DATE,
    description TEXT DEFAULT NULL
);

-- Create user_setting table
CREATE TABLE user_setting (
    id_user INTEGER PRIMARY KEY,
    profile_visibility BOOLEAN DEFAULT TRUE, -- visibility du profil pour les matchs
    first_name_visibility BOOLEAN DEFAULT TRUE, -- visibility du prénoms
    birth_date_visibility BOOLEAN DEFAULT TRUE, -- visibility de la date de naissance
    notification_enabled BOOLEAN DEFAULT FALSE, -- désactivation des notifs
    FOREIGN KEY (id_user) REFERENCES app_user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create sport table
CREATE TABLE sport (
    id_sport SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    logo VARCHAR(255) DEFAULT NULL,
    description TEXT DEFAULT NULL
);

-- Create sport_user table
CREATE TABLE sport_user (
    id_user INTEGER,
    id_sport INTEGER,
    club_name VARCHAR(100) DEFAULT NULL,
    skill_level TEXT CHECK (skill_level IN ('Beginner', 'Intermediate', 'Advanced', 'High Level')) DEFAULT 'Beginner',
    looking_for_partners BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id_user, id_sport),
    FOREIGN KEY (id_user) REFERENCES app_user(id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_sport) REFERENCES sport(id_sport) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create badge table
CREATE TABLE badge (
    id_badge SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    logo VARCHAR(255) DEFAULT NULL,
    description TEXT NOT NULL,
    requirements TEXT NOT NULL
);

-- Create badge_user table
CREATE TABLE badge_user (
    id_user INTEGER,
    id_badge INTEGER,
    date_obtained DATE NOT NULL,
    displayed_on_profile BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id_user, id_badge),
    FOREIGN KEY (id_user) REFERENCES app_user(id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_badge) REFERENCES badge(id_badge) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create friendship table
CREATE TABLE friendship (
    id_user_follower INTEGER,
    id_user_followed INTEGER,
    follow_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_user_follower, id_user_followed),
    FOREIGN KEY (id_user_follower) REFERENCES app_user(id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_user_followed) REFERENCES app_user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create match table
CREATE TABLE match_user (
    id_user_requester INTEGER,
    id_user_liked INTEGER,
    request_status TEXT CHECK (request_status IN ('Wait', 'Accepted', 'Declined')) DEFAULT 'Wait',
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_user_requester, id_user_liked),
    FOREIGN KEY (id_user_requester) REFERENCES app_user(id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_user_liked) REFERENCES app_user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create post table
CREATE TABLE post (
    id_post SERIAL PRIMARY KEY,
    id_publisher INTEGER,
    location VARCHAR(255) DEFAULT NULL,
    post_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    photo VARCHAR(255) DEFAULT NULL,
    status TEXT CHECK (status IN ('Private', 'Friends', 'Public')) DEFAULT 'Friends',
    description VARCHAR(500) DEFAULT NULL,
    FOREIGN KEY (id_publisher) REFERENCES app_user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create like table
CREATE TABLE like_post (
    id_user INTEGER DEFAULT 0,
    id_post INTEGER,
    like_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_user, id_post),
    FOREIGN KEY (id_user) REFERENCES app_user(id_user) ON DELETE SET DEFAULT ON UPDATE CASCADE,
    FOREIGN KEY (id_post) REFERENCES post(id_post) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create comment table
CREATE TABLE comment (
    id_comment SERIAL PRIMARY KEY,
    id_user INTEGER,
    id_post INTEGER,
    content VARCHAR(500) NOT NULL,
    comment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_user) REFERENCES app_user(id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_post) REFERENCES post(id_post) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create conversation table
CREATE TABLE conversation (
    id_conversation SERIAL PRIMARY KEY,
    conversation_name VARCHAR(100) NOT NULL,
    id_creator INTEGER,
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_creator) REFERENCES app_user(id_user) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Create conversation_participant table
CREATE TABLE conversation_participant (
    id_conversation INTEGER,
    id_user INTEGER,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_conversation, id_user),
    FOREIGN KEY (id_conversation) REFERENCES conversation(id_conversation) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_user) REFERENCES app_user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create message table
CREATE TABLE message (
    id_message SERIAL PRIMARY KEY,
    id_user_sender INTEGER DEFAULT 0,
    id_conversation INTEGER,
    content TEXT NOT NULL,
    edited BOOLEAN DEFAULT FALSE,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_user_sender) REFERENCES app_user(id_user) ON DELETE SET DEFAULT ON UPDATE CASCADE,
    FOREIGN KEY (id_conversation) REFERENCES conversation(id_conversation) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create building table
CREATE TABLE building (
    id_building SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL,
    description TEXT DEFAULT NULL,
    photos VARCHAR(255) DEFAULT NULL
);

-- Create room table
CREATE TABLE room (
    id_room SERIAL PRIMARY KEY,
    id_building INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL,
    description TEXT DEFAULT NULL,
    photos VARCHAR(255) DEFAULT NULL,
    FOREIGN KEY (id_building) REFERENCES building(id_building) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create sport_in_room table
CREATE TABLE sport_in_room (
    id_room INTEGER NOT NULL,
    id_sport INTEGER NOT NULL,
    PRIMARY KEY (id_room, id_sport),
    FOREIGN KEY (id_room) REFERENCES room(id_room) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_sport) REFERENCES sport(id_sport) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create reservation table
CREATE TABLE reservation (
    id_reservation SERIAL PRIMARY KEY,
    id_room INTEGER NOT NULL,
    id_creator INTEGER NOT NULL,
    reservation_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    reservation_status TEXT CHECK (reservation_status IN ('Pending', 'Confirmed', 'Canceled')) DEFAULT 'Pending',
    description TEXT DEFAULT NULL,
    FOREIGN KEY (id_room) REFERENCES room(id_room) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_creator) REFERENCES app_user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create reservation_participant table
CREATE TABLE reservation_participant (
    id_reservation INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    status TEXT CHECK (status IN ('Invited', 'Confirmed', 'Declined')) DEFAULT 'Invited',
    PRIMARY KEY (id_reservation, id_user),
    FOREIGN KEY (id_reservation) REFERENCES reservation(id_reservation) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_user) REFERENCES app_user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create room_availability table
CREATE TABLE room_availability (
    id_room INTEGER NOT NULL,
    available_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    is_booked BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (id_room, available_date, start_time, end_time),
    FOREIGN KEY (id_room) REFERENCES room(id_room) ON DELETE CASCADE ON UPDATE CASCADE
);
