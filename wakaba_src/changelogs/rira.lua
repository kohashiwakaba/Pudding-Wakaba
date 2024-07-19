DeadSeaScrollsMenu.AddChangelog("Pudding n Wakaba", "Rira v115",
[[{FSIZE2}general

- vintage threat
-- now eid descriptions show
which item invalidates
damage penalty protection

- maid duet
-- now eid descriptions show
which item is blacklisted
for position swap

- 'inventory description'
code refactor
-- now grid mode is added
-- pressing 'f6' while in list
will switch grid and list mode
-- add functions to add append
entries that shows currently
-- list no longer affected
by eid transparency settings

- added eid icons for
-- wakaba status effects
-- aqua trinkets

- lunatic mode
-- mom's heart is now
mausoleum variant

{FSIZE2}repentogon
- phantom cloak
-- add charge bar render
-- actual effect is not changed

- inventory descriptions
-- add option to show passive
history instead of held passives
-- history list now shows
item pool for specific items

- some items no longer
work with metronome

- maid duet
-- blacklisted following items
(cooldown only)
--- notched axe
--- breath of life

{FSIZE2}balance

- quality, pool weight
has been changed for
some items

- bring me there
-- bring me there spawned
by mausouleum ii no longer
turns into aqua
-- normally spawned one
still has a chance
to be aqua

- easter egg
-- is no longer
eden's starting item

- caramalla pancake
-- reduced overall damage
from caramella flies
-- weapons fire normally
if fly count is exceeded

- lil wakaba
-- fire rate is now fixed
-- now laser has homing
properties by default

{FSIZE2}bug fixes

- fixed some collectibles spawned
from wrong item pool
due to damocles api

- fix majority of eid issues,
caused by default
markup settings

- fix shiori whitelist
not working with
timed items

- fix all pudding n wakaba
items considered as
quality 0 for
bag of crafting

- fix golden aqua trinkets
not being absorbed

- fix invdesc option being
on wrong position
in mod config menu

- fix revival items from
pudding n wakaba teleporting
from beast room

- fix jacob n esau
getting 2 damos each
from enhanced boss dest

- fix damage multiplier up
pills working as normal damage ups

- fix star reversal
not working when smelted
after bitcoin ii fix

- changed extra room
generation logic,
hopefully this fixes
death certificate crash issues
with winter albireo,
or book of shiori

- fix death's heads
outside of boss rooms
not being damaged
during lunatic mode

- fix vintage threat
damage flag check error,
resulting all damage
triggering damocles fall

- blacklisted rotgut
for executioner

]])

DeadSeaScrollsMenu.AddChangelog("Pudding n Wakaba", "Rira v114",
[[{FSIZE2}general
- add 'enhanced boss goal'
feature (demo)
-- pressing '=' on keyboard
(not keypad) opens a dialog
that can set extra goal
with uber health values.
--- pressing = again to close

-- following can be set
--- target
--- health (total health
that splits for each middle
major bosses.
mom and mom's heart
is not included)
--- start with damocles
--- lunatic mode (see below)
--- lock target until game clear

- add 'lunatic mode' feature
-- many of pudding n wakaba mod
items are really powerful,
making some players could
make the game trivial
-- lunatic mode significantly
weakens some items from wakaba mod
-- some items do not appear
in lunatic mode, and some
other items requires
repentogon to be appeared
-- currently exclusive to
'enhanced boss goal' feature
-- this invalidates
'godhead unnerf' mod

- add stat swap
option for rira
-- adds tears mult x0.33
and damage mult x3 for rira
-- this can be reduce
difficulty for rira but
can also help to
reduce lags by many tears
-- this option is always
active on lunatic mode

- room name display
-- weight value is shown
as '0.00x' format, rounded


{FSIZE2}repentogon
- clover chest
-- now works with
guppy's eye

- magma blade
-- now the item is
repentogon exclusive
-- now grants
explosive immunity
-- now shoots extra
blade and flame waves
every 20 tears

- maid duet
-- blacklisted
blighted/broken dice
(epiphany, charges only)
-- blacklisted items
by max charges now
preserves charges like 9 volt
-- now fully charges
active item on pickup

- fixed revival items
now shows revival counter
on hud
-- caramella pancake
-- bunny parfait
-- see des bischofs
-- jar of clover
-- vintage threat

{FSIZE2}balance

- lunatic mode changes
are not listed here,
check eid for each item
while on lunatic mode

 shiori
- blacklisted following items
-- leviticus
(milkshake vol1, temp)

bring me there
- now door to mausoleum heart
spawns in dad's note room
if held in case of tmtrainer.
beating mom's heart this way
cancels dad's note route
and continues to corpse

curse of the tower 2
- now bomb pickup
can convert into
golden troll bombs
- taking damage
now spanws 6 troll bombs
- reduced overall pool weight

eat heart
- indirect usage of item
(such as tmtrainer)
now activates metronome instead.
void usage still
spawns pedestal normally.

red corruption
- iteration count
reduced from 3 > 2

caramella pancake
- caramella flies
no longer get
pushed by explosions

self burning
- indirect usage of item
(such as tmtrainer)
now activates only
5 seconds in current room

black bean mochi
- reduced explosion
damage from 60 > 15

chimaki
- now tries to jump
if player is not reachable
on idle state
- no longer targets
friendly enemies

{FSIZE2}bug fixes

- fixed crystal restock
datas not loading in ascent

- (rgon) fix error log
showing for non-generic
difficulty
(such as insane from
community remix)

- fix bring me there
crashing the game
after save and continue

- fix curse of sniper
constantly prints
error message

- fix golden star reversal
overlapping 2
planetarium items

]])

