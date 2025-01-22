# Utilisation Git

## 0 - Notions
- <mark>Repo local</mark> : le dépôt Git situé sur votre ordinateur.
- <mark>Repo distant</mark> : le dépôt Git hébergé sur GitHub, accessible en ligne.
- <mark>README.md</mark> : un fichier au format Markdown qui sert à fournir des informations sur le projet (comme ce fichier).
  
    Astuce : Pas besoin de créer un `README.md` sur votre branche. Si vous en créez un, ajoutez son nom dans le fichier `/.gitignore` pour éviter de le pousser accidentellement.
- <mark>.gitignore</mark> : un fichier Git permettant de spécifier les fichiers ou extensions à ne pas inclure lors des pushs.
    - Ajoutez impérativement `.DS_Store` dans ce fichier. `.DS_Store` est un fichier spécifique à macOS qui contient des informations sur l'organisation des fichiers dans le Finder, mais il est inutile pour les autres contributeurs.
- <mark>Branche</mark> : un espace de travail isolé.
    - Chaque contributeur travaille sur sa propre branche, ce qui permet de travailler indépendamment de la branche principale (main) et des autres membres de l'équipe.
    - ATTENTION : jamais travailler directement sur le main.
 
## I - Première Installation
1. Assurez-vous que tout est bien installé (voir `/Prerequies.md`).

Note : utilisez votre terminal pour la suite de l'installation.

2. Pour cloner le dépôt sur votre ordinateur (Attention : vérifiez bien le chemin où vous le clonez) :
    ```
    git clone https://github.com/EliseBrn/PPE_ING4.git
    ```
3. Une fois le dépôt cloné, utilisez la commande suivante pour accéder au dossier Git :
    ```
    cd PPE_ING4
    ```
4. Utilisez cette commande pour vérifier que tout est en ordre :
    ```
    ls
    ```
    Note : vous devriez voir les dossiers présents dans la branche principale (notamment utilisation_git.md, README.md, et Prerequies.md).
5. Maintenant, créez votre branche en remplaçant **NAME*** par votre nom en minuscules :
    ```
    git branch NAME
    ```
6. Pour vérifier votre branche :
    ```
    git branch
    ```
7. Passez sur votre branche : (remplacez NAME)
    ```
    git checkout NAME
    ```
8. Ajoutez vos modif sur git :
    ```
    git add .
    ```
9. Puis effectuez un commit :
    ```
    git commit -m"Creation de ma branche"
    ```
10. Poussez votre branche sur le dépôt distant :  (remplacez NAME)
    ```
    git push -u origin NAME
    ```
11. Là tout est presque fini, il manque plus qu'a récupérer la branche des autres membres et c'est bon
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
1. Vérifiez que vous êtes sur la bonne branche.
2. Ajoutez vos modifications au commit :
    ```
    git add .
    ```
    Note : le `.` signifie que toutes vos modifications seront ajoutées. Si vous voulez sélectionner un fichier ou dossier spécifique, remplacez le point par son nom.

3. Ajoutez un message de commit :
    ```
    git commit -m" "
    ```
    Note : entre les guillemets, décrivez brièvement vos modifications (cf **IV - Conventionan Commit**)

4. Enfin poussez vos modifications :
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
Le merge permet de fusionner les modifications d'une branche dans une autre. Voici les étapes pour effectuer un merge correctement :

### !!! Ceci est à titre indicatif, les premiers merge se feront ensemble pour éviter toutes erreurs possible !!!

1. Basculer sur la branche de destination (si vous voulez fusionner une branche "test" dans "main", commencez par vous placer sur "main"
    ```
    git checkout main
    ```
2. Fusionner la branche source (changer **test** par la branche que vous voulez fusionner)
   ```
   git merge test
   ```
3. Résolution des conflits (si nécessaire)
    Si des conflits apparaissent pendant le merge, Git vous indiquera quels fichiers sont en conflit.
   Pour résoudre les conflits :
   - Ouvrez les fichiers indiqués par Git.
   - Cherchez les marqueurs de conflit (par exemple, <<<<<<<, =======, >>>>>>>) et choisissez quelle modification conserver.
   - Une fois les conflits résolus, ajoutez les fichiers mis à jour :
     ```
     git add <nom-du-fichier>
     ``` 
   - Terminez le merge avec un commit :
     ```
     git commit -m""
     ```
4. Pousser les modifications fusionnées
   Une fois le merge terminé, vous pouvez pousser les modifications fusionnées vers le dépôt distant :
    ```
    git push
    ```















