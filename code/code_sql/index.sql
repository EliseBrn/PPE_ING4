-- Index sur la table user
CREATE INDEX idx_user_email ON user(email);
CREATE INDEX idx_user_pseudo ON user(pseudo);
CREATE INDEX idx_user_birth_date ON user(birth_date);

-- Index sur la table user_setting
CREATE INDEX idx_user_setting_id_user ON user_setting(id_user);

-- Index sur la table sport
CREATE INDEX idx_sport_name ON sport(name);

-- Index sur la table sport_user
CREATE INDEX idx_sport_user_id_user ON sport_user(id_user);
CREATE INDEX idx_sport_user_id_sport ON sport_user(id_sport);

-- Index sur la table badge
CREATE INDEX idx_badge_name ON badge(name);

-- Index sur la table badge_user
CREATE INDEX idx_badge_user_id_user ON badge_user(id_user);
CREATE INDEX idx_badge_user_id_badge ON badge_user(id_badge);

-- Index sur la table friendship
CREATE INDEX idx_friendship_id_user_follower ON friendship(id_user_follower);
CREATE INDEX idx_friendship_id_user_followed ON friendship(id_user_followed);

-- Index sur la table match_user
CREATE INDEX idx_match_user_id_user_requester ON match_user(id_user_requester);
CREATE INDEX idx_match_user_id_user_liked ON match_user(id_user_liked);

-- Index sur la table post
CREATE INDEX idx_post_id_publisher ON post(id_publisher);
CREATE INDEX idx_post_status ON post(status);
CREATE INDEX idx_post_date ON post(post_date);

-- Index sur la table like_post
CREATE INDEX idx_like_post_id_user ON like_post(id_user);
CREATE INDEX idx_like_post_id_post ON like_post(id_post);

-- Index sur la table comment
CREATE INDEX idx_comment_id_user ON comment(id_user);
CREATE INDEX idx_comment_id_post ON comment(id_post);

-- Index sur la table conversation
CREATE INDEX idx_conversation_id_creator ON conversation(id_creator);

-- Index sur la table conversation_participant
CREATE INDEX idx_conversation_participant_id_conversation ON conversation_participant(id_conversation);
CREATE INDEX idx_conversation_participant_id_user ON conversation_participant(id_user);

-- Index sur la table message
CREATE INDEX idx_message_id_user_sender ON message(id_user_sender);
CREATE INDEX idx_message_id_conversation ON message(id_conversation);
CREATE INDEX idx_message_sent_at ON message(sent_at);

-- Index sur la table building
CREATE INDEX idx_building_location ON building(location);

-- Index sur la table room
CREATE INDEX idx_room_id_building ON room(id_building);

-- Index sur la table sport_in_room
CREATE INDEX idx_sport_in_room_id_room ON sport_in_room(id_room);
CREATE INDEX idx_sport_in_room_id_sport ON sport_in_room(id_sport);

-- Index sur la table reservation
CREATE INDEX idx_reservation_id_room ON reservation(id_room);
CREATE INDEX idx_reservation_id_creator ON reservation(id_creator);
CREATE INDEX idx_reservation_status ON reservation(reservation_status);
CREATE INDEX idx_reservation_reservation_date ON reservation(reservation_date);

-- Index sur la table reservation_participant
CREATE INDEX idx_reservation_participant_id_reservation ON reservation_participant(id_reservation);
CREATE INDEX idx_reservation_participant_id_user ON reservation_participant(id_user);

-- Index sur la table room_availability
CREATE INDEX idx_room_availability_id_room ON room_availability(id_room);
CREATE INDEX idx_room_availability_available_date ON room_availability(available_date);
CREATE INDEX idx_room_availability_is_booked ON room_availability(is_booked);