DeadSeaScrollsMenu.AddChangelog("Pudding n Wakaba", "Rira v113",
[[{FSIZE2}general
- updated compatibility eid
-- some entries from
inventory description is now
available through new item reminder
--- character descriptions
--- curses descriptions
--- soul of shiori effects
--- wakaba's uniform
-- some hidden effects are
now available by enabling
eid's hidden descriptions
--- hidden effects are marked
as grey clover icon
-- repentogon exclusive effects
are marked as wakaba clover icon

- updated compatibility
for epiphany wave 6
-- shiori now has special
active charge interaction with
blighted/broken dice

- now warning will be shown
if not playing as repentogon

- challenges that starts with
tainted wakaba characters
now restart 1 more time
for the first time,
to fix issues with starting condition

- added options to adjust custom sounds
-- volumes for custom items sounds
--- default volume is reduced by 50%
-- custom item sounds for p&w items
-- custom hurt sounds for richer, rira

{FSIZE2}repentogon
- wakaba's double dreams, double invader
-- goad head, eucharist
is now overrided

- added discord rpc compatibility
from catinsurance

{FSIZE2}new items
- book of amplitude

{FSIZE2}balance

jar of clover
- now gives +1 luck
per 120 > 240 seconds

eye of clock
- circle lasers now appear
only if isaac is shooting
- only 1 circle laser
will be pop out initially,
will be increased up to 3
as long as holding shoot buttons

book of conquest
- indirect item
(unknown bookmark, tmtrainter,
or so on)
usage are limit to
40 cost instead of 160

nasa lover
- no longer gives
isaac electric tears

arcane crystal
- extra damage chance
reduced from 70% > 20%,
scales with luck

advanced crystal
- armor-piercing attack
chance reduced from 25% > 5%,
scales with luck

mystic crystal
- holy shield granted
is changed from soul hearts
to per 8 room clears
- max shield cound is
reduced from 5 > 2

maid duet
- blacklisted following items
(cooldown reduction only)
-- blighted/broken dice (epiphany)
-- sand pouch (sacred dreams)

caramella pancake
- flies no longer fly
through walls.
flies targeting enemies
still can fly through.

{FSIZE2}bug fixes

- fixed some elements
not restored by glowing hourglass
-- cunning paper

- esau's wakaba's uniform,
cunning paper now can be shown

- rabbit ribbon/lil richer
-- fix item not working
properly with shiori
-- fix saved charge
not transfering properly
with special cooldown actives

- self burning
-- fixed item description
not matching with its effects

- fix some outdated eid entries

- fix black bean mochi,
sakura mont blanc
affecting fireplaces

- fix tainted richer
prevent other characters
getting collectibles

- fix phd not working
with wakaba pills
after rira update

- fix wakaba's nemesis
armor piercing not working
with other characters

- fix tainted wakaba
not damaging enemies
through red candle

- fix custom pills
not working if
wakaba's uniform
has 1 or more pills

]])

