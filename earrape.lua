-- simple earrape
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function isInDriverSeat()
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildWhichIsA("Humanoid")
        if humanoid and humanoid.SeatPart and humanoid.SeatPart:IsA("VehicleSeat") then
            return humanoid.SeatPart.Occupant == humanoid
        end
    end
    return false
end

local function spamLoudDrift()
    task.spawn(function()
        while isInDriverSeat() do
            local vehicle = LocalPlayer.Character.Humanoid.SeatPart:FindFirstAncestorOfClass("Model")
            if vehicle and vehicle:FindFirstChild("Input_Events") and vehicle.Input_Events:FindFirstChild("Drift") then
                -- Fire Drift event
                vehicle.Input_Events.Drift:FireServer(9999999999, 9999999999)

                -- Maximize wheel sounds
                local wheels = vehicle:FindFirstChild("Wheels")
                if wheels then
                    for _, side in ipairs({"RL", "RR"}) do
                        local wheel = wheels:FindFirstChild(side)
                        if wheel then
                            local sq = wheel:FindFirstChild("SQ")
                            if sq and sq:IsA("Sound") then
                                sq.Volume = 9999999999
                                local sv = sq:FindFirstChild("ServerVolume")
                                if sv and sv:IsA("NumberValue") then
                                    sv.Value = 9999999999
                                end
                            end
                        end
                    end
                end
            end
            task.wait(0)
        end
    end)
end

if isInDriverSeat() then
    spamLoudDrift()
else
    warn("You must be in the driver seat of a vehicle for Earrape to work.")
end
