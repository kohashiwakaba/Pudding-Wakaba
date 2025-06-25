
local isc = _wakaba.isc

wakaba:RegisterPatch(0, "battleFantasy", function() return (battleFantasy ~= nil) end, function()
	do
		wakaba:BlacklistBook(battleFantasy.Items.BF_MONEY_MAKING_GUIDE, wakaba.bookstate.BOOKSHELF_SHIORI)
		wakaba:BlacklistBook(battleFantasy.Items.BF_MONEY_MAKING_GUIDE, wakaba.bookstate.BOOKSHELF_SHIORI_DROP)
		wakaba:BlacklistBook(battleFantasy.Items.BF_MONEY_MAKING_GUIDE, wakaba.bookstate.BOOKSHELF_UNKNOWN_BOOKMARK)
	end
end)
