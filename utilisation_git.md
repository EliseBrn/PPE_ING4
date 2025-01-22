# Utilisation Git

## I - Première Installation
- Vérifier bien que vous avez tout d'installé (cf `/prerequies.md`)

Note : utiliser votre terminal pour la suite de l'installation
- Pour clone le repo sur votre ordi (**Attention** : regarder bien le chemin où vous le clonez !)
  ```
  git clone https://github.com/EliseBrn/PPE_ING4.git
  ```
- Une fois le repo clone, faite pour aller dans le dossier git :
  ```
  cd PPE_ING4
  ```
- Utiliser cette commande pour vérifier que tout est bon
  ```
  ls
  ```
  Note : vous devriez voir les dossiers present dans le main (dont utilisation_git.md, README.md et prerquies.md notamment)
- Maintenant vous aller creer votre branche en remplacant **NAME** par votre nom en minuscule
  ```
  git branch NAME
  ```
- Utiliser pour voir votre branche
  ```
  git branch
  ```
- Aller sur votre branche : (remplacer NAME)
  ```
  git checkout NAME
  ```
- Ajouter vos modif sur git :
  ```
  git add .
  ```
  ```
  git commit -m"Creation de ma branche"
  ```
- Push la branche : (remplacer NAME)
  ```
  git push -u origin NAME
  ```
- La tout est presque fini, il manque plus qu'a récupérer la branche des autres membres et c'est bon
  ```
  git checkout -b elise origin/elise
  ```
  Note : Là c'est ma branche que vous allez récupérer

C'est bon vous etes à jour et vous avez vu les principales commandes utile pour l'utilisation de Git sur le terminal
Tout cela aurait pu etre fait via le site GitHub mais c'est le plus intuitif d'utilisation. 
A vous de voir ce que vous préférer utilissr à l'avenir, mais il faut imperativement que vous ayez une version du projet en local pour coder dessus. 
Vous pourrez commit via le GitHub également mais je vais vous montrer comment le faire via le terminal églement
##
### Installation si le dossier est supprimé à un moment du projet
```
git clone https://github.com/EliseBrn/PPE_ING4.git
cd PPE_ING4
git checkout -b elise origin/elise
git checkout -b thomas origin/thomas
git checkout -b martin origin/martin
git checkout -b emma origin/emma
git checkout -b louis origin/louis
git checkout -b danae origin/danae
```
Avec ces lignes, vous retrouverer le projet et toutes les branches d'un coup.
Maintenant vous n'avez plus qu'a aller sur votre branche !

## II - Commandes Utiles
- `cd` : pour changer de dossier (dans le terminal)
- `ls` : pour afficher les fichier present dans l'endroit ou vous etes
- `git branch` : pour voir sur quelle branche vous etes
- `git checkout branch` : pour changer de branche (remplacer branch par le nom de la branche)
- `git status` : peremet de checker le status de votre repo en local 

## III - Commit Terminal
**Attention** : ceci sert à faire un commit sur VOTRE propre branch !!
Pour merge sur la branch principale c'est dans la partie **V - Merge**

Pour faire un commit depuis votre terminal, vous devez d'abords checker que vous etes dans le bonne branche.
- Ensuite ajouter les modification à commit avec :
  ```
  git add .
  ```
  Note : `.` implique que TOUTES vos modifications vont etre push. Si vous voulez un dossier ou fichier en particulier remplacer le point par son nom

- Ensuite mettre cette ligne :
  ```
  git commit -m" "
  ```
  Note : "" doit etre remplis avec les explications de vos modification cf **IV - Conventionan Commit**

- Enfin pour les envoyer pour de bon sur git :
  ```
  git push
  ```
  Note : il se peut qu'une erreur survienne, chatgpt est bon pour cette résolution de conflit.


## IV - Conventional Commit
Si vous faites un commit depuis git vous avez juste besoin de ces conventions ci dessous.
Si vous faites un commit depuis votre terminal utiliser les instruction dans la partie `II - Commit terminal`
- A specification for structuring commit messages.
- Format: `<type>[optional scope]: <description>`
- Types:
  - `feat`: A new feature.
  - `fix`: A bug fix.
  - `docs`: Documentation changes.
  - `style`: Code style changes (e.g., formatting).
  - `refactor`: Code changes that neither fix a bug nor add a feature.
  - `test`: Adding or modifying tests.
  - `chore`: Maintenance tasks, build changes, etc.
- Benefits:
  - Standardizes commit messages.
  - Enables automated release notes and versioning.
  - Improves readability and searchability.
- Full spec: <https://www.conventionalcommits.org>

## V - Merge
