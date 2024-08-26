local PLUGIN = PLUGIN

PLUGIN.name = "Мегафон с агитациями"
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

PLUGIN.MGsounds = {
  ["1"] = {
    "hanza/1.wav",
    "hanza/2.wav",
    "hanza/3.wav",
    "hanza/4.wav",
  },

  ["2"] = {
    "reich/1.wav",
    "reich/2.wav",
    "reich/3.wav",
    "reich/4.wav",
    "reich/5.wav",
    "reich/6.wav",    
  },

  ["3"] = {
    "polis/1.wav",
    "polis/2.wav",
    "polis/3.wav",
  },

  ["4"] = {
    "redline/1.wav",
    "redline/2.wav",
    "redline/3.wav",
    "redline/4.wav",
    "redline/5.wav",
    "redline/6.wav",
  }
}


properties.Add( "megaphone_Set_MGcategory", {
  MenuLabel = "Edit Current Megaphone category",
  Order = 1,
  MenuIcon = "icon16/pencil.png",
  Filter = function( self, entity, client )
    if entity:GetClass() != "cmbmtk_megaphone" then return end
    if !gamemode.Call( "CanProperty", client, "megaphone_Set_MGcategory", entity ) then return end
    if !client:IsSuperAdmin() then return end

    return true;
  end,

  Action = function( self, entity )
		Derma_StringRequest( "Сменить категорию у мегафона (числа)", "", "", function( num )
			self:MsgStart();
				net.WriteEntity( entity );
				net.WriteUInt( num, 31 );
			self:MsgEnd();
		end )
	end,

  Receive = function( self, length, client )
    local entity = net.ReadEntity()
    local newMGCategory = net.ReadUInt(31)
    if( !IsValid( entity ) ) then return end
    if( !self:Filter( entity, client ) ) then return end

    entity:SetSoundCategory(newMGCategory)
  end
})