local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local plr = LocalPlayer

local function disableFallDamage()
    local char = plr.Character or plr.CharacterAdded:Wait()
    local handler = char:FindFirstChild("DamageHandler")

    if handler and handler:IsA("LocalScript") then
        handler.Disabled = true
    end
end

disableFallDamage()

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    disableFallDamage()
end)
