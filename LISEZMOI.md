# Gamolf FMX Game Starter Kit

[This page in English.](README.md)

"[Gamolf FMX Game Starter Kit](https://fmxgamestarterkit.developpeur-pascal.fr/)" est à la fois un exemple "technique" de jeu vidéo développé en Delphi avec tout ce qu'il faut dedans et un modèle de projet réutilisable à personnaliser pour vos propres jeux.

Les fichiers fournis sont fonctionnels. De nombreux commentaires sont inclus dans les sources pour expliquer leur fonctionnement et ce que vous devez copier, surcharger ou personnaliser pour faire des jeux vidéo sans partir de zéro.

Pour utiliser ce modèle vous pouvez soit le rapatrier comme fichier ZIP et ajouter les dépendances à la main, soit l'utiliser comme template pour créer le dépôt de code de votre jeu, soit l'utiliser en sous-module dans un dépôt de code. Un mode d'emploi et les étapes détaillées seront fournis prochainement, le temps d'ajouter quelques exemples d'utilisation et d'enregistrer des vidéos explicatives.

Traitez les TODOs et les messages de compilation.

Evitez autant que possible de modifier les fichiers du starter kit, créez plutôt les vôtres. Ca vous permettra ensuite de mettre à jour ceux d'origine et bénéficier des nouvelles fonctionnalités (ou correctifs) de façon totalement transparente.

Vous ignorez comment coder des jeux ? Regardez ces projets:

