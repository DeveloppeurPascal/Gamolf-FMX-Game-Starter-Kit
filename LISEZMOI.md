# Gamolf FMX Game Starter Kit

[This page in English.](README.md)

"Gamolf FMX Game Starter Kit" est à la fois un exemple "technique" de jeu vidéo développé en Delphi avec tout ce qu'il faut dedans et un modèle de projet réutilisable à personnaliser pour vos propres jeux.

Les fichiers fournis sont fonctionnels. De nombreux commentaires sont inclus dans les sources pour expliquer leur fonctionnement et ce que vous devez copier, surcharger ou personnaliser pour faire des jeux vidéo sans partir de zéro.

Pour utiliser ce modèle vous pouvez soit le rapatrier comme fichier ZIP et ajouter les dépendances à la main, soit l'utiliser comme template pour créer le dépôt de code de votre jeu, soit l'utiliser en sous-module dans un dépôt de code. Un mode d'emploi et les étapes détaillées seront fournis prochainement, le temps d'ajouter quelques exemples d'utilisation et d'enregistrer des vidéos explicatives.

Traitez les TODOs et les messages de compilation.

Evitez autant que possible de modifier les fichiers du starter kit, créez plutôt les vôtres. Ca vous permettra ensuite de mettre à jour ceux d'origine et bénéficier des nouvelles fonctionnalités (ou correctifs) de façon totalement transparente.

Vous ignorez comment coder des jeux ? Regardez ces projets:

