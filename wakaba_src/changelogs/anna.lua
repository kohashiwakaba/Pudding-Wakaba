DeadSeaScrollsMenu.AddChangelog("Pudding n Wakaba", "Anna v131",
[[{FSIZE2}general

- reorganized conditional
eid for multiple copies
- added minor compatiblity
for 'found hud in the beast'
- added heart drain
hud effect for
t.rira (thanks to benny)
- added hidden
'forcelunatic' option.
can only be set through console
-- this option will
be removed after
save data refactor
- renamed 'bottle of runes'
item into 'rune archives'
to make proper transformation match
- changed isekai definition
item sprite to make
proper transformation match
- added hud library
by benevolusgoat
- added status effect library
by benevolusgoat
- added minor compatibilities for
lost and forgotten
- disabled damage penalty protection
for pnw items if
 astrobirth(not astroitems)
 or damo run(hy companion mod)
 is enabled
-- richer's bra still
gives protection
- removed all abyss synergies
from pnw items for now
(will be readded in later
patch with rep+ exclusive)

{FSIZE2}repentogon

- save sync with repentogon
now also checks game version
(rep or rep+)

- added hidden
'vanilla item quality tweaks'
option. can only be set
through console

- passive skill tree
-- added tree support
for tsukasa
-- added crimson nodes
for wakaba, shiori

-- [wakaba] impure girl
no longer gives birthright directly
instead added through innate item
(to prevent being removed)
-- [shiori] library assistant
fix outdated description
-- [shiori] become goddess
fix non-accurate description
-- [tsukasa] raid
increased cap of each
stats from 2 > 2.5
-- [tsukasa] magnetic obols
rewritten mechanics to fix
issues with deep space nodes

- difficulty library support
-- added 'up/down' difficulty
--- pressing '6/7' to
try shift up/down
--- shifting makes nearest
item to shift up/down of
random amount (1~5)
--- can only get shifted items.
quest items can be get
without duplication
--- some items are banned
in this difficulty

{FSIZE2}inventory descriptions

- added option to set
dim screen opacity
- (rgon) pressing f6 in
death certificate area
shows all items available
-- pressing esc teleports
player to room that
contains selected item

{FSIZE2}balance/bug fixes

- wakaba
-- birthright no longer
adds heart limit
if given as innate items

- book of the forgotten
-- no longer recovers full health

- revenge fruit
-- no longer gives x1.5
dmg mult on other weapons
-- now fires maw of the void
ring instead of brimstone
-- luck scale has changed
to 5% chance, 20% max at 39
-- no longer grants additional
chance for taking damage

- rabbey ward
-- now recovers soul heart
immediately on use
-- decreased soul heart
recover from 1 > 0.5

- lil rira
-- reduced damage ups for
timed actives from 0.05 per 12 sec
> 0.05 per 20 sec

- soul of richer
-- now grants items wisps
that isaac already own

- clensing foam
-- no longer works on
frozen enemies (like uranus)

- power bomb
-- reduced cooldown
from 4 > 6 rooms

- anna ribbons
-- general stat adjust
to match quality

- reduced general item pool weight

- wakaba
-- removed not-so hidden
uranus synergy

- tainted rira
-- heart drain rate now depends
on current heart count.
faster drain on more hearts

- wakaba's nemesis
- plasma beam
- advanced crystal
- new year's eve bomb
-- on lunatic mode,
now deal +15%p non-stat
damage instead of armor-piercing

- rira
- rira's swimsuit
- sakura mont blanc
-- ice damage against
aquafied enemies
now ignore enemies' armor

- wakaba's pendant
-- multiple copies
now raises minimum
luck by 0.25 per copy

- maijima mythology
-- book pool per game
that can be selected
is increased to 5 > 8

- plasma beam
-- extra copies
no longer multiplies
multiplier, it adds instead

- color joker
-- fix eid errors
-- no longer spawns cards.
only spawns items

- rira's uniform
-- cooldown decreased to 3 > 1

- lil rira
-- base familiar damage reduced to 4 > 3

- richer's uniform
-- devil : now price
will cycle between
2 hearts, 3 souls, and 36 coins
-- challenge : now duplication
chance is 50% (crooked penny)
and will trigger ambush
-- boss rush : now triggers
ambush and actives
devil effect on repeat usage

- double invader
-- dusty death's heads
and mockulus
now can be spawned
-- 2+ brimstone death's head
no longer appear
at the same time
-- mega satan room
is now properly sped up
-- camillo jr now has
reduced chance on
lunatic mode
(expect isaac got the actual item)
-- (non-rgon) fixed eucharist,
goat head opening deal room doors

- trolled!
-- now grants both polaroid
and negative if isaac
does not have one when
teleporting to i am error room

- fix eid issues with
dmg down pill

- dmg down pills now
caps at minimum 25% of damage

- attempt to fix
cross bomb + dr.fetus +
soy milk interactions

- fix possible issues with
deja vu that showing
invalid items and inherit items

- fix oversight with
lil rira charge + special charge
type items such as;
-- isaac's tears
(now counts as 1 second charge)
-- berserk
(now counts as 4 room charge)
-- eraser
(now counts as 12 room charge)

- fix lil rira not granting
damage ups with 9 bolt + timed actives

- fix richer's uniform
not working on challenge rooms

- (non-rgon) fix swapped
pedestals from clear file
granting on-pickup effects

- changed wakaba's uniform
charge type to normal.
this does not change
anything but fixes
minor eid issue

- fix easter coin spawn
chance option not
working properly

- fix wakaba's double dreams
infinitely spawning
dream card with car battery

- fix forcevoid option
for dad's note not preventing
bring me there trinket

- fix gamble difficulty keys
not working when starting new run

- fix deja vu
not working intentionally

- fix maijima eid
showing only 1 entry
outside of pst support

- fix using flash shift
removing invincibility
frames for t.tsukasa

- fix lil rira granting
isaac damage incorrectly
with timed items

- fix lil rira not granting
isaac damage if item
is not discarged
with modded items

- fix plumy + mom's knife
on non-rgon environment

]])

