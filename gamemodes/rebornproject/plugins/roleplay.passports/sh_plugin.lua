local PLUGIN = PLUGIN

PLUGIN.name = "Паспорта"
PLUGIN.author = "БО, джеймс Б.О!"
PLUGIN.description = "У него там тарелка в кустах под Выборгом"

--[[
  Тут нихуя нет, ибо это айтемы. И все.
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


if CLIENT then
	function PLUGIN:PopulateItemTooltip( tooltip, item )
		if item:GetData("PassportInfo", nil)  then
			local text = "Данные: "

      local info = item:GetData("PassportInfo", {})
      local already = {}

      if not table.IsEmpty( info ) then
        for k, v in next, info do
          already[ v ] = true
          text = text .. "\n -"..k..": "..v
        end
      end

			local row = tooltip:AddRowAfter( "description", "infoList" )
			row:SetText( text )
			row:SetBackgroundColor( derma.GetColor( "Info", tooltip ) )
			row:SizeToContents()
		end
	end


  netstream.Hook("cmbmtk.ShowMePassport", function(data, client, stamps)
    local me = LocalPlayer()
    if me ~= client then
      me:Notify("Вам предоставили паспорт, дабы его просмотреть нажмите F4")
    else
      local passport = vgui.Create("cmbmtk.passportplayer")
      passport:GetInfoPassport(data, stamps)
    end
  end)

  function PLUGIN:PlayerButtonDown(client, button)
    if button == KEY_F4 and client:GetNetVar("PassportRequest") then
      local passport = vgui.Create("cmbmtk.passportplayer")
      passport:GetInfoPassport(client:GetNetVar("PassportRequest"), client:GetNetVar("PassportRequest2"))
      netstream.Start("cmbmtk.PassportRequest")
    end
  end
end


properties.Add( "passport_Set_RegStr", {
  MenuLabel = "Edit Current RegStr category",
  Order = 1,
  MenuIcon = "icon16/pencil.png",
  Filter = function( self, entity, client )
    if entity:GetClass() != "cmbmtk_passportnpc" then return end
    if !gamemode.Call( "CanProperty", client, "passport_Set_RegStr", entity ) then return end
    if !client:IsSuperAdmin() then return end

    return true;
  end,

  Action = function( self, entity )
		Derma_StringRequest( "Сменить название станции", "", "", function( txt )
			self:MsgStart();
				net.WriteEntity( entity );
        net.WriteString(txt)
			self:MsgEnd();
		end )
	end,

  Receive = function( self, length, client )
    local entity = net.ReadEntity()
    local newRegStr = net.ReadString()
    if( !IsValid( entity ) ) then return end
    if( !self:Filter( entity, client ) ) then return end

    entity:SetRegistrationString(newRegStr)
  end
})

properties.Add( "passport_Set_RegImg", {
  MenuLabel = "Edit Current Reg Image",
  Order = 2,
  MenuIcon = "icon16/pencil.png",
  Filter = function( self, entity, client )
    if entity:GetClass() != "cmbmtk_passportnpc" then return end
    if !gamemode.Call( "CanProperty", client, "passport_Set_RegImg", entity ) then return end
    if !client:IsSuperAdmin() then return end

    return true;
  end,

  Action = function( self, entity )
		Derma_StringRequest( "Сменить материал станции", "", "", function( txt )
			self:MsgStart();
				net.WriteEntity( entity );
        net.WriteString(txt)
			self:MsgEnd();
		end )
	end,

  Receive = function( self, length, client )
    local entity = net.ReadEntity()
    local newRegImg = net.ReadString()
    if( !IsValid( entity ) ) then return end
    if( !self:Filter( entity, client ) ) then return end

    entity:SetRegistrationImage(newRegImg)
  end
})