DeadSeaScrollsMenu.AddChangelog("Pudding n Wakaba", "Rira v112",
[[{FSIZE2}general
- updated compatibility for
epiphany wave 6
-- added blacklist for tr lost
-- updated blacklist for tr eden
-- updated reroll mechanic check,
to make sure no more freezing
if revelations + pnw + epiphany
is active at the same time
- updated eid conditional descriptions
- improved shiori active item handler
-- this fixes potential
issues with lil rira

- chimaki debug hud no longer appears.
can be reshown by editing
debugChimaki value
from wakaba_flags.lua

{FSIZE2}repentogon

- challenge w04 : no longer starts
with notched axe,
but all main weapons
except of notched axe
are disabled

- richer's bra
-- now adds devil room chance +10%

{FSIZE2}balance

shiori
- blacklisted following items
-- everything jar

maid duet
- blacklisted following items (swap only)
-- placebo
-- blank card
-- clear rune
-- perfectly generic object
- blacklisted all epiphany characters (swap only)

range os
- range multiplier
reduced from 55% -> 40%

crisis boost
- overall damage multiplier
reduced from max 1.75x -> 1.45x

rira's bento
- items no longer rerolled into
bento while in full reroll (d4)

lil rira
- timed actives now count
120 second as 1 charge

{FSIZE2}bug fixes
- fixed some elements not
restored by glowing hourglass
-- lunar stone gauge
-- elixir of life max soul cap
-- concentration counter
-- challenge wb2 counter
-- wakaba's nemesis damage
-- crystal restock counter
-- lil richer counter
-- lil rira damage ups

- fix sakura mont blanc
ignoring tears down multiplier
from enemy kills

- fix unknown bookmark/maijima
mythology selecting unused book

- fix w04, w09 unlock not working correctly

- fix wakaba status effect
only apply one effect for bosses

- fix multiple status effect
not working with rira's bra,
and icon rendering

- fix some typos for
korean descriptions
- fix costume protector error
if wakaba characters
get 2+ brimstones
- fix notched axe
not working properly in w04
- fix clover shard
not appearing in w14
- fix shiori + lil rira + bitcoin
making infinite damage ups
- fix shiori + blank card
+ trial stew making infinite damage ups

]])

