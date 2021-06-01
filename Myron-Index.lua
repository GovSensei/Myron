--#region Close when executed again
if game.CoreGui:FindFirstChild("Myron") then
    game.CoreGui["Myron"]:Destroy()
end
--#endregion

--#region Locals
local vVars = {}
local sec = {}
local cat = {}
local infJump = nil
local walkWater 
local delWater
local delLava
--#endregion

--#region Send Notifications
function SendNotification(Title, Text, Duration)
    game.StarterGui:SetCore("SendNotification",{
        Title = Title,
        Text = Text,
        Icon = "",
        Duration = Duration
    })
end
--#endregion

--#region library
local library = loadstring(game:HttpGet("https://zypher.wtf/UI-Lib"))()
local Main = library:CreateMain({
    projName = "Myron",
    Resizable = false,
    MinSize = UDim2.new(0, 400, 0, 400),
    MaxSize = UDim2.new(0, 400, 0, 400)
})
--#endregion

--#region Category's
cat.Myron = Main:CreateCategory("Myron Beta 1.0")
cat.Credits = Main:CreateCategory("Credits")
cat.Move = Main:CreateCategory("Player")
cat.env = Main:CreateCategory("Enviroment")
cat.World = Main:CreateCategory("World")
--#endregion

--#region Myron Section
sec.Myron = cat.Myron:CreateSection("Myron")

sec.Myron:Create("TextLabel", "مايرون")
sec.Myron:Create("TextLabel", "Discord Server: https://discord.gg/Fx45KN8745")
sec.Myron:Create("TextLabel", "Support Discord Server: https://discord.gg/c7V5XSExD8")
sec.Myron:Create("Button", "Close Script", 
    function()
        game.CoreGui["Myron"]:Destroy()
    end,
{
    animated = true
})
--#endregion

--#region Credits Section
sec.Credits = cat.Credits:CreateSection("Credits")

sec.Credits:Create("TextLabel", "Developer: GovSensei")
sec.Credits:Create("TextLabel", "UI Lib Developer: xTheAlex14")
sec.Credits:Create("TextLabel", "Tester: Joch505")
sec.Credits:Create("TextLabel", "Encouraged Me: Char")
--#endregion

--#region Player Section
sec.sMove = cat.Move:CreateSection("Movement")
sec.sMove2 = cat.Move:CreateSection("Other")

sec.sMove2:Create("Toggle", "Infinite Jump", 
    function(state)
        if state == true then
            infJump = game:GetService("UserInputService").JumpRequest:Connect(function()
                game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end)
        else
            if infJump then
                infJump:Disconnect()

            end
        end
    end,
    {
        default = false
    }
)

sec.sMove2:Create("Toggle", "No Clip",
    function(state)
        if state == true then
            vVars.clipper = game:GetService("RunService").Stepped:Connect(function()
                if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Torso") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Head") then
                    game:GetService("Players").LocalPlayer.Character:FindFirstChild("Torso").CanCollide = not state
                    game:GetService("Players").LocalPlayer.Character:FindFirstChild("Head").CanCollide = not state
                end
        end)
    else
        if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Torso") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Head") then
            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Torso").CanCollide = true
            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Head").CanCollide = true
        end
        if vVars.clipper then
            vVars.clipper:Disconnect()
        end
    end

end,
{
    default = false
}
)

walkWater = sec.sMove2:Create("Toggle", "Walk On Water",
    function(state)
        if state == true then
            delWater:ChangeState(false)
        end
        for i, v in pairs(game:GetService("Workspace").Water:GetChildren()) do
            if v.Name == "Water" then
                v.CanCollide = state
            end
        end
    end,
{
    default = false
})

sec.sMove2:Create("Slider", "Field Of View",
    function(value)
        game:GetService("Workspace").CurrentCamera.FieldOfView = value
    end,
{
    min = 40,
    max = 120,
    default = 70,
    changablevalue = true
})

sec.sMove2:Create("Slider", "Zoom Distance",
    function(value)
        game.Players.LocalPlayer.CameraMaxZoomDistance = value
    end,
{
    min = 120,
    max = 1200,
    default = 120,
    changablevalue = true
})

sec.sMove2:Create("Button", "Safe Suicide",
    function()
        game.Players.LocalPlayer.Character.Head:Remove()
    end,
{
    animated = true
})

sec.sMove:Create("Slider", "Walk Speed", 
    function(value)
        vVars.walkSpeed = value
    end,
{
    min = 16,
    max = 400,
    default = 16,
    changablevalue = true
})

