USE BdD_PPE;

-- Table: users
CREATE TABLE users (
    id_user INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    pseudo VARCHAR(255) NOT NULL UNIQUE,
    birth_date DATE NOT NULL,
    gender VARCHAR(50) DEFAULT NULL COMMENT 'male, female, other',
    photo TEXT DEFAULT NULL,
    description TEXT DEFAULT NULL
);

-- Table: paramtere
CREATE TABLE parameters (
    id_user INT NOT NULL,
    profile_visibility BOOLEAN DEFAULT TRUE,
    first_name_visibility BOOLEAN DEFAULT TRUE,
    birth_date_visibility BOOLEAN DEFAULT FALSE,
    notifications BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE
);

-- Table: sports_list
CREATE TABLE sports_list (
    id_sport INT AUTO_INCREMENT PRIMARY KEY,
    sport_logo TEXT,
    description TEXT DEFAULT NULL
);

-- Table: sports
CREATE TABLE sports (
    id_user INT NOT NULL,
    id_sport INT NOT NULL,
    club_name VARCHAR(255) DEFAULT NULL,
    skill_level VARCHAR(50) DEFAULT NULL COMMENT 'Beginner, Intermediate, Advanced',
    looking_for_partners BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id_user, id_sport),
    FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE,
    FOREIGN KEY (id_sport) REFERENCES sports_list(id_sport) ON DELETE CASCADE
);

-- Table: badges_list
CREATE TABLE badges_list (
    id_badge INT AUTO_INCREMENT PRIMARY KEY,
    badge_logo TEXT DEFAULT NULL,
    description TEXT NOT NULL,
    requirements TEXT NOT NULL
);

-- Table: badges
CREATE TABLE badges (
    id_user INT NOT NULL,
    id_badge INT NOT NULL,
    date_obtained DATE NOT NULL,
    displayed_on_profile BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id_user, id_badge),
    FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE,
    FOREIGN KEY (id_badge) REFERENCES badges_list(id_badge) ON DELETE CASCADE
);

-- Table: friendship
CREATE TABLE friendship (
    id_user_follower INT NOT NULL,
    id_user_followed INT NOT NULL,
    follow_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_user_follower, id_user_followed),
    FOREIGN KEY (id_user_follower) REFERENCES users(id_user) ON DELETE CASCADE,
    FOREIGN KEY (id_user_followed) REFERENCES users(id_user) ON DELETE CASCADE
);

-- Table: matches
CREATE TABLE matches (
    id_user_requester INT NOT NULL,
    id_user_liked INT NOT NULL,
    request_status VARCHAR(50) DEFAULT 'Wait' COMMENT 'Wait, Accepted, Declined',
    PRIMARY KEY (id_user_requester, id_user_liked),
    FOREIGN KEY (id_user_requester) REFERENCES users(id_user) ON DELETE CASCADE,
    FOREIGN KEY (id_user_liked) REFERENCES users(id_user) ON DELETE CASCADE
);

-- Table: posts
CREATE TABLE posts (
    id_post INT AUTO_INCREMENT PRIMARY KEY,
    id_publisher INT NOT NULL,
    location VARCHAR(255) DEFAULT NULL,
    post_date DATE,
    post_hours TIME,
    photo TEXT,
    status VARCHAR(50) DEFAULT 'Friends Only' COMMENT 'Friend Only, Public',
    description TEXT DEFAULT NULL,
    FOREIGN KEY (id_publisher) REFERENCES users(id_user) ON DELETE CASCADE
);

-- Table: likes
CREATE TABLE likes (
    id_user INT NOT NULL,
    id_post INT NOT NULL,
    like_date DATE,
    like_hours TIME,
    PRIMARY KEY (id_user, id_post),
    FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE,
    FOREIGN KEY (id_post) REFERENCES posts(id_post) ON DELETE CASCADE
);

-- Table: comments
CREATE TABLE comments (
    id_comment INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT NOT NULL,
    id_post INT NOT NULL,
    content TEXT NOT NULL,
    comment_date DATE,
    comment_time TIME,
    FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE,
    FOREIGN KEY (id_post) REFERENCES posts(id_post) ON DELETE CASCADE
);

-- Table: conversations
CREATE TABLE conversations (
    id_conversation INT AUTO_INCREMENT PRIMARY KEY,
    name_conv VARCHAR(255) NOT NULL,
    id_creator INT NOT NULL,
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_creator) REFERENCES users(id_user) ON DELETE CASCADE
);

-- Table: conversation_participants
CREATE TABLE conversation_participants (
    id_conversation INT NOT NULL,
    id_user INT NOT NULL,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_conversation, id_user),
    FOREIGN KEY (id_conversation) REFERENCES conversations(id_conversation) ON DELETE CASCADE,
    FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE
);

-- Table: messages
CREATE TABLE messages (
    id_message INT AUTO_INCREMENT PRIMARY KEY,
    id_user_sender INT NOT NULL,
    id_conversation INT NOT NULL,
    content TEXT NOT NULL,
    edited BOOLEAN DEFAULT FALSE,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_user_sender) REFERENCES users(id_user) ON DELETE CASCADE,
    FOREIGN KEY (id_conversation) REFERENCES conversations(id_conversation) ON DELETE CASCADE
);

-- Table: buildings_list
CREATE TABLE buildings_list (
    id_buildings INT AUTO_INCREMENT PRIMARY KEY,
    buildings_name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    description TEXT DEFAULT NULL,
    buildings_photos TEXT DEFAULT NULL
);

-- Table: salles_list
CREATE TABLE rooms_list (
    id_room INT AUTO_INCREMENT PRIMARY KEY,
    id_building INT NOT NULL,
    room_name VARCHAR(255) NOT NULL,
    room_photos TEXT DEFAULT NULL,
    description TEXT DEFAULT NULL,
    type VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_building) REFERENCES buildings_list(id_buildings) ON DELETE CASCADE
);

-- Table: sports_in_salle
CREATE TABLE sports_in_salle (
    id_room INT NOT NULL,
    id_sport INT NOT NULL,
    PRIMARY KEY (id_room, id_sport),
    FOREIGN KEY (id_room) REFERENCES rooms_list(id_room) ON DELETE CASCADE,
    FOREIGN KEY (id_sport) REFERENCES sports_list(id_sport) ON DELETE CASCADE
);

-- Table: reservations
CREATE TABLE reservations (
    id_reservation INT AUTO_INCREMENT PRIMARY KEY,
    id_sroom INT NOT NULL,
    id_creator INT NOT NULL,
    reservation_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    reservation_status VARCHAR(50) DEFAULT 'Pending' COMMENT 'Pending, Confirmed, Canceled',
    description TEXT DEFAULT NULL,
    FOREIGN KEY (id_room) REFERENCES rooms_list(id_room) ON DELETE CASCADE,
    FOREIGN KEY (id_creator) REFERENCES users(id_user) ON DELETE CASCADE
);

-- Table: reservation_participants
CREATE TABLE reservation_participants (
    id_reservation INT NOT NULL,
    id_user INT NOT NULL,
    status VARCHAR(50) DEFAULT 'Invited' COMMENT 'Invited, Confirmed, Declined',
    PRIMARY KEY (id_reservation, id_user),
    FOREIGN KEY (id_reservation) REFERENCES reservations(id_reservation) ON DELETE CASCADE,
    FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE
);

-- Table: room_availability
CREATE TABLE room_availability (
    id_room INT NOT NULL,
    available_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    is_booked BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (id_room, available_date, start_time, end_time),
    FOREIGN KEY (id_room) REFERENCES rooms_list(id_room) ON DELETE CASCADE
);