* [Jeux vidéos basés sur ce starter kit](https://github.com/DeveloppeurPascal?tab=repositories&q=gfgsk-game)
* [Jeux vidéo en Delphi](https://github.com/DeveloppeurPascal?tab=repositories&q=delphi-game)
* [Delphi FMX Game Snippets](https://fmxgamesnippets.developpeur-pascal.fr)
* [Delphi Game Engine](https://delphigameengine.developpeur-pascal.fr)

Depuis décembre 2025 vous pouvez aussi partir d'un dossier préconfiguré pour créer vos jeux vidéo basés sur ce starter kit. [Téléchargez la dernière version du "Game Template"](https://codeberg.org/DeveloppeurPascal/Game-Template-For-Delphi-FireMonkey/releases) et suivez simplement les explications présentes dans les fichiers TODO.md

* [Game Starter Kit Template](https://codeberg.org/DeveloppeurPascal/Game-Template-For-Delphi-FireMonkey)

Vous cherchez un autre moteur de jeu vidéo ? Consultez [ces liens](https://github.com/Fr0sT-Brutal/awesome-pascal?tab=readme-ov-file#game-dev).

Ce dépôt de code contient un projet développé en langage Pascal Objet sous Delphi. Vous ne savez pas ce qu'est Dephi ni où le télécharger ? Vous en saurez plus [sur ce site web](https://delphi-resources.developpeur-pascal.fr/).

## Utiliser ce kit de développement de jeux vidéo

Consultez [le site du starter kit](https://fmxgamestarterkit.developpeur-pascal.fr) pour télécharger la version compilée des jeux de démo, en savoir plus sur son fonctionnement, accéder à des vidéos et articles, connaître les différentes versions disponibles et leurs fonctionnalités, contacter le support utilisateurs...

## Présentations et conférences

### Embarcadero CodeRage 2025

* [The Christmas Game Evolution](https://coderage.embarcadero.com) (in English)

### Dev Days of Summer 2024

* video : [Make games in Delphi (2024 edition)](https://www.youtube.com/live/M7DcEDbuESQ?feature=shared&t=3911) (diffusion en direct durant la conférence, en anglais)
* video : [Faites des jeux en Delphi (v2024)](https://apprendre-delphi.fr/faites-des-jeux-en-delphi-presentation-demo-revue-de-code-et-tour-du-starter-kit.html) (en français)
* PDF, sources, liens, ... : [Make games in Delphi (2024 edition)](https://github.com/DeveloppeurPascal/DevDaysOfSummer2024-MakeGamesInDelphi) (le dépôt de code)

### Listes de vidéos sur ce projet et la création de jeux vidéo en Delphi

* sur [PeerTube](https://videos.apprendre-delphi.fr/w/p/jU3L7GkvEySdDmNwdyMVgt)
* sur [YouTube](https://www.youtube.com/playlist?list=PLpkkg2iiC8yjkhmHDs42arEqvJm-m7006)

### Twitch

Suivez mes streams de développement de logiciels, jeux vidéo, applications mobiles et sites web sur [ma chaîne Twitch](https://www.twitch.tv/patrickpremartin) ou en rediffusion sur [Serial Streameur](https://serialstreameur.fr/gamolf-fmx-game-starter-kit.html) la plupart du temps en français.

## Installation des codes sources

Pour télécharger ce dépôt de code il est recommandé de passer par "git" mais vous pouvez aussi télécharger un ZIP directement depuis [son dépôt GitHub](https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit).

Ce projet utilise des dépendances sous forme de sous modules. Ils seront absents du fichier ZIP. Vous devrez les télécharger à la main.

* [DeveloppeurPascal/AboutDialog-Delphi-Component](https://github.com/DeveloppeurPascal/AboutDialog-Delphi-Component) doit être installé dans le sous dossier ./lib-externes/AboutDialog-Delphi-Component
* [DeveloppeurPascal/CilTseg4Delphi](https://github.com/DeveloppeurPascal/CilTseg4Delphi) doit être installé dans le sous dossier ./lib-externes/CilTseg4Delphi
* [DeveloppeurPascal/Delphi-Game-Engine](https://github.com/DeveloppeurPascal/Delphi-Game-Engine) doit être installé dans le sous dossier ./lib-externes/Delphi-Game-Engine
* [DeveloppeurPascal/librairies](https://github.com/DeveloppeurPascal/librairies) doit être installé dans le sous dossier ./lib-externes/librairies

## Documentation et assistance

Je passe par des commentaires au format [XMLDOC](https://docwiki.embarcadero.com/RADStudio/fr/Commentaires_de_documentation_XML) dans Delphi pour documenter mes projets. Ils sont reconnus par Help Insight qui propose de l'aide à la saisie en temps réel dans l'éditeur de code.

J'utilise régulièrement l'outil [DocInsight](https://devjetsoftware.com/products/documentation-insight/) pour les saisir et contrôler leur formatage.

L'export de la documentation est fait en HTML par [DocInsight](https://devjetsoftware.com/products/documentation-insight/) ou [PasDoc](https://pasdoc.github.io) vers le dossier /docs du dépôt. Vous y avez aussi [accès en ligne](https://developpeurpascal.github.io/Gamolf-FMX-Game-Starter-Kit) grâce à l'hébergement offert par GitHub Pages.

D'autres informations (tutoriels, articles, vidéos, FAQ, présentations et liens) sont disponibles sur [le site web du projet](https://fmxgamestarterkit.developpeur-pascal.fr) ou [le devlog du projet](https://developpeur-pascal.fr/gamolf-fmx-game-starter-kit.html).

Si vous avez besoin d'explications ou d'aide pour comprendre ou utiliser certaines parties de ce projet dans le vôtre, n'hésitez pas à [me contacter](https://developpeur-pascal.fr/nous-contacter.php). Je pourrai soit vous orienter vers une ressource en ligne, soit vous proposer une assistance sous forme de prestation payante ou gratuite selon les cas. Vous pouvez aussi me faire signe à l'occasion d'une conférence ou pendant une présentation en ligne.

## Compatibilité

En tant que [MVP Embarcadero](https://www.embarcadero.com/resources/partners/mvp-directory) je bénéficie dès qu'elles sortent des dernières versions de [Delphi](https://www.embarcadero.com/products/delphi) et [C++ Builder](https://www.embarcadero.com/products/cbuilder) dans [RAD Studio](https://www.embarcadero.com/products/rad-studio). C'est donc dans ces versions que je travaille.

Normalement mes librairies et composants doivent aussi fonctionner au moins sur la version en cours de [Delphi Community Edition](https://www.embarcadero.com/products/delphi/starter).

Aucune garantie de compatibilité avec des versions antérieures n'est fournie même si je m'efforce de faire du code propre et ne pas trop utiliser les nouvelles façons d'écrire dedans (type inference, inline var et multilines strings).

Si vous détectez des anomalies sur des versions antérieures n'hésitez pas à [les rapporter](https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit/issues) pour que je teste et tente de corriger ou fournir un contournement.

## Licence d'utilisation de ce dépôt de code et de son contenu

Ces codes sources sont distribués sous licence [AGPL 3.0 ou ultérieure](https://choosealicense.com/licenses/agpl-3.0/).

Vous êtes libre d'utiliser le contenu de ce dépôt de code n'importe où à condition :
* d'en faire mention dans vos projets
* de diffuser les modifications apportées aux fichiers fournis dans ce projet sous licence AGPL (en y laissant les mentions de copyright d'origine (auteur, lien vers ce dépôt, licence) obligatoirement complétées par les vôtres)
* de diffuser les codes sources de vos créations sous licence AGPL

Si cette licence ne convient pas à vos besoins (notamment pour un projet commercial) je propose aussi [des licences classiques pour les développeurs et les entreprises](https://fmxgamestarterkit.developpeur-pascal.fr).

Certains éléments inclus dans ce dépôt peuvent dépendre de droits d'utilisation de tiers (images, sons, ...). Ils ne sont pas réutilisables dans vos projets sauf mention contraire.

Les codes sources de ce dépôt de code comme leur éventuelle version compilée sont fournis en l'état sans garantie d'aucune sorte.

## Comment demander une nouvelle fonctionnalité, signaler un bogue ou une faille de sécurité ?

Si vous voulez une réponse du propriétaire de ce dépôt la meilleure façon de procéder pour demander une nouvelle fonctionnalité ou signaler une anomalie est d'aller sur [le dépôt de code sur GitHub](https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit) et [d'ouvrir un ticket](https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit/issues).

Si vous avez trouvé une faille de sécurité n'en parlez pas en public avant qu'un correctif n'ait été déployé ou soit disponible. [Contactez l'auteur du dépôt en privé](https://developpeur-pascal.fr/nous-contacter.php) pour expliquer votre trouvaille.

Vous pouvez aussi cloner ce dépôt de code et participer à ses évolutions en soumettant vos modifications si vous le désirez. Lisez les explications dans le fichier [CONTRIBUTING.md](CONTRIBUTING.md).

## Soutenez ce projet et son auteur

Si vous trouvez ce dépôt de code utile et voulez le montrer, merci de faire une donation [à son auteur](https://github.com/DeveloppeurPascal). Ca aidera à maintenir ce projet et tous les autres.

Vous pouvez utiliser l'un de ces services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* Ko-fi [en français](https://ko-fi.com/patrick_premartin_fr) ou [en anglais](https://ko-fi.com/patrick_premartin_en)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Liberapay](https://liberapay.com/PatrickPremartin)

Vous pouvez acheter une licence d'utilisateur pour [mes logiciels](https://lic.olfsoftware.fr/products.php?lng=fr) et [mes jeux vidéo](https://lic.gamolf.fr/products.php?lng=fr) ou [une licence de développeur pour mes bibliothèques](https://lic.developpeur-pascal.fr/products.php?lng=fr) si vous les utilisez dans vos projets.

Je suis également disponible en tant que prestataire pour vous aider à utiliser ce projet ou d'autres, comme pour vos développements de logiciels, applications mobiles et sites Internet. [Contactez-moi](https://vasur.fr/about) pour en discuter.
