local PLUGIN = PLUGIN

PLUGIN.name = "Система фракций"
PLUGIN.author = "БО, джеймс Б.О!"
PLUGIN.description = "У него там тарелка в кустах под Выборгом"

--[[
——————————————————————————————————————no cmbmutant.xyz?———————————————————————————
          .                                                      .
        .n                   .                 .                  n.
  .   .dP                  dP                   9b                 9b.    .
 4    qXb         .       dX                     Xb       .        dXp     t
dX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb
9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP
 9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP
  `9XXXXXXXXXXXXXXXXXXXXX'~   ~`OOO8b   d8OOO'~   ~`XXXXXXXXXXXXXXXXXXXXXP'
    `9XXXXXXXXXXXP' `9XX'   DIE    `98v8P'  HUMAN   `XXP' `9XXXXXXXXXXXP'
        ~~~~~~~       9X.          .db|db.          .XP       ~~~~~~~
                        )b.  .dbo.dP'`v'`9b.odb.  .dX(
                      ,dXXXXXXXXXXXb     dXXXXXXXXXXXb.
                     dXXXXXXXXXXXP'   .   `9XXXXXXXXXXXb
                    dXXXXXXXXXXXXb   d|b   dXXXXXXXXXXXXb
                    9XXb'   `XXXXXb.dX|Xb.dXXXXX'   `dXXP
                     `'      9XXXXXX(   )XXXXXXP      `'
                              XXXX X.`v'.X XXXX
                              XP^X'`b   d'`X^XX
                              X. 9  `   '  P )X
                              `b  `       '  d'
                               `             '
—————————————————————————————————————————————————————————————————————————————————
]]

ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")
ix.util.Include("sh_shop.lua")
ix.util.Include("sv_shop.lua")

---from RANKS plugin---
ix.util.Include("cl_ranks.lua")
ix.util.Include("sh_ranks.lua")
ix.util.Include("sv_ranks.lua")
---from RANKS plugin---

--FFS--
PLUGIN.Circles = ix.util.Include("libs/cl_circles.lua")
----

PLUGIN.Shipments = {
  ["??? #1"] = {     
    "nuts",
    "helmet_shlem_21",
    "gpred",
    "propanetank",
    "alkagol2",
    "nuts",
    "band_red",
  },
  ["??? #2"] = {     
    "perelom",
    "aztreonam_box",
    "novox_box",
    "paracetamol_box",
    "armbint",
    "paracetamol",
    "metro_medkit2",
    "armbintors", 
  },
  ["??? #3"] = {     
    "glassess_1",
    "glassess_4",
    "helmet_shapka_2",
    "helmet_shapka_4",
    "helmet_shapka_5",
  },

  ["??? #4"] = {     
    "ammo_1270",
    "ammo_15mm",
    "ammo_545x39",
    "ammo_762x51",
    "ammo_pistol",
    "avtomatcorobkweap",
    "insulatingtape",
    "weaponparts",
  },

  ["??? #5"] = {     
    "packofscrews",
    "matches",
    "sol",
    "ducttape",
    "pustpachkatwo",
    "copypaper",
    "hobo_kit",
    "repairkit",
  },
}

PLUGIN.Buttons = {
  ["UpgradeStorage"] = {
		name = "Улучшить склад ЕД.",
		price = 100,
    derma = false,
    callback = function(client, entity)
      entity:SetMaxStorage(entity:GetMaxStorage() + 50)
      entity:SetUpgradeCostStorage(entity:GetUpgradeCostStorage() * 1.1)
      PLUGIN.Buttons["UpgradeStorage"].price = entity:GetUpgradeCostStorage()
      entity:SetNetVar("UpgradeStorage", PLUGIN.Buttons["UpgradeStorage"].price)
    end,
	},

  ["UpgradeBank"] = {
		name = "Улучшить хранилище ЕД.",
		price = 100,
    derma = false,
    callback = function(client, entity)
      entity:SetBankWH(entity:GetBankWH() + 1)
      entity:SetUpgradeCostBank(entity:GetUpgradeCostBank() * 1.8)
      PLUGIN.Buttons["UpgradeBank"].price = entity:GetUpgradeCostBank()
      entity:SetNetVar("UpgradeBank", PLUGIN.Buttons["UpgradeBank"].price)
    end,
	},


	-- ["UpgradePassive"] = {
	-- 	name = "Улучшить пассивный доход",
	-- 	price = 250,
  --   derma = false,
  --   callback = function(client, entity)
  --     entity:SetPassiveIncome(entity:GetPassiveIncome() + 1)
  --     entity:SetUpgradeCostPassive(entity:GetUpgradeCostPassive() * 1.2)
  --     PLUGIN.Buttons["UpgradePassive"].price = entity:GetUpgradeCostPassive()
  --     entity:SetNetVar("UpgradePassive", PLUGIN.Buttons["UpgradePassive"].price)
  --   end,
	-- },
  -- ["BuyShipment"] = {
	-- 	name = "Заказать поставку",
	-- 	price = 750,
  --   derma = true,
  --   callback = function(client, entity, opts)
  --     PLUGIN:SpawnShipment(client, entity, opts)
  --   end,
	-- },

  ["OpenInv"] = {
		name = "Открыть хранилище",
		price = 0,
    derma = false,
    callback = function(client, entity, opts)
      local factionTable = ix.faction.Get(client:Team())
      local rankTable = factionTable.Ranks
  
      if not rankTable[client:GetCharacter():GetRank()][4] then
          return client:NotifyLocalized("cannotAllow")
      end
      
      entity:GetBank(client, function(bank)
        ix.storage.Open(client, bank, {
            entity = entity,
            name = "Хранилище",
            searchText = "Открываю хранилище...",
            searchTime = 1
        })
      end)
    end,
	},

  ["OpenShop"] = {
		name = "Открыть магазин",
		price = 0,
    derma = false,
    callback = function(client, entity, opts)
        netstream.Start(client, "fractionsystem::SHOPVGUI_open", entity)
    end,
	},
  --WIP, так как нужно еще сделать энтити для доставки откуда будет появлятся сам энтити.
  -- ["BuyShipmentDelivery"] = {
	-- 	name = "Заказать доставку поставки",
	-- 	price = 1500,
  -- derma = true,
  -- callback = function(client, entity, opts)
  --   PLUGIN:SpawnShipment(client, entity, opts)
  -- end,
	-- },
}

