local discordlibrary = 'https://raw.githubusercontent.com/misanthropic2005/libs/main/edited/discordlibrary.lua'

--// aimlock settings

local aimlock_settings = {
 ['Aimlock'] = true,
 ['Aimlock_Firing'] = false,
 ['Key'] = Enum.KeyCode.X,
 ['FOVColor'] = Color3.fromRGB(255, 255, 255)
}

local aimlockui = loadstring(
 game:HttpGet('https://raw.githubusercontent.com/misanthropic2005/DaHood/main/library(s)/Valiant.lua')
)()

local gamemodules = loadstring(
 game:HttpGet('https://raw.githubusercontent.com/misanthropic2005/Meta-Hub/main/games/8232411/modules/Innovation.lua')
)()

aimlockui['FOV'] = 35;
aimlockui['FOVRGB'] = aimlock_settings['FOVColor'];
aimlockui['TeamCheck'] = true;
aimlockui['VisibleCheck'] = false;

--// library setup
if game:HttpGet(discordlibrary) then
   discordlibrary = game:HttpGet(discordlibrary)
   discordlibrary = loadstring(discordlibrary)
else
   game:GetService('Players').LocalPlayer:Kick('Initiation failed!')
end

discordlibrary = discordlibrary()

--// window setup

local mainwindow = discordlibrary:Window('Meta Hub - Innovation Security Training')

--// server setup

local mainserver_logo = '132597322'
local mainserver = mainwindow:Server('Settings', 'rbxassetid://' .. mainserver_logo)

--// channel setup

local mainserver_aimlock = mainserver:Channel('aimlock')
local mainserver_misc = mainserver:Channel('miscellaneous')

--// aimlock setup

local msa_aimlock_state = function(Bool)
   aimlockui['ShowFOV'] = Bool
   aimlock_settings['Aimlock'] = Bool
   
    gamemodules.Innovation_Notify(
     'aimlock',
     tostring(Bool),
     1
    )
end

local msa_aimlock = mainserver_aimlock:Toggle('Aimlock', aimlock_settings['Aimlock'], function(state)
    msa_aimlock_state(state)
end)

local msa_aimlock_select_func = function(player, target)
   gamemodules.fireat(player, target)
end
 
local msa_ign = mainserver_aimlock:Toggle('Ignore Team', aimlockui['TeamCheck'], function(state)
    aimlockui['TeamCheck'] = state
    
    gamemodules.Innovation_Notify(
     'team check',
     tostring(state),
     1
    )
end)

local msa_vis = mainserver_aimlock:Toggle('Visible Check', aimlockui['VisibleCheck'], function(state)
    aimlockui['VisibleCheck'] = state
    
    gamemodules.Innovation_Notify(
     'visible check',
     tostring(state),
     1
    )  
end

local msa_aimlock_select = mainserver_aimlock:Bind('Target Bind', aimlock_settings['Key'], function()
    aimlockui.getClosestPlayerToCursor(); 
    
    if aimlockui.Selected ~= nil then
       msa_aimlock_select_func(game.Players.LocalPlayer, aimlockui.Selected)
    end
end)

local msa_fov_slider = mainserver_aimlock:Slider('FOV Value', 25, 180, aimlockui['FOV'], function(num)
    aimlockui['FOV'] = num
end)

local msa_fov_color_change = function(rgb)
   aimlock_settings['FOVColor'] = rgb
   aimlockui.FOVRGB = rgb
end

local msa_fov_color = mainserver_aimlock:Colorpicker('FOV Color', aimlock_settings['FOVColor'], function(rgb)
    msa_fov_color_change(rgb)
end)

--// misc setup

local misc_gauntlet = mainserver_misc:Toggle('Huge Gauntlet', false, function(state)
    gamemodules.setgauntlet(state)
end)

local misc_baton_touch = mainserver_misc:Button('touch baton', function()
    gamemodules.touchbaton(game.Players.LocalPlayer)
end)
