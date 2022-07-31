local open = false 
local mainMenu6 = RageUI.CreateMenu('~p~Garage Vigneron', '~p~Faites votre choix ?')
mainMenu6.Display.Header = true 
mainMenu6.Closed = function()
  open = false
end

function Garagevigne()
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

              RageUI.Separator("↓ Véhicules ↓")

                for k,v in pairs (Config.VehiculeVigne) do
                RageUI.Button(v.buttoname, nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        if not ESX.Game.IsSpawnPointClear(vector3(v.spawnzone.x, v.spawnzone.y, v.spawnzone.z), 10.0) then
                        ESX.ShowNotification("~p~Vigneron\n~r~Point de spawn bloquée")
                        else
                        local model = GetHashKey(v.spawnname)
                        RequestModel(model)
                        while not HasModelLoaded(model) do Wait(10) end
                        local ambuveh = CreateVehicle(model, v.spawnzone.x, v.spawnzone.y, v.spawnzone.z, v.headingspawn, true, false)
                        SetVehicleNumberPlateText(ambuveh, "~p~Vigneron"..math.random(50, 999))
                        SetVehicleFixed(ambuveh)
                        SetVehRadioStation(ambuveh, 0)
                        RageUI.CloseAll()
                        end
                    end
                })


              end
            end)
          Wait(0)
         end
      end)
   end
end

Citizen.CreateThread(function()
    while true do 
        local wait = 750
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigne' then
            for k in pairs(Config.Position.GarageVehicule) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local pos = Config.Position.GarageVehicule
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)
  
                if dist <= 5.0 then 
                    wait = 0
                    DrawMarker(Config.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
                end
  
                if dist <= 2.0 then 
                    wait = 0
                    ESX.ShowHelpNotification(Config.TextGarage) 
                    if IsControlJustPressed(1,51) then
                        Garagevigne()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
  end)
 
  --Ranger voiture

  local open = false 
local mainMenuRanger = RageUI.CreateMenu('~p~Garage Vigneron', '~p~Faites votre choix ?')
mainMenuRanger.Display.Header = true 
mainMenuRanger.Closed = function()
  open = false
end

function RangerVoiture()
     if open then 
         open = false
         RageUI.Visible(mainMenuRanger, false)
         return
     else
         open = true 
         RageUI.Visible(mainMenuRanger, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(mainMenuRanger,function() 


              RageUI.Separator("↓ Option ↓")

              RageUI.Button("Ranger votre véhicule", 'Vous devez ranger uniquement :\n- les véhicules de service ~p~Vigneron', {RightLabel = "→→"}, true , {
                onSelected = function()
                  local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                  if dist4 < 1 then
                      DeleteEntity(veh)
                      ESX.ShowNotification('~r~Garage \n~g~- Véhicule ranger !~s~')
                      RageUI.CloseAll()
                  end
                 end
             })



              end)
          Wait(0)
         end
      end)
   end
end

Citizen.CreateThread(function()
    while true do 
        local wait = 750
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigne' then
            for k in pairs(Config.Position.RangerVehicule) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local pos = Config.Position.RangerVehicule
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)
  
                if dist <= 5.0 then 
                    wait = 0
                    DrawMarker(Config.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
                end
  
                if dist <= 2.0 then 
                    wait = 0
                    ESX.ShowHelpNotification(Config.TextRangerGarage) 
                    if IsControlJustPressed(1,51) then
                        if IsPedSittingInAnyVehicle(PlayerPedId()) then
                            RangerVoiture()
                      else
                        ESX.ShowNotification('Vous devez être dans un ~r~Véhicule !~s~')
                       end
            end
            end
            end
        end
    Citizen.Wait(wait)
    end
  end)

  Citizen.CreateThread(function() 
    for k,v in pairs(Config.position) do
        local pos = Config.position
        local blip = AddBlipForCoord(v.x, v.y, v.z) 
                     SetBlipSprite  (blip, Config.blipsprite) 
                     SetBlipDisplay (blip, Config.blipdisplay) 
                     SetBlipScale   (blip, Config.blipscale) 
                     SetBlipColour  (blip, Config.blipcolour)
                     SetBlipAsShortRange(blip, true) 
                     BeginTextCommandSetBlipName('STRING') 
                     AddTextComponentSubstringPlayerName(Config.blipname) 
                     EndTextCommandSetBlipName(blip) 
   end
end)