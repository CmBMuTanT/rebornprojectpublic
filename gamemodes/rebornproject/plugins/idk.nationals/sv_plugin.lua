function PLUGIN:RandomChancheSelect(OPTS)
    local sum = 0
    for _, value in pairs( self.nationals ) do
        sum = sum + value.chance
    end

    local select = math.random() * sum

    for key, value in pairs( self.nationals ) do
        select = select - value.chance
        if select < 0 then 
            return value.name
        end
    end
end

function PLUGIN:CharacterLoaded(character)
    local client = character:GetPlayer()
    local rand = self:RandomChancheSelect()
    
    if !character:GetData("CharNational") then
        local faction = ix.faction.indices[character:GetFaction()]

        if faction.uniqueID == "reich" then
            client:SetNetVar("CharNational", self.nationals["RUSSIANS"].name)
            character:SetData("CharNational", client:GetNetVar("CharNational"))
        else
            client:SetNetVar("CharNational", rand)
            character:SetData("CharNational", client:GetNetVar("CharNational"))
        end
    end
    client:SetNetVar("CharNational", character:GetData("CharNational"))
end


--SPECIAL FOR NULL
--USAGE: Player(uID):SetNationalData("National")
--Player(uID):GetNational() -> prints in console.

local META = FindMetaTable("Player")

function META:SetNationalData(national)
    if !isstring(national) then print("Ты еблан? в STRING засунь национальность") return end
    self:GetCharacter():SetData("CharNational", national)
    self:SetNetVar("CharNational", national)
end

function META:GetNational()
    local a = self:GetCharacter():GetData("CharNational", national)
    local b = self:GetNetVar("CharNational", national)

    return print("GETDATA: "..a.."\nGETNETVAR: "..b)
end
