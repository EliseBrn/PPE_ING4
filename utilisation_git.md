# Utilisation Git

## I - Première Installation
- Assurez-vous que tout est bien installé (voir `/Prerequies.md`).

Note : utilisez votre terminal pour la suite de l'installation.
- Pour cloner le dépôt sur votre ordinateur (Attention : vérifiez bien le chemin où vous le clonez) :
  ```
  git clone https://github.com/EliseBrn/PPE_ING4.git
  ```
- Une fois le dépôt cloné, utilisez la commande suivante pour accéder au dossier Git :
  ```
  cd PPE_ING4
  ```
- Utilisez cette commande pour vérifier que tout est en ordre :
  ```
  ls
  ```
  Note : vous devriez voir les dossiers présents dans la branche principale (notamment utilisation_git.md, README.md, et Prerequies.md).
- Maintenant, créez votre branche en remplaçant **NAME*** par votre nom en minuscules :
  ```
  git branch NAME
  ```
- Pour vérifier votre branche :
  ```
  git branch
  ```
- Passez sur votre branche : (remplacez NAME)
  ```
  git checkout NAME
  ```
- Ajoutez vos modif sur git :
  ```
  git add .
  ```
- Puis effectuez un commit :
  ```
  git commit -m"Creation de ma branche"
  ```
- Poussez votre branche sur le dépôt distant :  (remplacez NAME)
  ```
  git push -u origin NAME
  ```
- Là tout est presque fini, il manque plus qu'a récupérer la branche des autres membres et c'est bon
  ```
  git checkout -b elise origin/elise
  ```
  Note : Là c'est ma branche que vous récupérez.

C'est bon, vous êtes à jour et vous avez vu les principales commandes utiles pour l'utilisation de Git dans le terminal.
Tout cela aurait pu être fait via le site GitHub, mais le terminal est le moins intuitif. À vous de voir ce que vous préférez utiliser à l'avenir. Cependant, il est impératif d'avoir une version locale du projet pour travailler dessus.
Vous pourrez effectuer des commits via GitHub, mais vous allez voir aussi comment le faire depuis le terminal.

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
Avec ces lignes, vous récupérerez le projet et toutes les branches d'un coup.
Ensuite, il ne vous reste plus qu'à basculer sur votre branche !

## II - Commandes Utiles
- `cd` : pour changer de dossier (dans le terminal).
- `ls` : pour afficher les fichiers presents dans l'endroit où vous êtes.
- `git branch` : pour voir sur quelle branche vous êtes.
- `git checkout branch` : pour changer de branche (remplacez **branch** par le nom de la branche).
- `git status` : peremet de checker le statut de votre repo en local.

## III - Commit Terminal
**Attention** cette section concerne les commits sur **VOTRE** propre branche !
Pour effectuer un merge sur la branche principale, référez-vous à la partie **V - Merge**

Pour faire un commit depuis votre terminal, suivez ces étapes :
- Vérifiez que vous êtes sur la bonne branche.
- Ajoutez vos modifications au commit :
  ```
  git add .
  ```
  Note : le `.` signifie que toutes vos modifications seront ajoutées. Si vous voulez sélectionner un fichier ou dossier spécifique, remplacez le point par son nom.

- Ajoutez un message de commit :
  ```
  git commit -m" "
  ```
  Note : entre les guillemets, décrivez brièvement vos modifications (cf **IV - Conventionan Commit**)

- Enfin poussez vos modifications :
  ```
  git push
  ```
 Note : si une erreur survient, ChatGPT est une bonne aide pour vous aider à résoudre les conflits.

## IV - Conventional Commit
Si vous effectuez un commit depuis Git, vous n'avez besoin que des conventions ci-dessous.
Si vous faites un commit depuis votre terminal, suivez les instructions de la section : `II - Commit terminal`

- Format : <type>[optional scope]: <description>
- Types courants :
  - feat : ajout d'une nouvelle fonctionnalité.
  - fix : correction de bug.
  - docs : modifications de la documentation.
  - style : changements liés au style du code (ex. formatage).
  - refactor : modifications du code sans ajout de fonctionnalités ni corrections de bugs.
  - test : ajout ou modification de tests.
  - chore : tâches d'entretien ou modifications de la configuration.
- Avantages :
  - Standardise les messages de commit.
  - Facilite la génération automatique des notes de version.
  - Améliore la lisibilité et la recherche des commits.
  - Pour plus de détails, consultez la spécification complète : <https://www.conventionalcommits.org>

## V - Merge
