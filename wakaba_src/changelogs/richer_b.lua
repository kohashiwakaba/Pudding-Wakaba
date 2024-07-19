
DeadSeaScrollsMenu.AddChangelog("Pudding n Wakaba", "Richer v107",
[[{FSIZE2}v107d/e patch
- add chinese eid entries
thanks to youduckboom

- fixed some eid
descriptions not
applying latest
description data

{FSIZE2}v107c patch
- fix minor eid errors

- fix potential major issues with
epiphany compatibility

{FSIZE2}v107b patch
- easter egg now follows isaad
instead of orbiting

- all of wakaba's blessing
synergies are removed

- plumy's tears now follows
isaac's tear effects without
wakaba's blessing

- lunar stone now spawns
luna moonlight on starting of
each floor

- fixed winter albireo not working
on certain situations

- fixed eid error from
all stats down pill

{FSIZE2}v107a patch
- fixed water-flame, winter albireo
not available in any item pools

tainted richer
added shortcut portal that
leads to tainted richer planetarium
for first floor

all tainted richer planetariums
now have white fireplace.
getting winter albireo as tainted richer
or multiple copies of winter albireo
as other characters makes
tainted richer planetariums to spawn
extra collectibles.
(limit 2 extra copies for now)

{FSIZE2}general stuff
changed pickup indexing method
achievement papers for tainted richer
completion marks for
tainted richer now can be recorded

{FSIZE2}items
???
???

{FSIZE2}balance
rabbit ribbon
- curse of labyrinth buffs now only
spawns extra treasure, shops.
-- extra rooms spawned by rabbit ribbon
will only have room layouts from p&w mod.
-- rabbit ribbon treasure rooms
can be appeared normally,
but shops do not.
- curse of magical girl now allows
using blood donation machines,
curse rooms, sacrifice room spikes.
-- this does not protect from
all non-penalty damage sources.

counter
- increased cooldown from 5 > 8 seconds
- now fires 1 laser per activation

wakaba's nemesis
- adjust stats when isaac get items,
instead of constant checking

murasame
- now is a passive item,
removed previous on-use effect
- adds duality effect, multiple copies make
random item free for devil/angel shop,
and remove selection status from
random item for angel room.

phantom cloak
- enemies no longer stay dumb while active.
only get confusion.

soul of richer
- only grants 3 lemegeton wisps
with clear rune

magnet heaven (gold)
- magnetize enemies for 5 secs
on room enter

star reversal
- also allow tainted richer planetariums
- add option to drop pedestals
for smelted ones

{FSIZE2}tweaks + fixes
fixed some achievement papers not appearing

fixed book of shiori room/floor
synergies not resetting

fixed locked cards/runes appearing
through rune bag, book of shiori/fruit cake,
or booster pack.

curse room door images no longer
being converted to
tainted richer planetarium door.

fixed wakaba's blessing shield
not working on starting room.

fixed siren stealing murasame familiar

]])

DeadSeaScrollsMenu.AddChangelog("Pudding n Wakaba", "Richer v106",
[[{FSIZE2}tainted richer
item pedestals will be
tinted with purple temporarily
if tainted richer is nearby

- this doesn't apply if
tainted richer won't convert into flames

tainted richer planetariums
now can be spawned on first floor

tainted richer planetariums
now replaces golden treasure rooms
on greed mode

{FSIZE2}general stuff
added found hud configuration

{FSIZE2}Epiphany Compatibility
reserved tarnished characters entries

fixed using invalid group
that causing console errors

added golden active synergies
for some items

tr keeper no longer converts
clover chest on touch

added turnover shops layouts for
tainted richer planetariums

tr eden can no longer charge active items
through rabbit ribbon/lil richer

added throwing bag generic synergies
for most items

{FSIZE2}items
soul of richer
eternity cookie

{FSIZE2}balance
duality orders
now guarantees devil/angel room
for current floor (eucharist + duality)
horse variation still spawns 2 items

hellish vomit
original effect is moved to horse variation
now grants brimstone for current room

unholy curse
now breaks 2 mantle shields
for horse variation correctly

self burning
taking hit by projectile while active
will grant 1 second of invincibility,
to prevent continious hit by other sources

bitcoin ii
reduce speed of pickup count shuffling
disappears once dropped

lunar stone
adjust lunar gauge management

{FSIZE2}tweaks + fixes
fixed horse pills not working
after 1.7.9b patch

fixed horse pill descriptions not applying

fixed crystal restocks not working
due to latest update

excluded fireplaces being damaged
by plasma beam, resulting constant
damage sound in water rooms

fixed wakaba's uniform not accounting
for horse pill activation
if any player has anti balance

fixed tainted richer's planetariums
not available for greed mode

]])

