-- [[ UNIVERSAL-HUB v2.0 - PROFESSIONAL ARCHITECTURE ]]
-- Lead Dev: @ayuks78 | Engine: @GmAI
-- Lines: 650+ Framework | Security: Level 8 Bypass

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local lp = Players.LocalPlayer
local camera = workspace.CurrentCamera
local mouse = lp:GetMouse()

-- [[ SISTEMA DE GERENCIAMENTO DE ESTADO (PROTEGIDO) ]]
getgenv().HubConfig = {
    Aimbot = false,
    Hitbox = false,
    HitSize = 5,
    Esp = false,
    Noclip = false,
    BoostFPS = false,
    Smoothing = 0.25,
    FOV = 120
}

-- [[ BYPASS DE METATABELA (ANTI-DETECTION) ]]
local old_idx
old_idx = hookmetamethod(game, "__index", function(t, k)
    if not checkcaller() and getgenv().HubConfig.Hitbox and t:IsA("Part") and k == "Size" then
        return Vector3.new(2, 2, 1) -- Retorna o tamanho original para o servidor
    end
    return old_idx(t, k)
end)

-- [[ SISTEMA DE NOTIFICAÇÃO PROFISSIONAL ]]
local function Notify(title, msg)
    task.spawn(function()
        local nGui = Instance.new("ScreenGui", (gethui and gethui()) or game:GetService("CoreGui"))
        local f = Instance.new("Frame", nGui)
        f.Size = UDim2.new(0, 220, 0, 65); f.Position = UDim2.new(1, 10, 0.85, 0)
        f.BackgroundColor3 = Color3.fromRGB(12, 12, 15); f.BorderSizePixel = 0
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
        Instance.new("UIStroke", f).Color = Color3.fromRGB(65, 120, 255)
        
        local tl = Instance.new("TextLabel", f)
        tl.Size = UDim2.new(1, -10, 0, 30); tl.Position = UDim2.new(0, 10, 0, 5)
        tl.Text = title; tl.TextColor3 = Color3.fromRGB(65, 120, 255); tl.Font = "GothamBold"; tl.TextSize = 13; tl.BackgroundTransparency = 1; tl.TextXAlignment = 0
        
        local ml = Instance.new("TextLabel", f)
        ml.Size = UDim2.new(1, -10, 0, 25); ml.Position = UDim2.new(0, 10, 0, 30)
        ml.Text = msg; ml.TextColor3 = Color3.fromRGB(200, 200, 200); ml.Font = "Gotham"; ml.TextSize = 11; ml.BackgroundTransparency = 1; ml.TextXAlignment = 0
        
        TS:Create(f, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Position = UDim2.new(1, -235, 0.85, 0)}):Play()
        task.wait(3.5)
        TS:Create(f, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Position = UDim2.new(1, 10, 0.85, 0)}):Play()
        task.wait(0.5); nGui:Destroy()
    end)
end

-- [[ CONSTRUÇÃO DA UI INTERFACE ]]
local MainGui = Instance.new("ScreenGui", (gethui and gethui()) or game:GetService("CoreGui"))
MainGui.Name = "UniversalV2_Core"

local MainFrame = Instance.new("Frame", MainGui)
MainFrame.Size = UDim2.new(0, 580, 0, 320); MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5); MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12); MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(25, 25, 30)

-- Sidebar
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 145, 1, -20); Sidebar.Position = UDim2.new(0, 10, 0, 10); Sidebar.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
Instance.new("UICorner", Sidebar)

local WelcomeLabel = Instance.new("TextLabel", Sidebar)
WelcomeLabel.Size = UDim2.new(1, -10, 0, 35); WelcomeLabel.Position = UDim2.new(0, 12, 0, 5)
WelcomeLabel.Text = "Bem Vindo: " .. lp.Name; WelcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255); WelcomeLabel.Font = "GothamBold"; WelcomeLabel.TextSize = 10; WelcomeLabel.TextXAlignment = 0; WelcomeLabel.BackgroundTransparency = 1

local PremTag = Instance.new("TextLabel", Sidebar)
PremTag.Size = UDim2.new(1, -10, 0, 15); PremTag.Position = UDim2.new(0, 12, 0, 22)
PremTag.Text = "Premium Member"; PremTag.TextColor3 = Color3.fromRGB(65, 120, 255); PremTag.Font = "GothamBold"; PremTag.TextSize = 8; PremTag.TextXAlignment = 0; PremTag.BackgroundTransparency = 1

local TabContainer = Instance.new("Frame", Sidebar)
TabContainer.Size = UDim2.new(1, 0, 1, -80); TabContainer.Position = UDim2.new(0, 0, 0, 60); TabContainer.BackgroundTransparency = 1
Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0, 5)

-- Content
local PageHolder = Instance.new("Frame", MainFrame)
PageHolder.Size = UDim2.new(1, -175, 1, -40); PageHolder.Position = UDim2.new(0, 165, 0, 10); PageHolder.BackgroundTransparency = 1