DeadSeaScrollsMenu.AddChangelog("Pudding n Wakaba", "Anna v130",
[[{FSIZE2}anna

- new challenge exclusive character
-- has innate chaos effect
-- starting with random quality,
getting an item shifts to next,
cycling to 0 > 1 > 2 > 3 > 4 > 0 ...
-- only selected quality can
be appeared, any item that is
not current quality
will be rerolled

{FSIZE2}general

- added unlock reminder paper
for wakaba characters
- room name display is
disabled by default
- luck based items chance
are shown on eid
- added tainted rira indicator
when outside of ward area
- mod name displayed by eid
is now randomized
- rgon exclusive items
no longer appear on
spindown/death certificate
on non-rgon environment
- removed unused lang
specific resources
- added compatibility
with enhanced boss bars
- updated compatibility
for next epiphany wave
-- prestige pass no longer
blacklisted for t.eden
-- added multitool
interaction with clover chest
-- added golden item synergy
for following items
--- clear file

{FSIZE2}repentogon

- expanded quality for
some wakaba items

- added character select
screen for korean

- passive skill tree
-- added tree support
for shiori
-- free clover chest open with
cloverfest now requires
clover chest to be unlocked
from completion marks

- difficulty library support
-- added 'gamble' difficulty
--- pressing '6' to eternal d6
--- pressing '7' to crooked penny
--- can only get
duplicated items.
quest items can be
get without duplication
--- some items are
banned in this difficulty

{FSIZE2}inventory descriptions
- added 'WakabaCallbacks.
INVENTORY_DESCRIPTIONS_(PRE/POST)
_LIST_(OPEN/CLOSE)'
callbacks for further usage

{FSIZE2}balance/bug fixes

- reduced general item pool weight

- adjusted shop price, quality

- adjusted mimic cooldown
for pocket items

- shiori
-- removed additional
shiori modes and options
--- all of shiori modes and
--- options are remixed to
--- passive skill tree support
-- blacklisted balance book for now

- reroll code refactor
-- now uses blacklist
based reroll like reverie
-- penalty damage protection
items no longer appear
when taking damage
as tainted eden
-- rerolled items now
reappear unlike before

- bring me there
-- now the trinket is lazarusshared

- ring of jupiter
-- now the trinket is lazarusshared

- aurora gem
-- now the trinket is lazarusshared
-- adjusted luck formula

- maid duet
-- now the item is lazarusshared
-- added missing maid girls
-- now can be summoned
via monster manual

- clear file
-- now is one of bookworm
transformation, cannot be in
shiori's book pool though

- kanae lens
-- now uses repentogon
for eye check, non-rgon
still uses old method

- sakura mont blanc
-- reduced dmg, tears

- queen of spades
-- drastically reduced
spawn rate (suit -> special)

- color joker
-- drastically reduced
spawn rate (suit -> special)

- eye of clock
-- orbiting lasers are more dense
-- reduced laser damage
--- circle : 0.75x -> 0.5x
--- sub : 0.25x -> 0.16x

- richer's flipper
-- now gives +1 of each bomb/key on pickup

- balance ecnalab
-- no longer gives coins, price reduced

- plumy
-- mom's knife now allows plumy shoot
knives correctly (thanks thecatwizard)

- tainted lost and tr lost(epiphany)
no longer revive through
following items as
innate items (such as tmtrainer)
-- see des bischofs
-- sakura capsule
-- jar of clover
-- bunny parfait
-- caramella pancake

- fix following items taking effect
for both forms of tainted lazarus
-- wakaba's blessing : only 100% angel
chance will be applied for both forms
-- wakaba's nemesis : only 0% angel
chance will be applied for both forms

- fix beetlejuice, anti balance
not identifing pills if granted
as eden (or eden's blessing)

- blacklisted delirium
transforming larry jr

- fix concentration rarely
crashing the game

- fix azure rir in lunatic mode
converting collectibles when
tainted rira's full pica options active

- fix clear file appearing
as shiori's pocket active

- fix aurora gem not
working as intended

- fix errors from eid item
reminder added by wakaba mod
on non-rgon environment

- fix apollyon crisis appearing
outside of rgon
as eden's starting item

- fix using soul of shiori
not resetting some
secondary effects

]])
