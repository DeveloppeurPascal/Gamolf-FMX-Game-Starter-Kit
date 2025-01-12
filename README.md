# Gamolf FMX Game Starter Kit

[Cette page en français.](LISEZMOI.md)

The "[Gamolf FMX Game Starter Kit](https://fmxgamestarterkit.developpeur-pascal.fr/)" is both a "technical" example of a video game developed in Delphi with everything you need inside, and a reusable project template you can customize for your own games.

The files provided are fully functional. Numerous comments are included in the sources to explain how they work and what you need to copy, override or customize to make video games without starting from scratch.

To use this template you can either repackage it as a ZIP file and add dependencies by hand, use it as a template to create your game's code repository, or use it as a submodule in a code repository. An instruction manual and detailed steps will be provided shortly, while we add a few examples of use and record explanatory videos.

Handle TODOs and compilation messages.

As far as possible, avoid modifying the starter kit files; instead, create your own. This will enable you to update the original ones and benefit from new features (or patches) in a totally transparent way.

Don't know how to code games ? Look at these projects:

* [Games based on this game starter kit](https://github.com/DeveloppeurPascal?tab=repositories&q=gfgsk-game)
* [Games in Delphi](https://github.com/DeveloppeurPascal?tab=repositories&q=delphi-game)
* [Delphi FMX Game Snippets](https://fmxgamesnippets.developpeur-pascal.fr)
* [Delphi Game Engine](https://delphigameengine.developpeur-pascal.fr)

You are looking for an other game engine ? Check [these links](https://github.com/Fr0sT-Brutal/awesome-pascal?tab=readme-ov-file#game-dev).

This code repository contains a project developed in Object Pascal language under Delphi. You don't know what Delphi is and where to download it ? You'll learn more [on this web site](https://delphi-resources.developpeur-pascal.fr/).

## Talks and conferences

### Dev Days of Summer 2024

* [Make games in Delphi (2024 edition)](https://github.com/DeveloppeurPascal/DevDaysOfSummer2024-MakeGamesInDelphi) (the code repository)

* [Make games in Delphi (2024 edition)](https://www.youtube.com/live/M7DcEDbuESQ?feature=shared&t=3911) (live session during the conference, in English)
* [Faites des jeux en Delphi (v2024)](https://serialstreameur.fr/faites-des-jeux-en-delphi-edition-2024.html) (in French)

### YouTube

* [Gamolf FMX Game Starter Kit playlist](https://www.youtube.com/playlist?list=PLpkkg2iiC8yjkhmHDs42arEqvJm-m7006)

### Twitch

Follow my development streams of software, video games, mobile applications and websites on [my Twitch channel](https://www.twitch.tv/patrickpremartin) or as replays on [Serial Streameur](https://serialstreameur.fr/gamolf-fmx-game-starter-kit.html) mostly in French.

## Using this software

[Visit the software website](https://fmxgamestarterkit.developpeur-pascal.fr/) to find out more about how the starter kit and its samples work, access videos and articles, find out about the different versions available and their features, contact user support...

Download the installers for each demo video game from [the itch.io project page](https://gamolf.itch.io/gamolf-fmx-game-starter-kit-demo-video-games).

## Source code installation

To download this code repository, we recommend using "git", but you can also download a ZIP file directly from [its GitHub repository](https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit).

This project uses dependencies in the form of sub-modules. They will be absent from the ZIP file. You'll have to download them by hand.

* [DeveloppeurPascal/AboutDialog-Delphi-Component](https://github.com/DeveloppeurPascal/AboutDialog-Delphi-Component) must be installed in the ./lib-externes/AboutDialog-Delphi-Component subfolder.
* [DeveloppeurPascal/Delphi-Game-Engine](https://github.com/DeveloppeurPascal/Delphi-Game-Engine) must be installed in the ./lib-externes/Delphi-Game-Engine subfolder.
* [DeveloppeurPascal/librairies](https://github.com/DeveloppeurPascal/librairies) must be installed in the ./lib-externes/librairies subfolder.

## Compatibility

As an [Embarcadero MVP](https://www.embarcadero.com/resources/partners/mvp-directory), I benefit from the latest versions of [Delphi](https://www.embarcadero.com/products/delphi) and [C++ Builder](https://www.embarcadero.com/products/cbuilder) in [RAD Studio](https://www.embarcadero.com/products/rad-studio) as soon as they are released. I therefore work with these versions.

Normally, my libraries and components should also run on at least the current version of [Delphi Community Edition](https://www.embarcadero.com/products/delphi/starter).

There's no guarantee of compatibility with earlier versions, even though I try to keep my code clean and avoid using too many of the new ways of writing in it (type inference, inline var and multiline strings).

If you detect any anomalies on earlier versions, please don't hesitate to [report them](https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit/issues) so that I can test and try to correct or provide a workaround.

## License to use this code repository and its contents

This source code is distributed under the [AGPL 3.0 or later license](https://choosealicense.com/licenses/agpl-3.0/).

You are generally free to use the contents of this code repository anywhere, provided that:
* you mention it in your projects
* distribute the modifications made to the files supplied in this project under the AGPL license (leaving the original copyright notices (author, link to this repository, license) which must be supplemented by your own)
* to distribute the source code of your creations under the AGPL license.

If this license doesn't suit your needs, you can purchase the right to use this project under the [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/) or a dedicated commercial license ([contact the author](https://developpeur-pascal.fr/nous-contacter.php) to explain your needs).

These source codes are provided as is, without warranty of any kind.

Certain elements included in this repository may be subject to third-party usage rights (images, sounds, etc.). They are not reusable in your projects unless otherwise stated.

## How to ask a new feature, report a bug or a security issue ?

If you want an answer from the project owner the best way to ask for a new feature or report a bug is to go to [the GitHub repository](https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit) and [open a new issue](https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit/issues).

If you found a security issue please don't report it publicly before a patch is available. Explain the case by [sending a private message to the author](https://developpeur-pascal.fr/nous-contacter.php).

You also can fork the repository and contribute by submitting pull requests if you want to help. Please read the [CONTRIBUTING.md](CONTRIBUTING.md) file.

## Support the project and its author

If you think this project is useful and want to support it, please make a donation to [its author](https://github.com/DeveloppeurPascal). It will help to maintain the code and binaries.

You can use one of those services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* [Ko-fi (en français)](https://ko-fi.com/patrick_premartin_fr)
* [Ko-fi (in English)](https://ko-fi.com/patrick_premartin_en)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Liberapay](https://liberapay.com/PatrickPremartin)
* [Paypal](https://www.paypal.com/paypalme/patrickpremartin)

or if you speack french you can [subscribe to Zone Abo](https://zone-abo.fr/nos-abonnements.php) on a monthly or yearly basis and get a lot of resources as videos and articles.
