--[[
    uwu
]]
local Games = {
    [12398414727] = {
        ["URL"] = "https://raw.githubusercontent.com/SwiftSystems/Swift/main/Games/12398414727.lua"
    }
}

local Game = Games[1]
if Game then
    loadstring(game:HttpGet(Game.URL))()
else
    warn("Game not supported!")
    -- / universal coming soon (tm)
end