DeadSeaScrollsMenu.AddChangelog("Pudding n Wakaba", "Rira v111",
[[{FSIZE2}v111a patch
rira's bento
- reduced stats increments

bitcoin ii
- no longer noisy sounds
for glitched items
that use bitcoin ii

caramella pancake
- fix caramella pancake converting
normal bomb into ciel flies
- fix caramella flies
not chasing faraway enemies

maid duet
- fix maid duet blacklist
not working
- fix maid duet copying
first item slot if there are
no pocket actives
- maid duet no longer
reduce everything jar cooldown

{FSIZE2}rira update

- new character has been
appeared to basement

{FSIZE2}general stuff
- changed slot callback method
from isaacscript
to retribution/repentogon

- add custom items pools for
clover chest, valut rift

- Updated character portraits

- Bunny Parfait effect now
can be shown in Found HUD

{FSIZE2}repentogon additions

- following familiars from pudding & wakaba
now have higher priority

- completion marks and achievements
are now synced

- wakaba : no longer shows broken hearts
to make heart limit,
uses vanilla heart limit
mechanics instead

- player damage negate callbacks
changed to repentogon callbacks
-- this allows defending holy shields for negate

- global hud elements callbacks
changed to repentogon callbacks

- health type for
t.wakaba, t.shiori, t.richer
changed to repentogon callbacks
-- health type for tainted wakaba
changed to black -> soul
due to this change

{FSIZE2}items
- Kanae Lens : Unlocked by default
- Ancient Catalog : Defeat Isaac as Richer
- Richer's Bra : Unlocked by default
- Richer Ticket : Unlocked by default
- Rira Ticket : Unlocked by default

{FSIZE2}balance
- all items from pudding & wakaba
that grants curse of blind immunity
also changes some negative pills
into another one
-- amnesia -> i can see forever
-- retro vision -> vurp
-- i'm excited!!! -> gulp!
-- social distance -> duality orders

wakaba/wakaba's blessing
- emergency holy shields
now works like boss challenge rooms
- no longer reactivates
emergency holy shields
if already activated
on room enter

tainted wakaba/wakaba's nemesis
- no longer adds chances to
change cards to cracked key,
and guaranteed q3/4
in ultra secret rooms

tsukasa
- cannot concentrate repeatedly
until room clear
- max allowed stacks
are reduced further

richer
- birthright no longer removes
rabbit ribbon curses,
but all penalties from
rabbit ribbon curses are removed
-- curse of sniper : removes
transparent weapon penalty
-- curse of fairy : grants
spelunker hat effect
-- curse of magical girl :
all damage takes health
instead of instakill
-- curse of amnesia : no longer turns
cleared room into uncleared state,
instead, there is a chance to
trigger room clear effect
in already cleared room
- also adds innate extra trinket boost

tainted richer/the winter albireo
- baby plum in richer's planetarium
now immediately leaves when entered

syrup
- now has constant empty charges,
allowing to make some synergies

wakaba's uniform
- now consumes charges in all modes

wakaba's pendant
- increase price, quality

eat heart
- no longer gains overcharge and q4 bonus,
due to boss pools not having
q4 that causes errors
- using eat heart on overcharged
no longer depletes charge completely

book of shiori
- spawn extra library per floor,
previous item spawn is removed

minerva's aura
- gives additional x2.3
fire rate multiplier (does not stack)

shiori's valut
- now is divided into 2 variants
-- library ver that contains library pool
-- blue ver that contains custom pool
with blue themed items
- price is determined by quality and devil price.

concentration
- concentration no longer work
if stacks are 300 or more
- concentration speed is far more
reduced on high stacks

flash shift
- add an option to use health
if no remaining shifts are left
- uses half heart per extra shift
- does not work with tainted tsukasa
or extra high tears stat.
- neptunus gives flash shift
extra 2 shifts per cycle

red corruption
- creation of new rooms are now chance based
46% chance, 100% at 29 luck

question block
- temporarily removed, will be readded

lunar stone
- on gauge depleted,
creates an explosion
on isaac's position
- add some synergies with some items
-- luna : restore lunar gauge
with luna light beam.
-- sol/fragmented card :
drastically reduces lunar gauge
reduction speed
-- firefly lighter : grants chance
to shoot holy light shots

easter egg
- reverted previous change - now shows
all collected eggs on
the hud instead of one.
this is reverted because of genesis

elixir of life
- no longer regains holy shields
while in lost state.
regains holy mantle shields
if no the lost has no holy shields.
inv frames are normal in this state.

richer's necklace
- now has 11 frames of cooldown
- multiple copies of necklace
reduce cooldown

- stackable mantle
- make blanket also activete boss rush rooms

- bring me there
- now changes boss rooms
from mausoleum ii immediately
instead of checking before
entering the floor.
dropping the trinket
reverts the boss room into mom.
(does not work if entered through
polaroid/negative door in depths ii)
- bring me there no longer drops
in mines ii/mausoleum i.
it will drop in mausoleum ii instead.

crane card,
confessional card,
valut rift,
trial stew
- changed type from tarot > tarot r,
making spawn rate reduced.

{FSIZE2}tweaks + fixes

- fix trinkets trying to
convert into aqua every time
the pickup inits

- fix some items not available
from any item pools

- fix extra rooms not appearing
as tainted richer
with curse of labytinth

- fix power bomb explosion
not triggering
broken shovel falling

- lunar stone : fix weird revival
order with vanilla revival items

- library expanded : blacklisted
weird book from shiori

- fix potential issues with ascent
from clover chest/valut rift

- fix speed down not applying
with d-cup icecream + binge eater

- fix wrong order with
detailed respawn compatibility

- fix issues with hidden item
loading with save/continue

- adjust unique birthright
init order to fix errors
with unique items port pack

- fix winter albireo, easter egg
only working with
active side of tainted lazarus

]])