local PLUGIN = PLUGIN

util.AddNetworkString( "Jump" )
net.Receive("Jump",function(len,client)
    client:SetLocalVar("stm", math.Clamp(client:GetLocalVar("stm",0) - 10, -10, 100))
end)