local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- settings
local flightEnabled = true   -- dont know why u would need to turn it of if u executing ig if u wanna make a ui for it or sum
local flightSpeed = 10       -- same shit 

-- faggot helpers
local function GetVehicleFromDescendant(part)
    while part and part.Parent do
        if part.Parent:FindFirstChild("Control_Values") then
            return part.Parent
        end
        part = part.Parent
    end
end

RunService.Stepped:Connect(function(_, dt)
    local character = LocalPlayer.Character
    if not character then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local seatPart = humanoid.SeatPart
    if not seatPart or not seatPart:IsA("VehicleSeat") then return end

    local vehicle = GetVehicleFromDescendant(seatPart)
    if not vehicle or not vehicle:IsA("Model") then return end
    if not vehicle.PrimaryPart then vehicle.PrimaryPart = seatPart end

    if flightEnabled then
        local moveInput = Vector3.new(
            (UserInputService:IsKeyDown(Enum.KeyCode.D) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.A) and 1 or 0),
            (UserInputService:IsKeyDown(Enum.KeyCode.E) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.Q) and 1 or 0),
            (UserInputService:IsKeyDown(Enum.KeyCode.S) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.W) and 1 or 0)
        )

        if moveInput.Magnitude > 0 then
            moveInput = moveInput.Unit * flightSpeed
        else
            moveInput = Vector3.zero
        end

        local baseCFrame = vehicle.PrimaryPart.CFrame
        local camCFrame = Workspace.CurrentCamera.CFrame

        local moveVector = 
            (camCFrame.RightVector * moveInput.X) +
            (Vector3.new(0,1,0) * moveInput.Y) +
            (camCFrame.LookVector * -moveInput.Z)

        local newPosition = baseCFrame.Position + moveVector
        local flatLook = Vector3.new(baseCFrame.LookVector.X, 0, baseCFrame.LookVector.Z).Unit
        vehicle:SetPrimaryPartCFrame(CFrame.new(newPosition, newPosition + flatLook))

        seatPart.AssemblyLinearVelocity = Vector3.zero
        seatPart.AssemblyAngularVelocity = Vector3.zero
    end
end)
