DeadSeaScrollsMenu.AddChangelog("Pudding n Wakaba", "Rira v129",
[[{FSIZE2}general

- added simple character
description for eid

- added car battery
description for eid

- added extra key option
for various active items

-- extra key is intended
for controllers that support
extra bindings

- bumped up dead sea scrolls
version to 7
(to fix several issues)

- added some hud elements
(can be activated from console)
-- lil timer
-- system timer
(requires luadebug or repentogon)

- revamped some hud elements,
allowing some elements to be top,
or bottom of the screen
(can be set from console)

- added some tmtrainer
exclusive effects

{FSIZE2}enhanced boss dest

- added dynamic health option
for target major bosses
(selected by default)

{FSIZE2}inventory descriptions

- added option
for starting cursor
-- character
-- collectible
-- collectible_modded
-- trinket

- added placeholder
for quality 5, 6 items

- added function to
make custom list,
custom titles

- [rgon] list of voided
actives are also be shown

- added new callback
for inventory descriptions

{FSIZE2}repentogon

- passive skill tree support
-- added tree support for wakaba

- wakaba's uniform
-- preview of type
from the slots are shown

- richer's uniform
-- preview of effect
from each room are shown

{FSIZE2}items

- [rgon] clear file
active, unlocked by default

{FSIZE2}balance

curse of the tower 2
- the item is now lazarusshared

wakaba's uniform
- blacklisted color joker
(for now)
- no longer requires
any charges
- slot change key is
changed to brackets,
drop key still changes
slot due to controller support
- now has inventory
descriptions integration

wakaba's nemesis
- no longer require soul hearts
for collectible for sale
-- tainted wakaba still
applies this effect
- no longer decreases
non damage stats
-- tainted wakaba still
applies this effect

grimreaper defender
- now death defend is
one time only for current room

minerva's aura
- no longer negates
fake damage
(dull razor)

lunar stone
- increased penalty
for lunar gauge on damage

magma blade
- add some minor synergies
-- the forgotten
-- spirit sword
-- mom's knife

flash shift
- reduced bonus flash
friction from
speed, range, shotspeed

range os
- stat multipliers
now apply correctly
- now reduces final
range limit while held.
this does not stack.

apollyon crisis
- now the item is
repentogon exclusive
- now can be activate
individual absorbed
active instead of default item
- activating individual
one changes active
charge to corresponding one
- selection can be
changed with extra key

richer's uniform
- devil : now the spawned
item disappears on room exit
- now has inventory
descriptions integration

lil rira
- no longer steals charges,
damage increases on consuming
active charges instead

- major changes with
book of shiori synergy effects

{FSIZE2}bug fixes

- fix plumy suddenly disappearing

- fix rira's bra
extra damage dealing 20%
instead of 25%

- fix an oversight that
items alter damage not
allowing to use blood bombs

- added some failsafe
from crashes

- fix lil richer, rabbit ribbon
losing charge if
isaac holds uncharged
timed item

- fix item spawn from
pnw items not being seeded

- fix m + flash shift
prevent moving entirely

- fix rira's bandage
+ glowing hourglass exploit

- reverted sakura capsule
revival mechanic to
non-rgon method
due to t.forgotten bug

- fix inventory description
lists rendering offscreen
if hud offset is not 100%

- fix trinket, passive
category eid reminder
causing errors

- fix book of the god
completely preventing death
even after 1 heart
limit remains

- fix boss room item pool
issue outside of rgon

- fix t.soul not absorbing
aqua trinkets

- fix an oversight with
aqua trinkets + mom's purse

- fix pnw familiars showing
wrong shooting animation
on left direction

- fix some wrong icons for
eid and invdesc character entries

]])

DeadSeaScrollsMenu.AddChangelog("Pudding n Wakaba", "Rira v128a",
[[{FSIZE2}v128c patch

- fix plumy suddenly
disappearing if too much damaged

- fix trinket flag check
not applied which was
supposed to be fixed in v128a

- fix tears always granted
by smelted trinkets
even isaac doesn't have azure rir

{FSIZE2}v128b patch

- fixed character pill
conversion not working

- detailed character infos
from pnw mod now appear
only in starting room
just like eid char infos

{FSIZE2}general

- updated chinese eid entries (v128)

- added an option to remove
rabbey ward effect.
this affects water(rgon only),
shockwave, and shader color effect.

- added an option to make
tainted rira to only see
trinkets even outside
of treasure rooms

- adjust rabbey ward
area calculation

{FSIZE2}new challenge

- [wb3] Melting Pica Run 2

{FSIZE2}balance

- concentration
-- no longer prevents
picking up lil batteries

{FSIZE2}bug fixes

- fix wakaba's uniform eid
modifier breking
card reading portals

- fix tainted rira health
system noy applying
outside of repentogon

- fix azure rir not converting
non-blacklisted trinkets

- fix clover luck multiplier
not applying for some items

- fix delimiter chance
insanely go high on 2+ stacks

- fix flag locked
trinkets appearing

- fix rabbey ward color
render from minimapi
incorrectly affecting
unrelated rooms

- fix broken rabbey wards
still emiting shockwave

- fix invdesc showing
unidentified pill informations

- fix some error without
minimapi enabled

- fix eid markup,
conditional format issues

]])

DeadSeaScrollsMenu.AddChangelog("Pudding n Wakaba", "Rira v128",
[[{FSIZE2}tainted rira

- an aqua girl has
arrived on the basement!

{FSIZE2}general

- happy richer's birthday!
added bonus mega mush
costume for richer
-- requires
mega mush suffix compat

- book of conquest + shiori
-- enemy selection now
will be canceled
if player is not
in normal state

- blacklisted glitched crown
from challenge w15

- aqua trinkets are
now achievement locked

- reworked compatibility
patches

{FSIZE2}repentogon

- magma blade explosion
immunity now uses
repentogon callback

- improved revival to
use repentogon functions

{FSIZE2}new challenge

- [w17] the floor is lava

{FSIZE2}items

- cross bomb
(complete w17)
- caramella candy bag
(t.rira quad)
- soul of rira
(t.rira duet)
- aqua trinkets
(t.rira mega satan)
- pink fork
(t.rira mother, rgon only)
- flip card
(t.rira greedier)
- rabbey ward
(t.rira deli)
- azure rir
(t.rira beast)
- ???
(pill, unlocked by default)

{FSIZE2}balance

- beetlejuice
-- now only change 1 pill
effect instead of 6

- anti balance
-- now identifies all
pills on pickup

- venom incantation
-- bosses now have reduced
chance for instakill
over time
(0% after 30 seconds)

- sakura capsule
-- revival is now one time use
-- sakura capsule is
lost on revival

- curse of the tower 2
-- now losing holy mantle
shields also triggers
6 golden troll bombs

- eye of clock
-- main lasers now deal
0.3x -> 0.75x damage
-- sub lasers now deal
0.3x -> 0.25x damage

- damage multiplier down
-- increased damage mult
decrease rate

{FSIZE2}bug fixes

- fix enhanced boss dest datas
loading from other saves

- fix some challenges crashing
on save and continue

- fix dice floors from winter
albireo rooms always being 1-pip

- fix wakaba's blessing/nemesis
removing polaroid/negative
selection in death certificate area

- fix nasa lover not applying
electric tears for isaac,
which was intended but
forgot to update description

- fix curse of sniper
preventing knife damage entirely

- fix curse of the tower 2
incorrectly spawning troll bombs

]])