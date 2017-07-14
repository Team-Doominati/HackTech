local ht = {}

-- Modules
ht.data =   require "HackTech/Data"
ht.player = require "HackTech/Player"
ht.deck =   require "HackTech/Deck"
ht.system = require "HackTech/System"

-- Classes
require "HackTech/Mission"
require "HackTech/Node"
require "HackTech/File"
require "HackTech/Software"
require "HackTech/ICE"

-- Globals
ht.day = 1
ht.missions = {}

return ht
