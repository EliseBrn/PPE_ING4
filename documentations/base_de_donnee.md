# Base de donnée

## Plan
1. Logique de l'organisation
2. Les tables

Fichier SQL -> [sql_fichier](https://github.com/EliseBrn/PPE_ING4/tree/main/code/BdD_PPE.sql)

## 1 - Logique de l'organisation

![Schema de la base de donnée](https://github.com/EliseBrn/PPE_ING4/blob/main/images/Schema_BdD.png)

## 2 - Les tables

### `users`
Contient les informations de base sur les utilisateurs de la plateforme (email, mot de passe, prénom, pseudo, etc.).

### `parameters`
Stocke les paramètres de configuration et les préférences des utilisateurs, comme la visibilité du profil et les paramètres de notification.

### `sports_list`
Liste des sports disponibles sur la plateforme, avec des informations comme des logos et des descriptions.

### `sports`
Associe les utilisateurs aux sports qu'ils pratiquent, ainsi que leur niveau de compétence, leur club et s'ils cherchent des partenaires.

### `badges_list`
Liste des badges disponibles, avec des descriptions et des critères d'attribution.

### `badges`
Associe les utilisateurs aux badges qu'ils ont obtenus, avec la date d'obtention et la visibilité sur leur profil.

### `friendship`
Gère les relations d'amitié entre utilisateurs (qui suit qui), avec la date du suivi.

### `matches`
Gère les demandes de mise en relation entre utilisateurs (ex: demande d'amis), avec les statuts de ces demandes (en attente, acceptée, refusée).

### `posts`
Contient les publications des utilisateurs, y compris les informations sur la localisation, la visibilité, la description et les photos.

### `likes`
Enregistre les "likes" des utilisateurs sur les posts (qui aime quel post), avec la date et l'heure.

### `comments`
Enregistre les commentaires des utilisateurs sur les publications des autres.

### `conversations`
Contient les conversations entre utilisateurs (peut être un chat privé ou un groupe), avec le nom et la date de création.

### `conversation_participants`
Associe les utilisateurs aux conversations auxquelles ils participent, avec la date d'adhésion.

### `messages`
Stocke les messages envoyés dans les conversations, y compris le contenu et la date/heure d'envoi.

### `buildings_list`
Liste des bâtiments disponibles sur la plateforme, avec leur nom, type et photos.

### `rooms_list`
Liste des salles disponibles dans chaque bâtiment, avec leur description, photos et type.

### `sports_in_room`
Associe les sports aux salles où ils peuvent être pratiqués.

### `reservations`
Gère les réservations de salles par les utilisateurs, avec les horaires, le statut et la description de la réservation.

### `reservation_participants`
Associe les utilisateurs aux réservations auxquelles ils participent, avec leur statut (invité, confirmé, refusé).

### `room_availability`
Gère la disponibilité des salles pour des dates et horaires spécifiques.