PLUGIN.RelationshipOpts = {
  ["Объявить войну"] = function(client, entity, fraction)
    entity:EmitSound("ambient/machines/thumper_hit.wav")
    entity:SetNetVar(ix.faction.indices[fraction].name, "WAR")
    for k,v in pairs(ents.FindByClass("ix_factiontable")) do
        if v:GetFraction() == ix.faction.indices[fraction].index then
            v:SetNetVar(ix.faction.indices[entity:GetFraction()].name, "WAR")
        end
    end
  end,
  ["Объявить союз"] = function(client, entity, fraction)
    entity:EmitSound("buttons/blip1.wav")
    entity:SetNetVar(ix.faction.indices[fraction].name, "ALLIANCE")
    for k,v in pairs(ents.FindByClass("ix_factiontable")) do
      if v:GetFraction() == ix.faction.indices[fraction].index then
          v:SetNetVar(ix.faction.indices[entity:GetFraction()].name, "ALLIANCE")
      end
  end
  end,
  ["Объявить нейтральные отношения"] = function(client, entity, fraction)
    entity:EmitSound("buttons/combine_button7.wav")
    entity:SetNetVar(ix.faction.indices[fraction].name, "NEUTRAL")
    for k,v in pairs(ents.FindByClass("ix_factiontable")) do
      if v:GetFraction() == ix.faction.indices[fraction].index then
          v:SetNetVar(ix.faction.indices[entity:GetFraction()].name, "NEUTRAL")
      end
  end
  end,
}

if CLIENT then
  netstream.Hook("fractionsystem::OpenUI", function(entity)
    if (!IsValid(entity)) then
      return
    end

    local fractionui = vgui.Create("CMBMTK.fractionsystem")
    fractionui:Setup(entity)
  end)
end

--------------------ix_factiontable--------------------
properties.Add( "factiondesk_Set_Fraction", {
  MenuLabel = "Edit Fraction",
  Order = 0,
  MenuIcon = "icon16/pencil.png",
  Filter = function( self, entity, client )
    if entity:GetClass() != "ix_factiontable" then return end
    if !gamemode.Call( "CanProperty", client, "factiondesk_Set_Fraction", entity ) then return end
    if !client:IsSuperAdmin() then return end

    return true;
  end,
  MenuOpen = function( self, option, entity, tr )
    local submenu = option:AddSubMenu()
    local factions = ix.faction.indices
      for i = 1, #factions do
        local option = submenu:AddOption(factions[i].name, function() self:SetFract(entity, i) end)
      end
  end,

  SetFract = function( self, ent, id )
		self:MsgStart()
			net.WriteEntity( ent )
			net.WriteUInt( id, 8 )
		self:MsgEnd()
	end,

  Action = function( self, entity )
  end,

  Receive = function( self, length, client )
    local entity = net.ReadEntity()
    local FractionID = net.ReadUInt(8)
    if( !IsValid( entity ) ) then return end
    if( !self:Filter( entity, client ) ) then return end

    entity:SetFraction(FractionID)
  end
})