* [Jeux vidéos basés sur ce starter kit](https://github.com/DeveloppeurPascal?tab=repositories&q=gfgsk-game)
* [Jeux vidéo en Delphi](https://github.com/DeveloppeurPascal?tab=repositories&q=delphi-game)
* [Delphi FMX Game Snippets](https://fmxgamesnippets.developpeur-pascal.fr)
* [Delphi Game Engine](https://delphigameengine.developpeur-pascal.fr)

Vous cherchez un autre moteur de jeu vidéo ? Consultez [ces liens](https://github.com/Fr0sT-Brutal/awesome-pascal?tab=readme-ov-file#game-dev).

Ce dépôt de code contient un projet développé en langage Pascal Objet sous Delphi. Vous ne savez pas ce qu'est Dephi ni où le télécharger ? Vous en saurez plus [sur ce site web](https://delphi-resources.developpeur-pascal.fr/).

## Présentations et conférences

### Dev Days of Summer 2024

* la rediffusion est pour bientôt

### Twitch

Suivez mes streams de développement de logiciels, jeux vidéo, applications mobiles et sites web sur [ma chaîne Twitch](https://www.twitch.tv/patrickpremartin) ou en rediffusion sur [Serial Streameur](https://serialstreameur.fr/gamolf-fmx-game-starter-kit.html) la plupart du temps en français.

## Utiliser ce logiciel

[Consultez le site du logiciel](https://fmxgamestarterkit.developpeur-pascal.fr/) pour en savoir plus sur son fonctionnement, accéder à des vidéos et articles, connaître les différentes versions disponibles et leurs fonctionnalités, contacter le support utilisateurs...

## Installation des codes sources

Pour télécharger ce dépôt de code il est recommandé de passer par "git" mais vous pouvez aussi télécharger un ZIP directement depuis [son dépôt GitHub](https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit).

Ce projet utilise des dépendances sous forme de sous modules. Ils seront absents du fichier ZIP. Vous devrez les télécharger à la main.

* [DeveloppeurPascal/AboutDialog-Delphi-Component](https://github.com/DeveloppeurPascal/AboutDialog-Delphi-Component) doit être installé dans le sous dossier ./lib-externes/AboutDialog-Delphi-Component
* [DeveloppeurPascal/Delphi-Game-Engine](https://github.com/DeveloppeurPascal/Delphi-Game-Engine) doit être installé dans le sous dossier ./lib-externes/Delphi-Game-Engine
* [DeveloppeurPascal/librairies](https://github.com/DeveloppeurPascal/librairies) doit être installé dans le sous dossier ./lib-externes/librairies

## Compatibilité

En tant que [MVP Embarcadero](https://www.embarcadero.com/resources/partners/mvp-directory) je bénéficie dès qu'elles sortent des dernières versions de [Delphi](https://www.embarcadero.com/products/delphi) et [C++ Builder](https://www.embarcadero.com/products/cbuilder) dans [RAD Studio](https://www.embarcadero.com/products/rad-studio). C'est donc dans ces versions que je travaille.

Normalement mes librairies et composants doivent aussi fonctionner au moins sur la version en cours de [Delphi Community Edition](https://www.embarcadero.com/products/delphi/starter).

Aucune garantie de compatibilité avec des versions antérieures n'est fournie même si je m'efforce de faire du code propre et ne pas trop utiliser les nouvelles façons d'écrire dedans (type inference, inline var et multilines strings).

Si vous détectez des anomalies sur des versions antérieures n'hésitez pas à [les rapporter](https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit/issues) pour que je teste et tente de corriger ou fournir un contournement.

## Licence d'utilisation de ce dépôt de code et de son contenu

Ces codes sources sont distribués sous licence [AGPL 3.0 ou ultérieure](https://choosealicense.com/licenses/agpl-3.0/).

Vous êtes globalement libre d'utiliser le contenu de ce dépôt de code n'importe où à condition :
* d'en faire mention dans vos projets
* de diffuser les modifications apportées aux fichiers fournis dans ce projet sous licence AGPL (en y laissant les mentions de copyright d'origine (auteur, lien vers ce dépôt, licence) obligatoirement complétées par les vôtres)
* de diffuser les codes sources de vos créations sous licence AGPL

Si cette licence ne convient pas à vos besoins vous pouvez acheter un droit d'utilisation de ce projet sous la licence [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/) ou une licence commerciale dédiée ([contactez l'auteur](https://developpeur-pascal.fr/nous-contacter.php) pour discuter de vos besoins).

Ces codes sources sont fournis en l'état sans garantie d'aucune sorte.

Certains éléments inclus dans ce dépôt peuvent dépendre de droits d'utilisation de tiers (images, sons, ...). Ils ne sont pas réutilisables dans vos projets sauf mention contraire.

## Comment demander une nouvelle fonctionnalité, signaler un bogue ou une faille de sécurité ?

Si vous voulez une réponse du propriétaire de ce dépôt la meilleure façon de procéder pour demander une nouvelle fonctionnalité ou signaler une anomalie est d'aller sur [le dépôt de code sur GitHub](https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit) et [d'ouvrir un ticket](https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit/issues).

Si vous avez trouvé une faille de sécurité n'en parlez pas en public avant qu'un correctif n'ait été déployé ou soit disponible. [Contactez l'auteur du dépôt en privé](https://developpeur-pascal.fr/nous-contacter.php) pour expliquer votre trouvaille.

Vous pouvez aussi cloner ce dépôt de code et participer à ses évolutions en soumettant vos modifications si vous le désirez. Lisez les explications dans le fichier [CONTRIBUTING.md](CONTRIBUTING.md).

## Supportez ce projet et son auteur

Si vous trouvez ce dépôt de code utile et voulez le montrer, merci de faire une donation [à son auteur](https://github.com/DeveloppeurPascal). Ca aidera à maintenir le projet (codes sources et binaires).

Vous pouvez utiliser l'un de ces services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* [Liberapay](https://liberapay.com/PatrickPremartin)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Paypal](https://www.paypal.com/paypalme/patrickpremartin)

ou si vous parlez français vous pouvez [vous abonner à Zone Abo](https://zone-abo.fr/nos-abonnements.php) sur une base mensuelle ou annuelle et avoir en plus accès à de nombreuses ressources en ligne (vidéos et articles).
