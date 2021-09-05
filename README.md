# p1n-mafias
A simple mafias script - Rewrote by lilfraae a.k.a. Xxpromw3mtxX

## Creating Issue
* Check the [Closed Topics](https://github.com/xxpromw3mtxx/p1n-mafias/issues?q=is%3Aissue+is%3Aclosed) & [Wiki](https://github.com/Xxpromw3mtxX/p1n-mafias/wiki) before opening an issue to see if your issue has already been Answered.
* Do NOT Delete the Pre-Written Text in the issue.
* Failue to due any of the above will result in Topic being deleted & you being Blocked. The Pre-Written text helps me with getting to the Bottom of the Issues & I hate explaining things over & over.

## Helpful Info
* Easy to use
* Almost plug & play
* Setup new mafias or gangs

## Requirements
* Required:
    * [ESX](https://github.com/esx-framework/esx-legacy/tree/main/%5Besx%5D/es_extended)
    * [esx_inventoryhud](https://github.com/Trsak/esx_inventoryhud)
    * [esx_society](https://github.com/esx-framework/esx-legacy/tree/main/%5Besx_addons%5D/esx_society)
* Optional:
    * None

## Download & Installation
1. Download Master or Release & Extract the .zip or Open the .zip.
2. Import the `*.sql` file, if included.
3. Edit the `config.lua` before starting the script.
4. Add `ensure p1n-mafias` in your server.cfg
5. You're set!
6. **Do not change the name or it will not work.**

## Add more Gang or Mafia
1. Open the `config.lua` file.
2. Inside the `Config.mafias` statement add this code for each gang or mafia you want to add:
```
    {
        Name = 'Cartello', --The name is pretty much a reminder for you
        job = 'cartel', --This is important, this HAVE to be the name of the job inside your database
        inV = vector3(1405.7, 1137.6, 109.7), --Inventory coordinates
        bossM = vector3(1395.1, 1160.1, 114.3), --Boos Menu coordinates
        cloaK = vector3(1394.9, 1157, 114.3) --Cloackroom coordinates
    },
```
3. Use the included SQL file and change the sets flags (**NOT TESTED**).
4. You're set!

## Known Bugs/Issues
* None for now

## Credits/Original Code
* [Pa1nless](https://github.com/Pa1nless)
    * [p1n-mafias](https://github.com/Pa1nless/p1n-mafias)

## Legal
### License
p1n-mafias - A simple mafias script

Copyright (C) 2011-2021 lilfraae/Xxprom3mtxX

This program Is free software: you can redistribute it And/Or modify it under the terms Of the GNU General Public License As published by the Free Software Foundation, either version 3 Of the License, Or (at your option) any later version.

This program Is distributed In the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty Of MERCHANTABILITY Or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License For more details.

You should have received a copy Of the GNU General Public License along with this program. If Not, see http://www.gnu.org/licenses/.
