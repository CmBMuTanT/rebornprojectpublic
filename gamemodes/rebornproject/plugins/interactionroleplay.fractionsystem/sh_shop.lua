local PLUGIN = PLUGIN


PLUGIN.ShopItems = {
    ["oxygen1"] = 1000,
    ["oxygen2"] = 1000,
    ["oxygen3"] = 1000,
    ["sirentwo"] = 1700,
    ["paracetamol"] = 400,
    ["novox"] = 400,
    ["aztreonam"] = 400,
    ["healthkit"] = 700,
    ["healthkit_army"] = 1300,
    ["ammo_545x39"] = 300,
    ["ammo_pistol"] = 300,
    ["ammo_1270"] = 300,
    ["ammo_15mm"] = 300,
    ["gasmaskfilter"] = 600,
    ["tableware_waterrcan"] = 1200,
    ["rawmeat_watcherhvost"] = 300,
    ["rawmeat_arahnidscorplegs"] = 300,
    ["helmet_shlem_29"] = 1900,
    ["balaclavas_1"] = 1000,
    ["balaclavas_1o1"] = 1000,
    ["balaclavas_2"] = 1000,
    ["balaclavas_3o1"] = 1000,
    ["meksamin"] = 760,
}

local nextrefresh = 0
function PLUGIN:Think() -- auto-refresh sell items

  if CurTime() > nextrefresh then
    PLUGIN.TempItemsToTrade2 = {}

    local itemsToAdd = {}
    
    for item, count in pairs(PLUGIN.ShopItems) do
      table.insert(itemsToAdd, {item = item, count = count})
    end
    
    for i = 1, math.random(20) do
      if #itemsToAdd > 0 then
      local randomIndex = math.random(1, #itemsToAdd)
      table.insert(PLUGIN.TempItemsToTrade2, itemsToAdd[randomIndex])
      table.remove(itemsToAdd, randomIndex)
      end
    end

    nextrefresh = CurTime() + 14400 -- в секундах (4 часа на данный момент)
  end
end

if CLIENT then
    netstream.Hook("fractionsystem::SHOPVGUI_open", function(entity) -- да так просто, ебал я рот делать еще одну дерму.
        local MainPanel = vgui.Create("DFrame")
        MainPanel:SetSize(ScrW() * .5, ScrH() * .5)
        MainPanel:Center()
        MainPanel:SetTitle("На данный момент вам могут предложить:")
        MainPanel:MakePopup()

        local Scroll = vgui.Create( "DScrollPanel", MainPanel )
        Scroll:Dock( FILL )

        local itemlayout = vgui.Create("DIconLayout", Scroll)
        itemlayout:Dock(FILL)
        itemlayout:SetSpaceX(5)
        itemlayout:SetSpaceY(5)

        for index, itemdata in pairs(PLUGIN.TempItemsToTrade2) do
            local item = ix.item.Get(itemdata.item)
            local price = itemdata.count
        
            local ItemPanel = vgui.Create("DPanel", itemlayout)
            ItemPanel:SetSize(itemlayout:GetWide() * 2.9, itemlayout:GetTall() * 5)
        
            local ItemModelPanel = vgui.Create("DModelPanel", ItemPanel)
            ItemModelPanel:SetSize(ItemPanel:GetWide(), ItemPanel:GetTall() * 0.8)
            ItemModelPanel:SetModel(item.model)
        
            local min, max = ItemModelPanel.Entity:GetModelBounds()
            local center = (min + max) / 2
            ItemModelPanel:SetCamPos(center - Vector(-50, -50, -50))
            ItemModelPanel:SetLookAt(center)
        
            local TextPanel = vgui.Create("DPanel", ItemPanel)
            TextPanel:SetSize(ItemPanel:GetWide(), ItemPanel:GetTall() * 0.25)
            TextPanel:Dock(BOTTOM)
        
            TextPanel.Paint = function(this, w, h)
                draw.SimpleText(item.name, "DermaDefault", w / 2, h / 2 - 10, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                draw.SimpleText("Цена: " .. price, "DermaDefault", w / 2, h / 2 + 10, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end

            ItemModelPanel.DoClick = function(this)
                netstream.Start("fractionsystem::SHOPVGUI_buy", entity:EntIndex(), itemdata)
            end
        end        
    end)
end