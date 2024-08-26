
-- The shared init file. You'll want to fill out the info for your schema and include any other files that you need.

-- Schema info
Schema.name = "QANON | REBORN"
Schema.author = "Qanon project team"
Schema.description = "Standart base, with universal plugins."

ix.currency.model = "models/devcon/mrp/props/ak_magazine.mdl"
ix.currency.symbol = ""
ix.currency.singular = "Армейских Пуль"
ix.currency.plural = "Армейских Пуль"

-- Additional files that aren't auto-included should be included here. Note that ix.util.Include will take care of properly
-- using AddCSLuaFile, given that your files have the proper naming scheme.

-- You could technically put most of your schema code into a couple of files, but that makes your code a lot harder to manage -
-- especially once your project grows in size. The standard convention is to have your miscellaneous functions that don't belong
-- in a library reside in your cl/sh/sv_schema.lua files. Your gamemode hooks should reside in cl/sh/sv_hooks.lua. Logical
-- groupings of functions should be put into their own libraries in the libs/ folder. Everything in the libs/ folder is loaded
-- automatically.

ix.config.language = "russian"

ix.util.Include("cl_schema.lua")
ix.util.Include("sv_schema.lua")

ix.util.Include("cl_hooks.lua")
ix.util.Include("sh_hooks.lua")
ix.util.Include("sv_hooks.lua")

-- You'll need to manually include files in the meta/ folder, however.
ix.util.Include("meta/sh_character.lua")
ix.util.Include("meta/sh_player.lua")

ix.util.Include("libs/thirdparty/sh_netstream2.lua")
ix.util.Include("libs/sh_table.lua")




ix.anim.SetModelClass("models/omonup/rus/gasomon.mdl", 'player')
ix.anim.SetModelClass("models/omonup/rus/omon_a.mdl", 'player')
ix.anim.SetModelClass("models/omonup/rus/omon_c.mdl", 'player')
ix.anim.SetModelClass("models/omonup/rus/omon_d.mdl", 'player')
ix.anim.SetModelClass("models/omonup/rus/omon_e.mdl", 'player')
ix.anim.SetModelClass("models/omonup/rus/omon_f.mdl", 'player')
 
