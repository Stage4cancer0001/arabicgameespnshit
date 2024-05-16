

local lplr = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = Workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.worldToViewportPoint

local headOff = Vector3.new(0, 1, 0)
local legOff = Vector3.new(0, 3, 0)

_G.Enabled = false

for i,v in pairs(game.Workspace.Bots:GetChildren()) do

    local BoxOutline = Drawing.new("Square")
    BoxOutline.Visible = false
    BoxOutline.Color = Color3.fromRGB(0,0,0)
    BoxOutline.Thickness = 3
    BoxOutline.Transparency = 1
    BoxOutline.Filled = false

    local Box = Drawing.new("Square") 
    Box.Visible = false
    Box.Color = Color3.fromRGB(255,255,255)
    Box.Thickness = 1
    Box.Transparency = 1
    Box.Filled = false

    local BoxFill = Drawing.new("Square")
    BoxFill.Visible = false
    BoxFill.Color = Color3.fromRGB(255,255,255)
    BoxFill.Thickness = 1
    BoxFill.Transparency = 0.3
    BoxFill.Filled = true

    local HealthOutline = Drawing.new("Square")
    HealthOutline.Visible = false
    HealthOutline.Color = Color3.fromRGB(0,0,0)
    HealthOutline.Thickness = 3
    HealthOutline.Transparency = 1
    HealthOutline.Filled = false

    local Health = Drawing.new("Square")
    Health.Visible = false
    Health.Color = Color3.fromRGB(0,255,0)
    Health.Thickness = 1
    Health.Transparency = 1
    Health.Filled = false

    function boxEsp()
        game:GetService("RunService").RenderStepped:Connect(function()
            if v.HumanoidRootPart ~= nil and v:FindFirstChild("Humanoid") ~= nil and v:FindFirstChild("HumanoidRootPart") ~= nil and Enabled ~= false then
                local Vector, onScreen = camera:worldToViewportPoint(v.HumanoidRootPart.Position)
                
                local RootPart = v.HumanoidRootPart
                local Head = v.Head
                local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
                local HeadPosition = worldToViewportPoint(CurrentCamera, v.Head.Position + headOff)
                local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - legOff)

                if onScreen then
                    BoxOutline.Size = Vector2.new(2500 / RootPosition.z, HeadPosition.Y - LegPosition.y)
                    BoxOutline.Position = Vector2.new(RootPosition.x - BoxOutline.Size.x / 2, RootPosition.y - BoxOutline.Size.y / 2)
                    BoxOutline.Visible = true

                    Box.Size = Vector2.new(2500 / RootPosition.z, HeadPosition.y - LegPosition.y)
                    Box.Position = Vector2.new(RootPosition.x - Box.Size.x / 2, RootPosition.y - Box.Size.y / 2)
                    Box.Visible = true

                    BoxFill.Size = Vector2.new(2500 / RootPosition.z, HeadPosition.y - LegPosition.y)
                    BoxFill.Position = Vector2.new(RootPosition.x - Box.Size.x / 2, RootPosition.y - Box.Size.y / 2)
                    BoxFill.Visible = true

                    HealthOutline.Size = Vector2.new(2, HeadPosition.Y - LegPosition.Y)
                    HealthOutline.Position = BoxOutline.Position - Vector2.new(6, 0)
                    HealthOutline.Visible = true

                    Health.Size = Vector2.new(2, ((HeadPosition.Y - LegPosition.Y)))
                    Health.Position = Vector2.new(Box.Position.X - 6, Box.Position.Y + (1/Health.Size.Y))
                    Health.Visible = true

                else
                    BoxOutline.Visible = false
                    Box.Visible = false
                    BoxFill.Visible = false
                    HealthOutline.Visible = false
                    Health.Visible = false
                end
            else
                BoxOutline.Visible = false
                Box.Visible = false
                BoxFill.Visible = false
                HealthOutline.Visible = false
                Health.Visible = false
            end
        end)
    end
    coroutine.wrap(boxEsp)()
end
