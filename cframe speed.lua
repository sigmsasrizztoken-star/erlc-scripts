local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Speed = 100 -- how fast yo speed wants to be 

RunService.Heartbeat:Connect(function(delta)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")

    if hrp and hum and hum.MoveDirection.Magnitude > 0 then
        hrp.CFrame = hrp.CFrame + hum.MoveDirection * Speed * delta
    end
end)
