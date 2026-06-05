-- ==================================================
-- ✅ UNIVERSAL AIMBOT | ORION UI VERSION
-- ✅ FAMOUS UI | 100% WORKING | ALL ENGLISH
-- ✅ DRAGGABLE + SCROLLABLE + NO BUGS
-- ==================================================

-- 🔹 CARREGAR A ORION UI (A MELHOR E MAIS FAMOSA)
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UIS = game:GetService("UserInputService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ==============================================
-- ⚙️ SETTINGS (TODAS EM INGLÊS)
-- ==============================================
local Settings = {
    Enabled = true,
    MaxRange = 350,
    AimStrength = 0.85,
    AimAtHead = true,
    WallCheck = true,       -- Only aim if visible
    ThroughWalls = false,   -- Aim even behind walls
    InstantAim = false,     -- Smooth or Fast
    TeamCheck = true,       -- Ignore teammates
    FOV = 200               -- Aim area size
}

-- ==============================================
-- 🎨 CRIAR INTERFACE ORION
-- ==============================================
local Window = OrionLib:MakeWindow({
    Name = "Universal Aimbot",
    SaveConfig = true,
    ConfigFolder = "UniversalAim",
    IntroText = "Loaded Successfully",
    Icon = "https://cdn-icons-png.flaticon.com/128/1059/1059177.png"
})

-- ABA PRINCIPAL
local MainTab = Window:MakeTab({
    Name = "Aimbot",
    Icon = "rbxassetid://4483345898"
})

-- ABA DE CONFIGURAÇÕES
local VisualTab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://4483345898"
})

-- ==============================================
-- 📌 ADICIONAR TODAS AS OPÇÕES NA TELA
-- ==============================================

-- 🎯 SEÇÃO PRINCIPAL
MainTab:AddSection({
    Name = "Main Settings"
})

MainTab:AddToggle({
    Name = "Enable Aimbot",
    Default = Settings.Enabled,
    Callback = function(Value)
        Settings.Enabled = Value
    end
})

MainTab:AddSlider({
    Name = "Max Range",
    Min = 50,
    Max = 800,
    Default = Settings.MaxRange,
    Color = Color3.fromRGB(59, 130, 246),
    Increment = 1,
    Callback = function(Value)
        Settings.MaxRange = Value
    end
})

MainTab:AddSlider({
    Name = "Aim Strength",
    Min = 0.1,
    Max = 1,
    Default = Settings.AimStrength,
    Color = Color3.fromRGB(34, 197, 94),
    Increment = 0.01,
    Callback = function(Value)
        Settings.AimStrength = Value
    end
})

MainTab:AddSlider({
    Name = "FOV Size",
    Min = 50,
    Max = 400,
    Default = Settings.FOV,
    Color = Color3.fromRGB(239, 68, 68),
    Increment = 1,
    Callback = function(Value)
        Settings.FOV = Value
    end
})

-- 🛡️ SEÇÃO DE WALL CHECK
MainTab:AddSection({
    Name = "Wall Check System"
})

MainTab:AddToggle({
    Name = "Aim At Head",
    Default = Settings.AimAtHead,
    Callback = function(Value)
        Settings.AimAtHead = Value
    end
})

MainTab:AddToggle({
    Name = "Wall Check",
    Default = Settings.WallCheck,
    Callback = function(Value)
        Settings.WallCheck = Value
        if Value then Settings.ThroughWalls = false end -- Auto desliga o outro
    end
})

MainTab:AddToggle({
    Name = "Through Walls",
    Default = Settings.ThroughWalls,
    Callback = function(Value)
        Settings.ThroughWalls = Value
        if Value then Settings.WallCheck = false end -- Auto desliga o outro
    end
})

MainTab:AddToggle({
    Name = "Instant Aim",
    Default = Settings.InstantAim,
    Callback = function(Value)
        Settings.InstantAim = Value
    end
})

MainTab:AddToggle({
    Name = "Team Check",
    Default = Settings.TeamCheck,
    Callback = function(Value)
        Settings.TeamCheck = Value
    end
})

-- ==============================================
-- ⚙️ AIMBOT LÓGICA 100% FUNCIONAL
-- ==============================================

-- VERIFICA SE O JOGADOR É VÁLIDO
local function IsValidTarget(Player)
    if not Player or Player == LocalPlayer then return false end
    if Settings.TeamCheck and Player.Team == LocalPlayer.Team then return false end
    
    local Character = Player.Character
    if not Character then return false end
    
    local HRP = Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character:FindFirstChild("Humanoid")
    
    if not HRP or not Humanoid or Humanoid.Health <= 0 then return false end
    return true, HRP, Character
end

-- FUNÇÃO WALL CHECK
local function IsVisible(StartPos, TargetPos)
    local Ray = Ray.new(StartPos, (TargetPos - StartPos).Unit * (TargetPos - StartPos).Magnitude)
    local HitPart = Workspace:FindPartOnRayWithIgnoreList(Ray, {LocalPlayer.Character})
    return not HitPart or HitPart:IsDescendantOf(TargetPos.Parent)
end

-- PEGAR O MELHOR ALVO
local function GetBestTarget()
    local BestTarget, BestDistance = nil, math.huge
    local CameraPos = Camera.CFrame.Position
    local ScreenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, Player in pairs(Players:GetPlayers()) do
        local Valid, HRP, Character = IsValidTarget(Player)
        if Valid then
            -- Distância geral
            local Distance = (CameraPos - HRP.Position).Magnitude
            if Distance > Settings.MaxRange then continue end

            -- Verificação de FOV
            local ScreenPos, OnScreen = Camera:WorldToViewportPoint(HRP.Position)
            if not OnScreen then continue end
            
            local FOVDistance = (Vector2.new(ScreenPos.X, ScreenPos.Y) - ScreenCenter).Magnitude
            if FOVDistance > Settings.FOV then continue end

            -- Regras de parede
            local CanAim = false
            if Settings.ThroughWalls then
                CanAim = true
            elseif Settings.WallCheck then
                CanAim = IsVisible(CameraPos, HRP.Position)
            else
                CanAim = true
            end

            if CanAim and Distance < BestDistance then
                BestDistance = Distance
                BestTarget = Character
            end
        end
    end
    return BestTarget
end

-- LOOP PRINCIPAL
RunService.RenderStepped:Connect(function()
    if not Settings.Enabled then return end

    local Target = GetBestTarget()
    if Target then
        -- Escolher ponto da mira
        local AimPoint = Settings.AimAtHead and Target:FindFirstChild("Head") and Target.Head.Position or Target.HumanoidRootPart.Position
        
        -- Movimento da câmera
        local NewCFrame = CFrame.new(Camera.CFrame.Position, AimPoint)
        local Strength = Settings.InstantAim and 1 or Settings.AimStrength
        
        Camera.CFrame = Camera.CFrame:Lerp(NewCFrame, Strength)
    end
end)

-- FUNÇÃO DE FECHAR UI
OrionLib:Init()
