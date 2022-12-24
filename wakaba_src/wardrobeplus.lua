

function wakaba:init_OldWardrobe(continue)
  if OWRP then
    OWRP.AddNewCostume("wakaba", "Wakaba's Hair", "gfx/characters/character_wakaba.anm2",false,false)
    OWRP.AddNewCostume("twakaba", "Wakaba's Red Hair", "gfx/characters/character_wakaba_b.anm2",false,false)
    OWRP.AddNewCostume("shiori", "Shiori's Hair", "gfx/characters/character_shiori.anm2",false,false)
    OWRP.AddNewCostume("tshiori", "Shiori's Minerva Hair", "gfx/characters/character_shiori_b.anm2",false,false)
    OWRP.AddNewCostume("twshiori", "Minerva's Revelation", "gfx/characters/character_shiori_b_body.anm2",true,false)
    OWRP.AddNewCostume("tsukasa", "Tsukasa's Hair", "gfx/characters/character_tsukasa.anm2",false,false)
  end
end
wakaba:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, wakaba.init_OldWardrobe)