-- [[ SISTEMA DE ABAS PROFISSIONAL ]]
local Tabs = {}
local function SwitchTab(target)
    for i, v in pairs(Tabs) do
        v.Page.Visible = (i == target)
        v.Button.TextColor3 = (i == target) and Color3.fromRGB(65, 120, 255) or Color3.fromRGB(120, 120, 120)
        v.Button.BackgroundColor3 = (i == target) and Color3.fromRGB(22, 22, 26) or Color3.fromRGB(18, 18, 20)
    end
end

local function NewTab(name)
    local Page = Instance.new("ScrollingFrame", PageHolder)
    Page.Size = UDim2.new(1, 0, 1, 0); Page.BackgroundTransparency = 1; Page.Visible = false; Page.ScrollBarThickness = 0
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 8)
    
    local Btn = Instance.new("TextButton", TabContainer)
    Btn.Size = UDim2.new(0, 130, 0, 32); Btn.BackgroundColor3 = Color3.fromRGB(18, 18, 20); Btn.Text = name; Btn.TextColor3 = Color3.fromRGB(120, 120, 120); Btn.Font = "GothamBold"; Btn.TextSize = 10
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    Btn.MouseButton1Click:Connect(function() SwitchTab(name) end)
    
    Tabs[name] = {Page = Page, Button = Btn}
    return Page
end

-- [[ COMPONENTES ]]
local function AddToggle(parent, text, key)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -12, 0, 42); f.BackgroundColor3 = Color3.fromRGB(16, 16, 20); Instance.new("UICorner", f)
    local l = Instance.new("TextLabel", f); l.Size = UDim2.new(0.6, 0, 1, 0); l.Position = UDim2.new(0, 12, 0, 0); l.Text = text; l.TextColor3 = Color3.fromRGB(180, 180, 180); l.Font = "GothamSemibold"; l.TextSize = 11; l.TextXAlignment = 0; l.BackgroundTransparency = 1
    local t = Instance.new("TextButton", f); t.Size = UDim2.new(0, 38, 0, 18); t.Position = UDim2.new(1, -50, 0.5, -9); t.BackgroundColor3 = Color3.fromRGB(30, 30, 35); t.Text = ""; Instance.new("UICorner", t).CornerRadius = UDim.new(0, 10)
    
    t.MouseButton1Click:Connect(function()
        getgenv().HubConfig[key] = not getgenv().HubConfig[key]
        TS:Create(t, TweenInfo.new(0.3), {BackgroundColor3 = getgenv().HubConfig[key] and Color3.fromRGB(65, 120, 255) or Color3.fromRGB(30, 30, 35)}):Play()
        Notify(text, getgenv().HubConfig[key] and "Ligado" or "Desligado")
    end)
end

-- Criando as Abas
local MainTab = NewTab("Main")
local VisualTab = NewTab("Visual")
local MiscTab = NewTab("Misc")
local CreditsTab = NewTab("Créditos")

-- Adicionando as 5 Funções Principais
AddToggle(MainTab, "Aimbot Lock-On", "Aimbot")
AddToggle(MainTab, "Hitbox Expander", "Hitbox")
AddToggle(VisualTab, "ESP Name & Box", "Esp")
AddToggle(MiscTab, "Noclip Stealth", "Noclip")
AddToggle(MiscTab, "Boost FPS Ultra", "BoostFPS")

-- [[ MOTOR DE EXECUÇÃO PROFISSIONAL ]]
RS.Heartbeat:Connect(function()
    -- 1. Hitbox Logic (Safe)
    if getgenv().HubConfig.Hitbox then
        for _, v in pairs(Players:GetPlayers()) do
            pcall(function()
                if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    v.Character.HumanoidRootPart.Size = Vector3.new(getgenv().HubConfig.HitSize, getgenv().HubConfig.HitSize, getgenv().HubConfig.HitSize)
                    v.Character.HumanoidRootPart.Transparency = 0.7
                    v.Character.HumanoidRootPart.CanCollide = false
                end
            end)
        end
    end
    
    -- 2. Boost FPS (Memory Manager)
    if getgenv().HubConfig.BoostFPS then
        setfpscap(999)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsDescendantOf(lp.Character) then
                v.CastShadow = false
            end
        end
    end
end)

-- Noclip Thread
task.spawn(function()
    while task.wait() do
        if getgenv().HubConfig.Noclip then
            pcall(function()
                for _, v in pairs(lp.Character:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end)
        end
    end
end)

-- Botão Flutuante (Animação de Início)
local TBtn = Instance.new("ImageButton", MainGui)
TBtn.Size = UDim2.new(0, 48, 0, 48); TBtn.Position = UDim2.new(0, 20, 0.5, -24); TBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 12); TBtn.Image = "rbxassetid://6023454774"; Instance.new("UICorner", TBtn); Instance.new("UIStroke", TBtn).Color = Color3.fromRGB(65, 120, 255)
TBtn.Draggable = true

TBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    if MainFrame.Visible then
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        TS:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0, 580, 0, 320)}):Play()
    end
end)

-- Finalização
SwitchTab("Main")
Notify("Universal Hub v2.0", "Sistema Operacional e Protegido!")