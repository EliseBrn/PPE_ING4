# Base de donnée

## Plan
1. Logique de l'organisation
2. Les tables
3. Logique de suppression (cascade)

Code : [sql_fichier](https://github.com/EliseBrn/PPE_ING4/tree/main/code/code_sql/schema.sql)
- **Ordre des fichier** : [schema.sql](https://github.com/EliseBrn/PPE_ING4/tree/main/code/code_sql/schema.sql) + [functions_and_triggers.sql](https://github.com/EliseBrn/PPE_ING4/tree/main/code/code_sql/functions_and_triggers.sql) + [constraint.sql](https://github.com/EliseBrn/PPE_ING4/tree/main/code/code_sql/constraint.sql)  + [index.sql](https://github.com/EliseBrn/PPE_ING4/tree/main/code/code_sql/index.sql) + [initial_data.sql](https://github.com/EliseBrn/PPE_ING4/tree/main/code/code_sql/initial_data.sql)

## 1 - Logique de l'organisation

![Schema de la base de donnée](https://github.com/EliseBrn/PPE_ING4/blob/main/images/Schema_BdD.png)


## 2 - Les tables

- `user` : Contient les informations de base sur les utilisateurs de la plateforme (email, mot de passe, prénom, pseudo, etc.), ainsi que leur date d'inscription.
- `user_setting` : Stocke les paramètres de confidentialité et de notification des utilisateurs, comme la visibilité du profil et des informations personnelles.
- `sport` : Liste les sports disponibles sur la plateforme, avec des descriptions et des logos.
- `sport_user` : Associe les utilisateurs aux sports qu'ils pratiquent, incluant leur niveau, leur club et leur disponibilité pour trouver des partenaires.
- `badge` : Liste les badges disponibles, avec leurs descriptions et les conditions pour les obtenir.
- `badge_user` : Associe les utilisateurs aux badges qu'ils ont obtenus, avec la date d'obtention et leur visibilité sur le profil.
- `friendship` : Gère les relations d'amitié entre utilisateurs (qui suit qui), en enregistrant la date de suivi.
- `match` : Gère les demandes de mise en relation entre utilisateurs, avec le statut des demandes (en attente, acceptée ou refusée).
- `post` : Stocke les publications des utilisateurs, incluant les photos, la localisation, la description et la visibilité (amis uniquement ou public).
- `like` : Enregistre les "likes" des utilisateurs sur les publications (qui aime quel post), avec la date et l'heure.
- `comment` : Stocke les commentaires des utilisateurs sur les publications, avec leur contenu, la date et l'heure.
- `conversation` : Gère les conversations entre utilisateurs, avec leur nom, le créateur et la date de création.
- `conversation_participant` : Associe les utilisateurs aux conversations auxquelles ils participent, avec la date de leur entrée dans la conversation.
- `message` : Stocke les messages envoyés dans les conversations, avec leur contenu, la date et l'heure d'envoi, et une indication s'ils ont été édités.
- `building` : Liste les bâtiments disponibles, avec leur nom, leur localisation, leur type et des informations supplémentaires comme des descriptions ou des photos.
- `room` : Liste les salles disponibles dans les bâtiments, avec leurs noms, types, descriptions et photos.
- `sport_in_room` : Associe les sports aux salles où ils peuvent être pratiqués.
- `reservation` : Gère les réservations des salles par les utilisateurs, avec les horaires, le statut de la réservation et des détails optionnels.
- `reservation_participant` : Associe les utilisateurs aux réservations, avec leur statut (invité, confirmé ou refusé).
- `room_availability` : Gère la disponibilité des salles pour des dates et horaires spécifiques, avec un statut indiquant si elles sont réservées ou non.


## 3 - Logique de suppression (cascade)

- Pour la suppression d'un user on souhaite garder uniquement ses **likes** sur les posts et **messages** dans les conversations.
  - Creation d'un user anonyme sous id_user = 0
    ```
    INSERT INTO user (id_user, email, password, first_name, pseudo)
    VALUES (0, 'anonymous@example.com', 'not_applicable', 'Anonymous', 'Anonymous');
    ```
  - Cascade : règle définie sur une clé étrangère pour automatiser ce qu'il se passe dans les tables liées quand une action est effectuée sur une table parent (suppression, modification...)
  - Cascade pour les likes et les messages : ```ON DELETE SET DEFAULT``` après la foreign key faisant référence à l'id_user.

- Pour les réservations si un user est supprimé :
  - Impossible de supprimer un compte si une réservation ou participation à une réservation est en cours.
  - Ajout d'une fonction `user_has_active_reservations(user_id INT)` et d'un trigger `before_user_delete` pour s'assurer que le user n'ai pas de réservation en cours.
  - Il faudra prévenir le user si la suppression ne marche pas à cause de ça.
