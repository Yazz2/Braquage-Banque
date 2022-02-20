
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)




-- MENU FUNCTION --
cooldown = false
local AppelCoords = nil
local AppelEnAttente = false 
local playerCoords = GetEntityCoords(PlayerPedId())
local open = false 
local mainMenu6 = RageUI.CreateMenu('Braquage', 'BRAQUAGE')
mainMenu6.Display.Header = true 
mainMenu6.Closed = function()
  open = false
  FreezeEntityPosition(PlayerPedId(), false)

end



function OpenMenuBraquage()
     if open then 
         open = false
         RageUI.Visible(mainMenu6, false)
         return
     else
         open = true 
         RageUI.Visible(mainMenu6, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(mainMenu6,function() 
                for k, v in pairs(Braquage.Time) do

                RageUI.Button(v.name, v.sousname, {RightLabel = "→"}, not cooldown , {
                    onSelected = function()

                        TriggerServerEvent("Braquage:Banque", GetEntityCoords(PlayerPedId()), 4)
                        
                        RageUI.CloseAll()
                        OpenMenuTime()
                        OpenMenuTime()

                        gopanel = true

                        cooldown = true
                        Wait(2000)
                        cooldown = false
                        local money = v.money
                        
                        TriggerServerEvent("Braquage:Argent", money)
                        
                        
                        


                    end
                })


            end
            
            end)
            
           
          Wait(0)
         end
      end)
   end
end



local main = RageUI.CreateMenu('Braquage', 'BRAQUAGE')
local chargement = 0.0
gopanel = nil

main.Display.Header = true 
main.Closed = function()
  open1 = false
  FreezeEntityPosition(PlayerPedId(), false)

end
main.Closable = false 


    function OpenMenuTime()
    if open then 

        open = false
        RageUI.Visible(main, false)
        return
    else
        open = true        
        RageUI.Visible(main, true)
        CreateThread(function()
        while open do 
           RageUI.IsVisible(main,function() 
            
            RageUI.Separator("[ ~g~"..GetPlayerName(PlayerId()).."~s~ ]")
        
            RageUI.Button("                 ~r~La police a était alerté", nil, {RightLabel = ""}, true , {})
            
            RageUI.Button("Arreter le braquage", nil, {RightLabel = "→"}, true , {
                onSelected = function()

                    open = false
                    ESX.ShowNotification("~r~Vous avez arreté le braquage. Vous ne recevera pas la la récompense")


                end
            })
            if gopanel == true then
            RageUI.PercentagePanel(chargement, " Fin du braquage : "..math.floor(chargement*100).."%~s~", "", "", {})
            for k, v in pairs(Braquage.Time) do
                if chargement < 1.0 then
                
                    chargement = chargement + 0.00001
                
            else chargement = 0 end
            if chargement >= 1.0 then

                ClearPedTasksImmediately(GetPlayerPed(-1))
                
                Wait(2000)
                ClearPedTasksImmediately(GetPlayerPed(-1))
                chargement = 0
                    
                    ESX.ShowNotification("~r~Braquage Fini~s~")
                    ESX.ShowNotification("Vous avez eu votre récompense de "..v.money.."~g~$")

                open = false
                RageUI.CloseAll()
                gopanel = false
            end
                
        end
            end
          
            
           
            end)
         Wait(0)
        end
     end)
  end

  
end



local positonbra = {
	{x = 254.42, y = 225.12, z = 101.88-1}

}



Citizen.CreateThread(function()
    for k, v in pairs(positonbra) do 
    while true do
  
      local wait = 750
  
        for k, v in pairs(positonbra) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)
           
        
            if dist <= 2.5 then
                DrawMarker(27, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 1.0, 1.0, 1.0, 0, 155, 255, 255, false, false, p19, false)  

                wait = 1
                ESX.ShowHelpNotification("Appuyer sur~p~ ~INPUT_PICKUP~ pour commencer le braquage") 
                if IsControlJustPressed(1,51) then
                    OpenMenuBraquage()
                end
            end 
        end
    Citizen.Wait(wait)
    end
  end
  end)