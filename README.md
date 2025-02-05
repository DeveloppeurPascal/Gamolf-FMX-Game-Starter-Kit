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

## Using this video game

Visit [the starter kit website](https://fmxgamestarterkit.developpeur-pascal.fr)  to download the compiled version of the demo games, learn more about how it works, access videos and articles, find out about the different versions available and their features, contact user support...

## Talks and conferences

### Dev Days of Summer 2024

* [Make games in Delphi (2024 edition)](https://github.com/DeveloppeurPascal/DevDaysOfSummer2024-MakeGamesInDelphi) (the code repository)

* [Make games in Delphi (2024 edition)](https://www.youtube.com/live/M7DcEDbuESQ?feature=shared&t=3911) (live session during the conference, in English)
* [Faites des jeux en Delphi (v2024)](https://serialstreameur.fr/faites-des-jeux-en-delphi-edition-2024.html) (in French)

### YouTube

* [Gamolf FMX Game Starter Kit playlist](https://www.youtube.com/playlist?list=PLpkkg2iiC8yjkhmHDs42arEqvJm-m7006)

### Twitch

Follow my development streams of software, video games, mobile applications and websites on [my Twitch channel](https://www.twitch.tv/patrickpremartin) or as replays on [Serial Streameur](https://serialstreameur.fr/gamolf-fmx-game-starter-kit.html) mostly in French.

## Source code installation

To download this code repository, we recommend using "git", but you can also download a ZIP file directly from [its GitHub repository](https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit).

This project uses dependencies in the form of sub-modules. They will be absent from the ZIP file. You'll have to download them by hand.

* [DeveloppeurPascal/AboutDialog-Delphi-Component](https://github.com/DeveloppeurPascal/AboutDialog-Delphi-Component) must be installed in the ./lib-externes/AboutDialog-Delphi-Component subfolder.
* [DeveloppeurPascal/CilTseg4Delphi](https://github.com/DeveloppeurPascal/CilTseg4Delphi) must be installed in the ./lib-externes/CilTseg4Delphi subfolder.
* [DeveloppeurPascal/Delphi-Game-Engine](https://github.com/DeveloppeurPascal/Delphi-Game-Engine) must be installed in the ./lib-externes/Delphi-Game-Engine subfolder.
* [DeveloppeurPascal/librairies](https://github.com/DeveloppeurPascal/librairies) must be installed in the ./lib-externes/librairies subfolder.

## Documentation and support

I use comments in [XMLDOC](https://docwiki.embarcadero.com/RADStudio/en/XML_Documentation_Comments) format in Delphi to document my projects. They are recognized by Help Insight, which offers real-time input help in the code editor.

I regularly use the [DocInsight](https://devjetsoftware.com/products/documentation-insight/) tool to enter them and check their formatting.

Documentation is exported in HTML by [DocInsight](https://devjetsoftware.com/products/documentation-insight/) or [PasDoc](https://pasdoc.github.io) to the /docs folder of the repository. You can also [access it online](https://developpeurpascal.github.io/Gamolf-FMX-Game-Starter-Kit) through the hosting offered by GitHub Pages.

Further information (tutorials, articles, videos, FAQ, talks and links) can be found on [the project website](https://fmxgamestarterkit.developpeur-pascal.fr) or [the project devlog](https://developpeur-pascal.fr/gamolf-fmx-game-starter-kit.html).

If you need explanations or help in understanding or using parts of this project in yours, please [contact me](https://developpeur-pascal.fr/nous-contacter.php). I can either direct you to an online resource, or offer you assistance in the form of a paid or free service, depending on the case. You can also contact me at a conference or during an online presentation.

## Compatibility

As an [Embarcadero MVP](https://www.embarcadero.com/resources/partners/mvp-directory), I benefit from the latest versions of [Delphi](https://www.embarcadero.com/products/delphi) and [C++ Builder](https://www.embarcadero.com/products/cbuilder) in [RAD Studio](https://www.embarcadero.com/products/rad-studio) as soon as they are released. I therefore work with these versions.

Normally, my libraries and components should also run on at least the current version of [Delphi Community Edition](https://www.embarcadero.com/products/delphi/starter).

There's no guarantee of compatibility with earlier versions, even though I try to keep my code clean and avoid using too many of the new ways of writing in it (type inference, inline var and multiline strings).

If you detect any anomalies on earlier versions, please don't hesitate to [report them](https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit/issues) so that I can test and try to correct or provide a workaround.

## License to use this code repository and its contents

This source code is distributed under the [AGPL 3.0 or later](https://choosealicense.com/licenses/agpl-3.0/) license.

You are free to use the contents of this code repository anywhere provided :
* you mention it in your projects
* distribute the modifications made to the files provided in this AGPL-licensed project (leaving the original copyright notices (author, link to this repository, license) must be supplemented by your own)
* to distribute the source code of your creations under the AGPL license.

If this license doesn't suit your needs (especially for a commercial project) I also offer [classic licenses for developers and companies](https://fmxgamestarterkit.developpeur-pascal.fr).

Some elements included in this repository may depend on third-party usage rights (images, sounds, etc.). They are not reusable in your projects unless otherwise stated.

The source codes of this code repository as well as any compiled version are provided “as is” without warranty of any kind.

## How to ask a new feature, report a bug or a security issue ?

If you want an answer from the project owner the best way to ask for a new feature or report a bug is to go to [the GitHub repository](https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit) and [open a new issue](https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit/issues).

If you found a security issue please don't report it publicly before a patch is available. Explain the case by [sending a private message to the author](https://developpeur-pascal.fr/nous-contacter.php).

You also can fork the repository and contribute by submitting pull requests if you want to help. Please read the [CONTRIBUTING.md](CONTRIBUTING.md) file.

## Support the project and its author

If you think this project is useful and want to support it, please make a donation to [its author](https://github.com/DeveloppeurPascal). It will help to maintain the code and binaries.

You can use one of those services :

* [GitHub Sponsors](https://github.com/sponsors/DeveloppeurPascal)
* Ko-fi [in French](https://ko-fi.com/patrick_premartin_fr) or [in English](https://ko-fi.com/patrick_premartin_en)
* [Patreon](https://www.patreon.com/patrickpremartin)
* [Liberapay](https://liberapay.com/PatrickPremartin)
* [Paypal](https://www.paypal.com/paypalme/patrickpremartin)

You can buy [my softwares](https://lic.olfsoftware.fr/products.php?lng=en), [my video games](https://lic.gamolf.fr/products.php?lng=en) or [a developer license for my libraries](https://lic.developpeur-pascal.fr/products.php?lng=en) if you use them in your projects.

If you speak French [subscribe to Zone Abo](https://zone-abo.fr/nos-abonnements.php) to access my complete online archive (articles, videos, training videos, ebooks).
