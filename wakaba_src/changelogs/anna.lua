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
