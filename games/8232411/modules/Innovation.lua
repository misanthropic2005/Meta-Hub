local Innovation_Module = { }
local Innovation_Cldwnn = {
 firing = false,
 touching = false
}
local Innovation_Notify = function(Title, String, Time)
   
   if Time == nil or Time == 0 or Time < 1 then
      Time = 2
   end
  
   game:GetService('StarterGui'):SetCore('SendNotification',{
      Title = Title,
      Text = String,
      Duration = Time
   })
end

function Innovation_Module.Innovation_Notify(Title, String, Time)
   
   if Time == nil or Time == 0 or Time < 1 then
      Time = 2
   end
  
   game:GetService('StarterGui'):SetCore('SendNotification',{
      Title = Title,
      Text = String,
      Duration = Time
   })
end

function Innovation_Module.fireat(player, target)  
  
   if Innovation_Cldwnn.firing then return end
   
   Innovation_Cldwnn.firing = true
  
   local TargetPart;
   local LocalPart;
   local RailgunRemote;
  
   if target.Character then
      if target.Character:FindFirstChild('HumanoidRootPart') then
         TargetPart = target.Character.HumanoidRootPart
      end
   end
  
   if player.Character then
      if player.Character:FindFirstChild('HumanoidRootPart') then
         LocalPart = player.Character.HumanoidRootPart
      end    
   end
  
   if player.Character then
      if player.Character:FindFirstChild('Railgun') then
         
         local Railgun = player.Character.Railgun
      
         if Railgun:FindFirstChild('FireWeapon') then
            RailgunRemote = Railgun.FireWeapon
         end
      end
   end
  
   if TargetPart ~= nil then
      if LocalPart ~= nil then
         if RailgunRemote ~= nil then
            RailgunRemote:FireServer(LocalPart.Position, TargetPart, TargetPart.Position)
            Innovation_Cldwnn.firing = false
         else            
            Innovation_Cldwnn.firing = false
            Innovation_Notify('aimlock', 'failed to shoot: ' .. target.Name, nil)
            return
         end
      else
         Innovation_Cldwnn.firing = false
         Innovation_Notify('aimlock', 'failed to shoot: ' .. target.Name, nil)
         return
      end
   else
      Innovation_Cldwnn.firing = false
      Innovation_Notify('aimlock', 'failed to shoot: ' .. target.Name, nil)
      return
   end
  
   Innovation_Cldwnn.firing = false
end

function Innovation_Module.touchbaton(player)  
 
   if Innovation_Cldwnn.touching then return end
  
   Innovation_Cldwnn.touching = true
  
   local LocalPart;
  
   if player.Character then
      if player.Character:FindFirstChild('HumanoidRootPart') then
         LocalPart = player.Character.HumanoidRootPart
      end
   end
  
   if LocalPart ~= nil then
      
      local batonwasfound = false
  
      local touchsuccess, toucherror = pcall(function()
           for z, x in pairs(game.Players:GetPlayers()) do
             if x.Character then
                if x.Character:FindFirstChild("TeamBaton") then
                   local Tool = x.Character:FindFirstChild("TeamBaton") 

                   if Tool:FindFirstChild("Handle") then
                      firetouchinterest(Tool:FindFirstChild("Handle"), LocalPart, 0)
                      firetouchinterest(Tool:FindFirstChild("Handle"), LocalPart, 1)
                      batonwasfound = true
                   end
                end
             end
          end
      end)
     
      if touchsuccess and batonwasfound then
          Innovation_Cldwnn.touching = false
          Notify('baton touch', 'successfully touched the baton.', nil)
          return
      elseif not batonwasfound then
          Innovation_Cldwnn.touching = false
          Notify('baton touch', 'no baton found!', nil)   
      else
          Innovation_Cldwnn.touching = false
          Notify('baton touch', 'error', nil)
          return
      end
    
   else
      Innovation_Cldwnn.touching = false
      Innovation_Notify('baton touch', 'invalid character', nil)
      return
   end
  
   Innovation_Cldwnn.touching = false
end

function Innovation_Module.setgauntlet(bool)
   
   local Gauntlet = function()
      if workspace:FindFirstChild('GreatGauntlet') then
         return workspace.GreatGauntlet.Rings
      else
         return false
      end
   end
 
   local OGS = {
    Vector3.new(2, 1, 6),
    Vector3.new(6, 1, 6)
   }
 
   if bool then
  
      local GAU = Gauntlet()
  
      if GAU ~= false then
         for z, x in pairs(GAU:GetDescendants()) do
            if x:IsA("Part") then
      
               local PartSize = x.Size
      
               if table.find(OGS, PartSize) then
                  x.Size = OGS[2]
               end
            end
         end
   
         Innovation_Notify('gauntlet state', 'complete: ' .. tostring(bool), nil)
      else
         Innovation_Notify('gauntlet state', 'could not be found!', nil)
      end
  
   elseif not bool then
      
      local GAU = Gauntlet()
  
      if GAU ~= false then
         for z, x in pairs(GAU:GetDescendants()) do
            if x:IsA("Part") then
      
               local PartSize = x.Size
      
               if table.find(OGS, PartSize) then
                  x.Size = OGS[1]
               end
            end
         end
   
         Innovation_Notify('gauntlet state', 'complete: ' .. tostring(bool), nil)         
      else
         Innovation_Notify('gauntlet state', 'could not be found!', nil)
      end
  
   else
      Innovation_Notify('gauntlet state', 'failed!', nil)
   end
end

return Innovation_Module
