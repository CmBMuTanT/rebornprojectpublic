ispawn_funcs = {
    INSERT = function(self,mdl,invw,inwh,viewname)
        self[#self + 1] = {
            model = mdl,
            inv_w = invw, 
            inv_h = invh, 
            title = viewname,
        }
    end,

    INSERT_ITEM = function(self,value)
        table.insert(ITEM_SPAWN.ITEM_LIST, value)
    end
}
ispawn_funcs.__index = ispawn_funcs

ITEM_SPAWN = {}
ITEM_SPAWN.VIEWS = {}

ITEM_SPAWN.ITEM_LIST = {}

setmetatable(ITEM_SPAWN.VIEWS, ispawn_funcs)
setmetatable(ITEM_SPAWN.ITEM_LIST, ispawn_funcs)