sec.sMove:Create("Slider", "Jump Power", 
    function(value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
end,
{
    min = 50,
    max = 400,
    default = 50,
    changablevalue = true
})
--#endregion

--#region Enviroment Section
sec.Env = cat.env:CreateSection("Enviroment")

sec.Env:Create("Button", "Always Day",
    function()
        vVars.day = true
        vVars.night = false
    end,
{
    animated = true
})

sec.Env:Create("Button", "Always Night",
    function()
        vVars.day = false
        vVars.night = true
    end,
{
    animated = true
})

sec.Env:Create("Toggle", "No Fog",
    function(state)
        vVars.fog = state
    end,
{
    default = true
})

sec.Env:Create("Toggle", "Shadows",
    function(state)
        game:GetService("Lighting").GlobalShadows = state
    end,
{
    default = true
})

sec.Env:Create("Slider", "Brightness",
    function(value)
        vVars.dayBright = value
    end,
{
    min = 1,
    max = 5,
    default = 2,
    changablevalue = true
})
--#endregion

--#region World Section
sec.elem = cat.World:CreateSection("World")

delWater = sec.elem:Create("Toggle", "Delete Water",
    function(state)
        if state then
            walkWater:ChangeState(false)
        end
        for i, v in pairs(game:GetService("Workspace").Water:GetChildren()) do
            if v.Name == "Water" then
                if state then
                    v.Transparency = 1
                else
                    v.Transparency = 0
                end
            end
        end
    end,
{
    default = false
})

delLava = sec.elem:Create("Toggle", "Delete Lava",
    function(state)
        for i, v in pairs(game:GetService("Workspace")["Region_Volcano"]:GetDescendants()) do
            if v.Name == "Lava" then
                for n, k in pairs(v:GetChildren()) do
                    if k:IsA("Part") then
                        if state then
                            k.Transparency = 1
                        else
                            k.Transparency = 0
                        end
                    end
                end
            end
        end
    end,
{
    default = false
})

vVars.delLavaBoulders = false
    function delLavaBoulders()
        if vVars.delLavaBoulders then
            repeat
                for i, v in pairs(game:GetService("Workspace")["Region_Volcano"].PartSpawner:GetChildren()) do
                    if v.Name == "Part" then
                        v:Destroy()
                end
            end
            wait(2)
        until vVars.delLavaBoulders == false
    end
end

sec.elem:Create("Toggle", "Delete Lava Boulders",
    function(state)
        if state then
            vVars.delLavaBoulders = true
            delLavaBoulders()
        else 
            vVars.delLavaBoulders = false
        end
    end,
{
    default = false
})

vVars.lowerBridge = sec.elem:Create("Toggle", "Lower Bridge (Client Sided)",
        function(state)
            if state then
                for i, v in pairs(game:GetService("Workspace").Bridge.VerticalLiftBridge.Lift:GetChildren()) do
                    v.CFrame = v.CFrame + Vector3.new(0, -26, 0)
            end
            for i, v in pairs(game:GetService("Workspace").Bridge.VerticalLiftBridge.Weight:GetChildren()) do
                v.CFrame = v.CFrame + Vector3.new(0, 26, 0)
            end
        else
            for i, v in pairs(game:GetService("Workspace").Bridge.VerticalLiftBridge.Lift:GetChildren()) do
                v.CFrame = v.CFrame + Vector3.new(0, 26, 0)
            end
            for i, v in pairs(game:GetService("Workspace").Bridge.VerticalLiftBridge.Weight:GetChildren()) do
                v.CFrame = v.CFrame + Vector3.new(0, -26, 0)
            end
        end
    end,
{
    default = false
})

sec.elem:Create("Button", "Lower Bridge (Paid)",
    function()
        local playerMoney = game.Players.LocalPlayer.leaderstats.Money.value
        if playerMoney > 100 then
            local A_1 = 
            {
                ["Character"] = Workspace.Bridge.TollBooth0.Seranok,
                ["Name"] = "Seranok",
                ["ID"] = 7,
                ["Dialog"] = game:GetService("Workspace").Bridge.TollBooth0.Seranok.Dialog
            }
            local A_2 = "ConfirmPurchase"
            local Event = game:GetService("ReplicatedStorage").NPCDialog.PlayerChatted
            Event:InvokeServer(A_1, A_2)
        else
            SendNotification("Myron", "You dont have enough money!", 5)
        end
    end,
{
    animated = true
})
--#endregion

--#region Render Stepped
vVars.rStep = game:GetService("RunService").RenderStepped:Connect(function()
    if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").WalkSpeed ~= 0 then
            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").WalkSpeed = vVars.walkSpeed
        end
    end
    if vVars.day == true then
        game.Lighting.TimeOfDay = "12:00:00"
        game.Lighting.Brightness = vVars.dayBright
    elseif vVars.night then
        game.Lighting.TimeOfDay = "00:00:00"
        game.Lighting.Brightness = vVars.dayBright
    end
    if vVars.fog then
        game.Lighting.FogEnd = 10000
    end
end)
--#endregion

--#region Close Script
vVars.scriptClosing = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
    if child.Name == "Myron" then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
        game:GetService("Workspace").CurrentCamera.FieldOfView = 70
        game.Players.LocalPlayer.CameraMaxZoomDistance = 120
        game:GetService("Lighting").GlobalShadows = true
        game.Lighting.Brightness = 1
        walkWater:ChangeState(false)
        delWater:ChangeState(false)
        delLava:ChangeState(false)
        vVars.lowerBridge:ChangeState(false)
        vVars.delLavaBoulders = false
        if vVars.rStep then
            vVars.rStep:Disconnect()
        end
        if vVars.clipper then
            vVars.clipper:Disconnect()
        end
        if infJump then
            infJump:Disconnect()
        end
        if vVars.scriptClosing then
            vVars.scriptClosing:Disconnect()
        end
    end
end)
--#endregion