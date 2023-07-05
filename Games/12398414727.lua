--[[
    This script was made for fun, I certainly can make it much better.
    If you want to use some of this code for your own script, please consider crediting me.
]]

repeat wait() until game:IsLoaded()

-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- / Event Variables
local EventsPath = ReplicatedStorage:WaitForChild("Events")
local FunctionsPath = ReplicatedStorage:WaitForChild("Functions")
local Events = {
    ["Round"] = EventsPath.Round.RoundRE,
    ["Answer"] = FunctionsPath.Answer.AnswerRF
}

-- // Utility Functions
local function GetOperator(Operator)
    if Operator == "×" then
        return "*"
    elseif Operator == "÷" then
        return "/"
    end
    return Operator
end

-- // Getting the UI library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SwiftSystems/Swift/main/Library.lua"))()

-- // Creating the window
local Window = Library:Create({
	Name = "Swift Systems - MAoD", 
	Footer = "Alpha version - SwiftSystems.org", 
	ToggleKey = Enum.KeyCode.V,
	LoadedCallback = function() return end,
	KeySystem = false,
	Key = "Swift", 
	MaxAttempts = 5,
	DiscordLink = "https://discord.gg/5hdGFFuPGe",
})

-- // Creating the tabs
local Main = Window:Tab({Name = "Main"})
local Settings = Window:Tab({Name = "Settings", Icon = "rbxassetid://11476626403"})

-- // Main
-- / Auto Answer Section
local AutoAnswerSec = Main:Section({Name = "Auto Answer"})
local AutoAnswerTog = {Bool = false}; AutoAnswerTog = AutoAnswerSec:Toggle({Name = "Enabled", Default = false, Callback = function(v) return end})

-- / Delay Section
local DelaySec = Main:Section({Name = "Delay"})
local DelayTog = {Bool = false}; DelayTog = DelaySec:Toggle({Name = "Use Delay", Default = false, Callback = function(v) return end})
local DelaySlider = {OldVal = 0}; DelaySlider = DelaySec:Slider({Name = "Delay (ms)", Min = 0, Max = 5000, Default = 0, Callback = function(v) return end})
local RandDelaySlider = {OldVal = 0}; RandDelaySlider = DelaySec:Slider({Name = "Random Delay (ms)", Min = 0, Max = 1000, Default = 0, Callback = function(v) return end})

-- // Settings
-- / Toggle Key Section
local ToggleKeySec = Settings:Section({Name = "GUI Key"})
local ToggleKeybind = {Keybind = Enum.KeyCode.V}; ToggleKeybind = ToggleKeySec:Keybind({Name = "Keybind", Default = Enum.KeyCode.V, UpdateKeyCallback = function(v) Window:ChangeTogglekey(v) end})

-- / Credits Section
local CreditsSec = Settings:Section({Name = "Credits"})
CreditsSec:Label({Name = "This is my first public script, which I made quickly for fun. If you want to keep up with my better made scripts, consider joining the Discord server."})
CreditsSec:Button({Name = "Join Discord", Callback = function()
    setclipboard("https://discord.gg/5hdGFFuPGe")
    Library:Notify({Name = "Copied to clipboard", Text = "Copied invite (discord.gg/5hdGFFuPGe) to clipboard."})
end})

-- // OnClient events
Events.Round.OnClientEvent:Connect(function(EventType, Timeleft, CurrentQuestion)
    if EventType ~= "countdown" or not AutoAnswerTog.Bool then return end
    local Equation = string.split(CurrentQuestion.CurrentQuestion, " ")
    local Operator = GetOperator(Equation[2])

    local Answer = "return "..Equation[1]..Operator..Equation[3]
    if DelayTog.Bool then
        if math.random(1,2) == 1 then
            task.wait(DelaySlider.OldVal/1000 + math.random(0, RandDelaySlider.OldVal)/1000)
        else
            task.wait(DelaySlider.OldVal/1000 - math.random(0, RandDelaySlider.OldVal)/1000)
        end
    end
    return Events.Answer:InvokeServer("answer", loadstring(Answer)())
end)