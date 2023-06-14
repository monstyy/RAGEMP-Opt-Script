# RAGEMP Optimization Script | Outdated
This script has now become obsolete, owing to RageMP's implementation of such a "robust, sincere, and benevolent anti-cheat" — EasyAntiCheat, or in better words, the free knock-off wish.com version of Epic Online Services. Thanks to an unintelligent, inexperienced, incomplete, and inadequate execution of the anti-cheat system, a remarkably effortless bypass was devised to re-enable ENBs and ReShades for all the dedicated enthusiasts. 

The persistence in aggravating the majority of the playerbase by mandating the implementation of an anti-cheat, without considering their preferences, and anticipating universal compliance, continues to baffle me. The promise of delivering an "optional API for server owners to toggle EAC" was made nearly two years ago but remains unfulfilled. I devoted significant time and effort to this project with two primary objectives in mind. Firstly, to enhance users' experience and preserve their ability to utilize graphics mods. Secondly, I had the expectation that RageMP would acknowledge the unequivocal failure of their system and fulfill the commitments they made, which they have not to this day.

I must confess, I harbored uncertain and unrealistic expectations. I have devoted an extensive amount of time acquainting myself with the intricacies of RageMP's ergonomics, owing to a personal endeavor - a collaborative project undertaken with a friend of mine. Regrettably, upon pursuing the RageMP wiki for guidance, I was confronted by a drawing book of a kindergartener who cannot draw. It's undeniably a source of depression, charactarized by a glaring dearth of quality and pervasive sense of ambiguity. Their documentation suffers from a litany of incompetence and deficiencies; undocumented functions, blank pages, and an excess of unfinished tasks, or as how they call them, "todos." Consequently, we were compelled to compile our own compendium, featuring extensive explanations of their events, natives, and functions.

If you're a programmer who seeks to delve into the realm of their server development, I shit you not, it's easier to create a sophisticated app in assembly than the arduous task of learning how to browse their wiki, that's how bad things are. This probably epitomizes the sheer mockery that represents RageMP's codebase. For several years years, they have failed to solve countless issues including the texture loss tantrums, terrible synchronization, their inexplicable crashes, mysterious no-shows on integrated graphics cards, and many other issues. Yet, conveniently, they have seen fit to channel their efforts into implementing a half-assed anti-cheat that serves none but their own interests. Such individuals are burdened with priorities that are up their asses. Dare you speak of any of this on their Discord, you shall find yourself muted, shamed, and then finally banned.

Unfortunately, I neither have the time nor the willingness to devote more time into finding another bypass. The next bypass would very likely need to be at a kernel level, which is something I'm not going to tinker with for the convenience and the expediency of our users. Should a new opportunity present itself with a new method of bypassing EOS, I will rewrite the script in order to automate it. Otherwise, I will be investing my time in other pursuits of significance.

<hr>

<details> 
<summary>Archive:</summary>

# Introduction
A collection of scripts that optimize the RAGEMP client performance and re-enable the usage of ENB and ReShade once more after the introduction of EasyAntiCheat. 

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
## Prerequisites
RAGEMP has to be installed directly under the root of your drive. The game directory has to be free of any spaces due to Windows directory naming limitations.

**Example:** 
- ❌ RAGEMP is installed in: 
```
C:\Program Files\RAGEMP\ (Spaces in parent directory)
D:\RAGE MP\ (Spaces in folder name)
```
- ✅ RAGEMP is installed in: 
```
C:\RAGEMP\
D:\Games\RAGEMP\
```
## Installation
- Download the latest version from the [releases](https://github.com/monstyy/RAGEMP-Opt-Script/releases/latest/) page;
- Extract the downloaded archive in the root directory of your RAGEMP installation;
    - **If prompt**, add an exception in your antivirus for the archive and its extraction. 
- Run rage-setup.bat for the first time installation;
- **(Optional)** Press 5 in the script to create a shortcut on your Desktop and use it to launch RAGEMP from now on.

## Optimizations

- Reintroduced the ENB and ReShade back again in RAGEMP after their removal due to the introduction of EasyAntiCheat;
- Lowering the priority of EACLauncher during startup to elucidate the process of the game launching;
- Adding the ability to set the game priority to High despite EasyAntiCheat preventing the change of the game priority;
- Added a memory pool optimization override that's replaced upon game startup;
- Completely customizable script to suit the user's needs.

## Screenshots

![App Screenshot](https://i.ibb.co/CQfGqsJ/image.png)

![App Screenshot](https://i.ibb.co/3TVrbSS/image.png)
## Collaborators

- **[@monstyy](https://www.github.com/monstyy)** - Original author of the script
- **BadassBaboon** - Script testing and publishing
- **Law** & **Leeroy** - Discovery of the bypass method
## Support

Join the Baboon's Workshop discord server for further support:
[Baboon's Workshop](https://discord.gg/qRdVSkUW6n)
## License

[MIT](https://choosealicense.com/licenses/mit/)

</details>