DeadSeaScrollsMenu.AddChangelog("Pudding n Wakaba", "Richer v105",
[[{FSIZE2}general stuff
added some hud stuff
- room name display
- simple hit count

{FSIZE2}balance
lunar stone no longer use
soul heart to heal
and also no longer
is affected by
self damage.
dying through
self damage
still affects
lunar stone

lunar stone gauge is
recovered by room clears,
more room clears
decreases reduction speed

clearing boss rooms
now recovers lunar stone
completely, and
no longer reduces gauge

d6 plus/chaos reverts
item pedestal state
to untouched

increases d6 plus
cooldown from 4 to 6

increase determination ribbon
force-drop rate to
2% > 8% (hard),
0.5% > 2% (normal)

{FSIZE2}tweaks + fixes
blacklisted cursed trinkets
from retribution
to be changed into
aqua trinkets

fix richer's necklace
damaging player
due to errors

]])

DeadSeaScrollsMenu.AddChangelog("Pudding n Wakaba", "Richer v104",
[[{FSIZE2}tainted richer changes
crystal restocks in
winter albireo planetariums
grants more reroll counts
if any player has
more options.

all pedestals in
winter albireo planetariums
can be picked up
without selection.

{FSIZE2}new challenges
[w16] runaway pheromones

{FSIZE2}new items n stuff
richer's necklace

{FSIZE2}balance
rabbit ribbon preserves
charges like lil richer
(max 20)

extra rabbit ribbon
adds 4 extra max charges.

reduced lil richer
max charge counter
from 16 to 12.

{FSIZE2}tweaks + fixes
fix eid korean descs
for modded items
not working properly.

korean names for items
now displayed correctly
for multiple players
like j/e.

fix p&w familiars
not synergized with
marked
(or simmilar synergy).

fix explosions from
valut rift
destroying nearby machines.

fix wakaba's uniform
crashing the game
when showing
pill descriptions.

fix tsukasa reviving
temporarily if
she got damage on
less than 4 perc.

]])


