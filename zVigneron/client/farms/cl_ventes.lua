Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end
end)

--MENU--

local open = false 
local mainMenu = RageUI.CreateMenu('~p~Vente', '~p~MENU VIGNERON')
mainMenu.Display.Header = true 
mainMenu.Closed = function()
  open = false
end

--FUNCTION OPENMENU--

function Ventevigne()
	if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(mainMenu,function() 

			RageUI.Button("Vendre Jus de raisin", nil, {RightLabel = "~r~"..Config.Jus.."$"}, true , {
				onSelected = function()
                    TriggerServerEvent('selljusraisin')
				end
			}, subMenu)

			RageUI.Button("Vendre Grand Cru", nil, {RightLabel = "~r~"..Config.GrandCru.."$"}, true , {
				onSelected = function()
                    TriggerServerEvent('sellgrandcru')
				end
			}, subMenu)

		   end)
		Wait(0)
	   end
	end)
 end
end
		-------------------------------------------------------------------------------------------------------

local position = Config.Farm.Vente

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigne' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 4.0 then
            wait = 0
			DrawMarker(Config.MarkerType, position[k].x, position[k].y, position[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)   

        
            if dist <= 08.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~p~[E]~s~ pour ~p~vendre", 1) 
                if IsControlJustPressed(1,51) then
					Ventevigne()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)
