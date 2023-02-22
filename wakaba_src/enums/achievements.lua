-- Heavily taken from Fiend Folio
wakaba.Achievements = {
	-- Front side Character 
	{
		ID = "WAKABA",
		AlwaysUnlocked = true,
		Note = "achievement_wakaba",
		Name = "wakaba",
		Tags = {"Wakaba"},
		NoInsertTags = {"Wakaba"},
		Tooltip = {"the lucky girl appears"}
	},
	{
		ID = "SHIORI",
		AlwaysUnlocked = true,
		Note = "achievement_shiori",
		Name = "shiori",
		Tags = {"Shiori"},
		NoInsertTags = {"Shiori"},
		Tooltip = {"the librarian heroine appears"}
	},
	{
		ID = "TSUKASA",
		AlwaysUnlocked = true,
		Note = "achievement_tsukasa",
		Name = "tsukasa",
		Tags = {"Tsukasa"},
		NoInsertTags = {"Tsukasa"},
		Tooltip = {"the mysterious moonlight girl appears"}
	},
	{
		ID = "RICHER",
		AlwaysUnlocked = true,
		Note = "achievement_richer",
		Name = "richer",
		Tags = {"Richer"},
		NoInsertTags = {"Richer"},
		Tooltip = {"the maid girl from caramella appears"}
	},
	-- Flipped side Character
	{
		ID = "WAKABA_B", -- used for save data and code access, don't change!
		AlwaysUnlocked = true,
		Note = "achievement_wakabab",
		Name = "tainted wakaba",
		Tooltip = {"open a", "certain closet", "as wakaba"},
		Tags = {"WakabaUnlock", "Character", "WakabaB"},
		NoInsertTags = {"WakabaB"}
	},
	{
		ID = "SHIORI_B", -- used for save data and code access, don't change!
		AlwaysUnlocked = true,
		Note = "achievement_shiorib",
		Name = "tainted shiori",
		Tooltip = {"open a", "certain closet", "as shiori"},
		Tags = {"ShioriUnlock", "Character", "ShioriB"},
		NoInsertTags = {"ShioriB"}
	},
	{
		ID = "TSUKASA_B", -- used for save data and code access, don't change!
		AlwaysUnlocked = true,
		Note = "achievement_tsukasab",
		Name = "tainted tsukasa",
		Tooltip = {"open a", "certain closet", "as tsukasa"},
		Tags = {"TsukasaUnlock", "Character", "TsukasaB"},
		NoInsertTags = {"TsukasaB"}
	},
	{
		ID = "RICHER_B", -- used for save data and code access, don't change!
		AlwaysUnlocked = true,
		Note = "achievement_richerb",
		Name = "tainted richer",
		Tooltip = {"open a", "certain closet", "as richer"},
		Tags = {"RicherUnlock", "Character", "RicherB"},
		NoInsertTags = {"RicherB"}
	},

	-- Wakaba Unlocks
	{
		ID = "CLOVER",
		Note = "clover",
		Trinket = wakaba.Enums.Trinkets.CLOVER,
		Tooltip = {"beat", "mom's heart", "on hard", "as wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA, "Heart"},
		Tags = {"Wakaba", "Character"}
	},
	{
		ID = "COUNTER",
		Note = "counter",
		Item = wakaba.Enums.Collectibles.COUNTER,
		Tooltip = {"beat", "isaac", "as wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA, "Isaac"},
		Tags = {"Wakaba", "Character"}
	},
	{
		ID = "PENDANT",
		Note = "pendant",
		Item = wakaba.Enums.Collectibles.WAKABAS_PENDANT,
		Tooltip = {"beat", "???", "as wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA, "BlueBaby"},
		Tags = {"Wakaba", "Character"}
	},
	{
		ID = "D_CUP_ICECREAM",
		Note = "d_cup_icecream",
		Item = wakaba.Enums.Collectibles.D_CUP_ICECREAM,
		Tooltip = {"beat", "satan", "as wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA, "Satan"},
		Tags = {"Wakaba", "Character"}
	},
	{
		ID = "REVENGE_FRUIT",
		Note = "revenge_fruit",
		Item = wakaba.Enums.Collectibles.REVENGE_FRUIT,
		Tooltip = {"beat", "the lamb", "as wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA, "Lamb"},
		Tags = {"Wakaba", "Character"}
	},
	{
		ID = "DREAM_CARD",
		Note = "dream_card",
		Card = wakaba.Enums.Cards.CARD_DREAM_CARD,
		Tooltip = {"beat", "boss rush", "as wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA, "BossRush"},
		Tags = {"Wakaba", "Character"}
	},
	{
		ID = "COLOR_JOKER",
		Note = "color_joker",
		Card = wakaba.Enums.Cards.CARD_COLOR_JOKER,
		--Name = "+3 fireballs",
		Tooltip = {"beat", "hush", "as wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA, "Hush"},
		Tags = {"Wakaba", "Character"}
	},
	{
		ID = "UNIFORM",
		Note = "uniform",
		Item = wakaba.Enums.Collectibles.UNIFORM,
		--Name = "fiend's horn",
		Tooltip = {"beat", "delirium", "as wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA, "Delirium"},
		Tags = {"Wakaba", "Character"}
	},
	{
		ID = "WHITE_JOKER",
		Note = "white_joker",
		Card = wakaba.Enums.Cards.CARD_WHITE_JOKER,
		Tooltip = {"beat", "mega satan", "as wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA, "MegaSatan"},
		Tags = {"Wakaba", "Character"}
	},
	{
		ID = "CONFESSIONAL_CARD",
		Note = "confessional_card",
		Card = wakaba.Enums.Cards.CARD_CONFESSIONAL_CARD,
		--Name = "the devil's harvest",
		Tooltip = {"beat", "mother", "as wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA, "Mother"},
		Tags = {"Wakaba", "Character"}
	},
	{
		ID = "RETURN_POSTAGE",
		Note = "return_postage",
		Item = wakaba.Enums.Collectibles.RETURN_POSTAGE,
		Tooltip = {"beat", "beast", "as wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA, "Beast"},
		Tags = {"Wakaba", "Character"}
	},
	{
		ID = "SECRET_CARD",
		Note = "secret_card",
		Item = wakaba.Enums.Collectibles.SECRET_CARD,
		Tooltip = {"beat", "greed mode", "as wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA, "Greed"},
		Tags = {"Wakaba", "Character"}
	},
	{
		ID = "CRANE_CARD",
		Note = "crane_card",
		Card = wakaba.Enums.Cards.CARD_CRANE_CARD,
		Tooltip = {"beat", "greedier mode", "as wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA, "Greedier"},
		Tags = {"Wakaba", "Character"}
	},
	{
		ID = "WAKABAS_BLESSING",
		Note = "wakabas_blessing",
		Item = wakaba.Enums.Collectibles.WAKABAS_BLESSING,
		Name = "fiend folio",
		Tooltip = {"beat", "everything", "on hard", "as wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA, "All"},
		Tags = {"Wakaba", "Character"}
	},
	
	-- Tainted Wakaba Unlocks
	{
		ID = "BOOK_OF_FORGOTTEN",
		Note = "book_of_forgotten",
		Item = wakaba.Enums.Collectibles.BOOK_OF_FORGOTTEN,
		Tooltip = {"beat isaac,", "???, satan", "and the lamb", "as tainted", "wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA_B, "Quartet"},
		Tags = {"WakabaB", "Character"}
	},
	{
		ID = "SOUL_OF_WAKABA",
		Note = "soul_of_wakaba",
		Card = wakaba.Enums.Cards.SOUL_OF_WAKABA,
		Tooltip = {"beat boss", "rush and hush", "as tainted", "wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA_B, "Duet"},
		Tags = {"WakabaB", "Character"}
	},
	{
		ID = "CLOVER_CHEST",
		Note = "clover_chest",
		Tooltip = {"beat", "mega satan", "as tainted", "wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA_B, "MegaSatan"},
		Tags = {"WakabaB", "Character"}
	},
	{
		ID = "BLACK_JOKER",
		Note = "black_joker",
		Card = wakaba.Enums.Cards.CARD_BLACK_JOKER,
		Name = "reverse +3 fireballs",
		Tooltip = {"beat", "greedier mode", "as tainted", "wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA_B, "Greedier"},
		Tags = {"WakabaB", "Character"}
	},
	{
		ID = "EAT_HEART",
		Note = "eat_heart",
		Item = wakaba.Enums.Collectibles.EATHEART,
		Tooltip = {"beat", "delirium", "as tainted", "wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA_B, "Delirium"},
		Tags = {"WakabaB", "Character"}
	},
	{
		ID = "BITCOIN",
		Note = "bitcoin",
		Trinket = wakaba.Enums.Trinkets.BITCOIN,
		Tooltip = {"beat", "mother", "as tainted", "wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA_B, "Mother"},
		Tags = {"WakabaB", "Character"}
	},
	{
		ID = "WAKABAS_NEMESIS",
		Note = "wakabas_nemesis",
		Item = wakaba.Enums.Collectibles.WAKABAS_NEMESIS,
		Tooltip = {"beat", "beast", "as tainted", "wakaba"},
		CompletionMark = {wakaba.Enums.Players.WAKABA_B, "Beast"},
		Tags = {"WakabaB", "Character"}
	},




	-- Challenge Unlocks
	{
		ID = "EYE_OF_CLOCK",
		Note = "eye_of_clock",
		Item = wakaba.Enums.Collectibles.EYE_OF_CLOCK,
		Tooltip = {"complete", "electric disorder"},
		Tags = {"Challenge"},
		Challenge = true,
	},


}