properties.Add( "factiondesk_Set_CurrStorage", {
  MenuLabel = "Edit Current Storage Points",
  Order = 1,
  MenuIcon = "icon16/pencil.png",
  Filter = function( self, entity, client )
    if entity:GetClass() != "ix_factiontable" then return end
    if !gamemode.Call( "CanProperty", client, "factiondesk_Set_CurrStorage", entity ) then return end
    if !client:IsSuperAdmin() then return end

    return true;
  end,

  Action = function( self, entity )
		Derma_StringRequest( "Сменить количество очков в складе", "", "", function( num )
			self:MsgStart();
				net.WriteEntity( entity );
				net.WriteUInt( num, 31 );
			self:MsgEnd();
		end )
	end,

  Receive = function( self, length, client )
    local entity = net.ReadEntity()
    local CurrStorageNum = net.ReadUInt(31)
    if( !IsValid( entity ) ) then return end
    if( !self:Filter( entity, client ) ) then return end

    entity:SetCurrStorage(math.min(CurrStorageNum, entity:GetMaxStorage()))
  end
})


properties.Add( "factiondesk_Set_MaxStorage", {
  MenuLabel = "Edit Maximum Storage Points",
  Order = 1,
  MenuIcon = "icon16/pencil.png",
  Filter = function( self, entity, client )
    if entity:GetClass() != "ix_factiontable" then return end
    if !gamemode.Call( "CanProperty", client, "factiondesk_Set_MaxStorage", entity ) then return end
    if !client:IsSuperAdmin() then return end

    return true;
  end,

  Action = function( self, entity )
		Derma_StringRequest( "Сменить максимальное количество очков в складе", "", "", function( num )
			self:MsgStart();
				net.WriteEntity( entity );
				net.WriteUInt( num, 31 );
			self:MsgEnd();
		end )
	end,

  Receive = function( self, length, client )
    local entity = net.ReadEntity()
    local MaxStorageNum = net.ReadUInt(31)
    if( !IsValid( entity ) ) then return end
    if( !self:Filter( entity, client ) ) then return end

    entity:SetMaxStorage(MaxStorageNum)
  end
})

--------------------ix_capturepoint--------------------

properties.Add( "capturepoint_Set_CaptureIncome", {
  MenuLabel = "Edit Capture Income",
  Order = 1,
  MenuIcon = "icon16/pencil.png",
  Filter = function( self, entity, client )
    if entity:GetClass() != "ix_capturepoint" then return end
    if !gamemode.Call( "CanProperty", client, "capturepoint_Set_CaptureIncome", entity ) then return end
    if !client:IsSuperAdmin() then return end

    return true;
  end,

  Action = function( self, entity )
		Derma_StringRequest( "Сменить доход от точки", "", "", function( num )
			self:MsgStart();
				net.WriteEntity( entity );
				net.WriteUInt( num, 31 );
			self:MsgEnd();
		end )
	end,

  Receive = function( self, length, client )
    local entity = net.ReadEntity()
    local IncomeNum = net.ReadUInt(31)
    if( !IsValid( entity ) ) then return end
    if( !self:Filter( entity, client ) ) then return end

    entity:SetCaptureIncome(IncomeNum)
  end
})

properties.Add( "capturepoint_Set_CaptureTime", {
  MenuLabel = "Edit Capture Time",
  Order = 1,
  MenuIcon = "icon16/pencil.png",
  Filter = function( self, entity, client )
    if entity:GetClass() != "ix_capturepoint" then return end
    if !gamemode.Call( "CanProperty", client, "capturepoint_Set_CaptureTime", entity ) then return end
    if !client:IsSuperAdmin() then return end

    return true;
  end,

  Action = function( self, entity )
		Derma_StringRequest( "Сменить время захвата точки", "", "", function( num )
			self:MsgStart();
				net.WriteEntity( entity );
				net.WriteUInt( num, 31 );
			self:MsgEnd();
		end )
	end,

  Receive = function( self, length, client )
    local entity = net.ReadEntity()
    local CaptureNum = net.ReadUInt(31)
    if( !IsValid( entity ) ) then return end
    if( !self:Filter( entity, client ) ) then return end

    entity:SetCaptureTime(CaptureNum)
  end
})


properties.Add( "capturepoint_Set_Fraction", {
  MenuLabel = "Edit Fraction",
  Order = 0,
  MenuIcon = "icon16/pencil.png",
  Filter = function( self, entity, client )
    if entity:GetClass() != "ix_capturepoint" then return end
    if !gamemode.Call( "CanProperty", client, "capturepoint_Set_Fraction", entity ) then return end
    if !client:IsSuperAdmin() then return end

    return true;
  end,
  MenuOpen = function( self, option, entity, tr )
    local submenu = option:AddSubMenu()
    local factions = ix.faction.indices
      for i = 1, #factions do
        local option = submenu:AddOption(factions[i].name, function() self:SetFract(entity, i) end)
      end
  end,

  SetFract = function( self, ent, id )
		self:MsgStart()
			net.WriteEntity( ent )
			net.WriteUInt( id, 8 )
		self:MsgEnd()
	end,

  Action = function( self, entity )
  end,
  
  Receive = function( self, length, client )
    local entity = net.ReadEntity()
    local FractionID = net.ReadUInt(8)
    if( !IsValid( entity ) ) then return end
    if( !self:Filter( entity, client ) ) then return end

    entity:SetCaptureFraction(tostring(FractionID))
  end
})
