local Players = game:GetService("Players")
local Lr = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

G = {
    OmniGod = false
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OmniGodNDS"
ScreenGui.ResetOnSpawn = false

local function SafeProtect(gui)
    if gethui then
        gui.Parent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(gui)
        gui.Parent = Lr:FindFirstChildOfClass("PlayerGui")
    else
        gui.Parent = Lr:FindFirstChildOfClass("PlayerGui")
    end
end
SafeProtect(ScreenGui)

local function MakeDraggable(targetFrame, handleInputObject)
    local dragging, dragInput, dragStart, startPos
    local inputElement = handleInputObject or targetFrame

    inputElement.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = targetFrame.Position
        end
    end)

    inputElement.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            targetFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
            dragging = false 
        end
    end)
end

local JesusPlatform = Instance.new("Part", workspace)
JesusPlatform.Size = Vector3.new(30, 1, 30)
JesusPlatform.Transparency = 1
JesusPlatform.Anchored = true
JesusPlatform.CanCollide = false
JesusPlatform.Name = "OmniPlatform"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 150)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(150, 0, 255)
Stroke.Thickness = 2
MakeDraggable(MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, -50, 0, 40)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "OMNIMAN | OMNIGOD V26"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
CloseBtn.TextColor3 = Color3.fromRGB(150, 0, 255)
CloseBtn.TextSize = 16
Instance.new("UICorner", CloseBtn)

local OpenBtn = Instance.new("Frame", ScreenGui)
OpenBtn.Size = UDim2.new(0, 140, 0, 30)
OpenBtn.Position = UDim2.new(0.5, -70, 0.05, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
OpenBtn.Visible = false
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 6)
local OpStroke = Instance.new("UIStroke", OpenBtn)
OpStroke.Color = Color3.fromRGB(150, 0, 255)
OpStroke.Thickness = 2

local OpenTxt = Instance.new("TextButton", OpenBtn)
OpenTxt.Size = UDim2.new(1, 0, 1, 0)
OpenTxt.BackgroundTransparency = 1
OpenTxt.Text = "OMNIMAN"
OpenTxt.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenTxt.Font = Enum.Font.GothamBold
OpenTxt.TextSize = 14

MakeDraggable(OpenBtn, OpenTxt)

local lastDragTime = 0
OpenTxt.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        lastDragTime = tick()
    end
end)

OpenTxt.MouseButton1Click:Connect(function()
    if tick() - lastDragTime < 0.2 then
        MainFrame.Visible = true
        OpenBtn.Visible = false
    end
end)

CloseBtn.MouseButton1Click:Connect(function() 
    MainFrame.Visible = false 
    OpenBtn.Visible = true 
end)

local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(1, -20, 1, -60)
Scroll.Position = UDim2.new(0, 10, 0, 50)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 1, 0)
Scroll.ScrollBarThickness = 0
local List = Instance.new("UIListLayout", Scroll)
List.Padding = UDim.new(0, 6)

local function AddToggle(name, state, cb)
    local t = Instance.new("TextButton", Scroll)
    t.Size = UDim2.new(1, 0, 0, 45)
    t.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    t.Text = "  " .. name .. ": " .. (state and "ON" or "OFF")
    t.TextColor3 = state and Color3.fromRGB(150, 0, 255) or Color3.fromRGB(200, 200, 200)
    t.Font = Enum.Font.Gotham
    t.TextSize = 14
    t.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", t)
    t.MouseButton1Click:Connect(function()
        state = not state; cb(state)
        t.Text = "  " .. name .. ": " .. (state and "ON" or "OFF")
        t.TextColor3 = state and Color3.fromRGB(150, 0, 255) or Color3.fromRGB(200, 200, 200)
    end)
end

AddToggle("OMNIGOD 🛡️", false, function(v) 
    G.OmniGod = v 
    if v then
        task.spawn(function()
            local char = Lr.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local rootpart = hum and hum.RootPart or (char and char:FindFirstChild("HumanoidRootPart"))
            
            if rootpart and hum then
                local oldpos = rootpart.CFrame
                hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                rootpart.AssemblyLinearVelocity = Vector3.new(9e9, 9e9, 9e9)
                
                task.wait(0.5)
                
                rootpart.AssemblyLinearVelocity = Vector3.zero
                rootpart.AssemblyAngularVelocity = Vector3.zero
                rootpart.CFrame = oldpos
            end
        end)
    end
end)

RunService.Heartbeat:Connect(function()
    pcall(function()
        local char = Lr.Character
        local h = char and char:FindFirstChildOfClass("Humanoid")
        local r = char and char:FindFirstChild("HumanoidRootPart")

        if h and r and G.OmniGod then
            h.Health = 100
            h:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            h:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            if h:GetState() == Enum.HumanoidStateType.Dead then h:ChangeState(11) end

            r.RotVelocity = Vector3.zero

            local trash = {"Acid", "Burn", "Damage", "Health", "Kill", "Infect", "Virus", "Snow", "Frost", "Flame", "Fire", "Lava", "Magma"}
            for _, v in pairs(char:GetChildren()) do
                for _, name in pairs(trash) do
                    if v.Name:find(name) then v:Destroy() end
                end
            end

            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name ~= "Baseplate" and obj.Name ~= "OmniPlatform" and not obj:IsDescendantOf(char) then
                    if obj.Name:find("Snow") or obj.Name:find("Hail") or obj.Name:find("Acid") or obj.Name:find("Fire") or obj.Name:find("Flame") or obj.Name:find("Burn") or obj.Name:find("Lava") or obj.Name:find("Magma") or obj.Name:find("Meteor") or obj:FindFirstChildOfClass("Fire") then
                        if (obj.Position - r.Position).Magnitude < 30 then
                            obj.CanCollide = false
                        end
                    end
                end
            end

            local water = workspace:FindFirstChild("Water") or workspace:FindFirstChild("Sea") or workspace:FindFirstChild("Wave")
            local rcParams = RaycastParams.new()
            rcParams.FilterFolder = {char, JesusPlatform}
            rcParams.FilterType = Enum.RaycastFilterType.Exclude
            local rcResult = workspace:Raycast(r.Position, Vector3.new(0, -12, 0), rcParams)

            if (water and math.abs(r.Position.Y - water.Position.Y) < 6) or (not rcResult and r.Position.Y < 50) then
                local targetY = (water and water.Position.Y + 3) or 38
                JesusPlatform.CFrame = CFrame.new(r.Position.X, targetY, r.Position.Z)
                JesusPlatform.CanCollide = true
            else
                JesusPlatform.CanCollide = false
            end
        else
            JesusPlatform.CanCollide = false
        end
    end)
end)

local rawMetatable = getrawmetatable(game)
local oldIndex = rawMetatable.__index
setreadonly(rawMetatable, false)
rawMetatable.__index = newcclosure(function(self, key)
    if G.OmniGod and tostring(self) == "Humanoid" and key == "WalkSpeed" then
        return 16
    end
    return oldIndex(self, key)
end)
setreadonly(rawMetatable, true)
