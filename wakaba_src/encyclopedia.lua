local players = wakaba.Enums.Players
local items = wakaba.Enums.Collectibles
local trinkets = wakaba.Enums.Trinkets
local cards = wakaba.Enums.Cards
local pills = wakaba.Enums.Pills

if not Encyclopedia then
return
end

wakaba.encyclopediadesc.class = "Pudding n Wakaba"
wakaba.encyclopediadesc.desc = {}

wakaba.encyclopediadesc.desc.char_sorted_keys = {
wakaba.Enums.Players.WAKABA,
wakaba.Enums.Players.WAKABA_B,
wakaba.Enums.Players.SHIORI,
wakaba.Enums.Players.SHIORI_B,
wakaba.Enums.Players.TSUKASA,
wakaba.Enums.Players.TSUKASA_B,
wakaba.Enums.Players.RICHER,
wakaba.Enums.Players.RICHER_B,
wakaba.Enums.Players.RIRA,
wakaba.Enums.Players.RIRA_B,
wakaba.Enums.Players.WAKABA_T,
wakaba.Enums.Players.SHIORI_T,
wakaba.Enums.Players.TSUKASA_T,
wakaba.Enums.Players.RICHER_T,
wakaba.Enums.Players.RIRA_T,
}

include('wakaba_src.compat.encyclopedia.characters')

include('wakaba_src.compat.encyclopedia.entries_collectibles')
include('wakaba_src.compat.encyclopedia.entries_trinkets')
include('wakaba_src.compat.encyclopedia.entries_cards')
include('wakaba_src.compat.encyclopedia.entries_pills')
--include('wakaba_src.compat.encyclopedia.entries_mechanics')
include("wakaba_src.compat.encyclopedia.starting")
include("wakaba_src.compat.encyclopedia.default")
include("wakaba_src.compat.encyclopedia.wakaba")
include("wakaba_src.compat.encyclopedia.shiori")
include("wakaba_src.compat.encyclopedia.tsukasa")
include("wakaba_src.compat.encyclopedia.richer")
include("wakaba_src.compat.encyclopedia.rira")
include("wakaba_src.compat.encyclopedia.challenge")
