local PLUGIN = PLUGIN

function PLUGIN:OnReloaded()
	for _, v in pairs(ix.item.instances) do
		ix.item.FixFlip(v)
	end
end