DeadSeaScrollsMenu.AddChangelog("Pudding n Wakaba", "Richer v103",
[[{FSIZE2}general stuff

added tainted richer. (wip)

added birthright sprites for
pnw characters.
(requires unique items api)

changed rabbit ribbon
curses icon color.

wakaba's double dreams
no longer shows
current pool within hud text,
instead is shown
on the book itself,
wakaba's current dream
from double dreams
is also shown in
eid's item reminder.
(special thanks for
connor for the code)

destiantions now show
correctly for pnw challenges.
(hush, delirium, the beast)

added reference table entries
for fiend folio.

updated isaacscript-common,
hidden item manager,
pause screen completion marks api.

added achievement papers for richer.

completion marks for richer
now can be recorded.

all pnw characters now have own
steven dialouge for the future.

book of shiori code refactor.

{FSIZE2}curse of flames changes

while in curse of flames,
only 'summonable' tag will be
selected from item pool.

actives and non-summonable items
now can be taken normally.

death certificate, and genesis rooms
are not affected by curse of flames.

item wisp from curse of flames
no longer have increased health.

tainted richer is being considered
as curse of flames always active.

{FSIZE2}new challenges
[w15] even or odd
[wb2] super-sensitive richer-chan

{FSIZE2}new items n stuff
the winter albireo
water-flame
richer's flipper
crisis boost
richer's uniform
self burning
pow block
mod block
kuromi card
crystal restock machines

{FSIZE2}balance
vintage threat now can be
activated immediately
by using '0' key
(can be configured)

maijima mythology now only activates
from 5 books per run.
the books are selected
depending on game's seed.

tsukasa no longer shoots
short range of lasers
if she has technology
or brimstone.

richer now has innate
the wafer effect.

richer's sweets catalog
can be moved into pocket active slot
if richer defeats isaac.

adjusted lil moe's
random tear effect selection.

wakaba's uniform now collects
nearest pocket item
instead of held ones.

wakaba's double dreams is
no longer ignored by lawful
(deliverance),
lawful only works if
wakaba's dreams from dd is not set.

wakaba's uniform can no longer
store following cards or pills:
- ancient recall
- wild card (temporary)
- ? card
- vurp!
- any gold pills
- pot of greed (fiend folio)
- small contraband (fiend folio)
- christmas cracker (fiend folio)
- denial dice (samael)

minerva's aura no longer
heals item wisps
if curse of flames is active.

book of the fallen now spawns
hungry soul ghosts
instead of flames.
ow can be used before revival,
but only spawns
3 purgatory ghosts instead of 10.

damage multiplier from
book of the fallen's revival
reduced from 16x to 7x.

power bomb is 4-room charge,
no longer uses/drops bombs
and deal fixed amount of damage.

power bomb also pulls
pickup towards explosion point.

curse of sniper now gives
x2 range multiplier,
x3 damage multiplier,
and can damage enemies at any range,
but richer cannot see her weapons.

curse of amnesia now chance to
force-activates d7
in custom stages
from custom stage api.

prestige pass now spawns
its own(nerfed) crystal restock
that only gives 2 rerolls.

delimiter no longer breaks
super secret rocks,
to fix conflict with
rune rocks for retribution.

neko figure no longer grants
pierce armor for explosion damage.

new year eve's bomb no longer
sets enemy's health to 1,
instead armor-piercing damage
for explosion is granted.
pre-existing armor-piercing
explosions deals 2x damage for enemies.

new year eve's bomb now allows
tainted ??? to use bombs
for 3 poop manas,
but no longer gives poop manas.

plasma beam now deals
1.25x laser damage,
pre-laser attack
pierces enemies' armor.
previous effect was
removed entirely.

trial stew now gives
8 stacks of unique 'trial stack.
each stack gives +1 fire rate,
+25% damage, and bonus +100% damage
if trial stacks remain.
each room clear fully charges
active item and remove 1 trial stack.

return token sets time counter
to 1 sec instead of 0.

various item quality,
charges, item pool changes

{FSIZE2}tweaks + fixes

fixed possible bug within
irregular quality value.
(-1, or 5+)

rabbit ribbon no longer converts
curse of the lost
while in samael's extra rooms.

fixed lil shiva shooting
wave of tears infinitely
on rapid attack button presses.

fixed eat heart charging
with invincible enemies.

fixed some trinket reroll mechanics,
or rock trinket spawning
outside of golem for fiend folio.

fixed some custom special rooms
for minimapi resetting
while in curse of fairy.

fixed wakaba's double dreams
not updating guppy's eye
expectation on use.

fixed curse of amnesia
turning starting room
as uncleared state.

fixed curse of amnesia
using same award seed,
resulting room clear drop
being same per room.

fixed power bomb loop sound
not stopping on room move
before the effect ends.

grimreaper defender now
removes all of damocles
passives instead of 1.

fixed lil mao achievement
paper missing.

fixed see des bischofs,
jar of clover
appearing in challenges.

]])
