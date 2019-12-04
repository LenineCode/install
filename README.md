# Fichier d'installation
Ce programme script permet d'installer grâce à un seul fichier tous les éléments nécessaire pour le développement du groupe LenineCode sur un environnement linux

# /!\ Attention /!\
Il n'a pas été encore tester, veuillez attendre la V1, une fois publier, ce message disparaitra et un tag sera créé

## Prerecquis

Pour le moment, le script sera fonctionnel uniquement pour les distributions qui utilise l'apt et snap
```
exemple : ubuntu, kubuntu, kde neon ...
```

## Contenu

### Langage

* php
* node12
* sass
* python

### git
Le script vous demandera votre user.name et user.email.
Il ajouté une option qui vous permettra après le premier push/pull de ne plus taper votre mot de passe git pendant 1 heure

### Commande
* htop
* fuck

### base de données
Le script installe une base de donnée maria-db ainsi que le module php pour pouvoir l'utiliser. Il crée par défaut un compte ayant tout les droits (user = root, mdp = root).
Une base de données example sera créé par défaut pour pouvoir utiliser phpmyadmin immédiatement

### Terminal
zsh avec le thème agnoster sera installé

### docker
il sera installé et vous serez par défaut dans le groupe docker

### Programme
* chrome
* vscode
* minecraft

Suite à l'installation, un fichier de log sera crée pour voir les succès et les echecs de l'installation.

## évolution

A venir

* Lors de l'installation de vscode, l'idéal sera qu'il soit installé avec des extensions
* Faire un script similaire pour les autres distributions qui n'utilise pas l'apt (manjaro etc)