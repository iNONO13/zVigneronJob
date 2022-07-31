local mainMenu = RageUI.CreateMenu("~p~Vigneron", "~p~MENU Vigneron") 
 local MenuFarm = RageUI.CreateSubMenu(mainMenu, "~p~Localisation", "~p~MENU Vigneron") 
 local annoncemenu = RageUI.CreateSubMenu(mainMenu, "~p~Annonce", "~p~MENU Vigneron")


 local open = false
 
 mainMenu.X = 0 
 mainMenu.Y = 0
 
 mainMenu.Closed = function() 
     open = false 
 end 
 
 function menuvigne()
     if open then 
         open = false 
             RageUI.Visible(mainMenu, false) 
             return 
     else 
         open = true 
             RageUI.Visible(mainMenu, true)
         Citizen.CreateThread(function()
             while open do 
                 RageUI.IsVisible(mainMenu, function()
                    RageUI.Checkbox("Prendre son service Vigneron", nil, serviceVigne, {}, {
                        onChecked = function(index, items)
                            serviceVigne = true
                            TriggerServerEvent('vigne:prisedeservice')
                            ESX.ShowNotification("~p~Vous avez pris votre service !")
                        end,
                        onUnChecked = function(index, items)
                            serviceVigne = false
                            TriggerServerEvent('vigne:prisedeservice')
                            ESX.ShowNotification("~p~Vous avez quitter votre service !")
                        end
                    })				

                 if serviceVigne then

                    RageUI.Separator("~p~↓ ~o~Options ~p~↓") 

                       RageUI.Button("Point de Farm", nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                        end
                       }, MenuFarm)

					   RageUI.Button("Facture", nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            ESX.UI.Menu.Open(
                                'dialog', GetCurrentResourceName(), 'facture',
                                {
                                    title = 'Donner une facture'
                                },
                                function(data, menu)
                        
                                    local amount = tonumber(data.value)
                        
                                    if amount == nil or amount <= 0 then
                                        ESX.ShowNotification('Montant invalide')
                                    else
                                        menu.close()
                        
                                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        
                                        if closestPlayer == -1 or closestDistance > 3.0 then
                                            ESX.ShowNotification('Pas de joueurs proche')
                                        else
                                            local playerPed        = GetPlayerPed(-1)
                        
                                            Citizen.CreateThread(function()
                                                TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
                                                Citizen.Wait(5000)
                                                ClearPedTasks(playerPed)
                                                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_vigne', 'vigne', amount)
                                                ESX.ShowNotification("~r~Vous avez bien envoyer la facture")
                                            end)
                                        end
                                    end
                                end,
                                function(data, menu)
                                    menu.close()
                            end)
                         end
                        })
                       RageUI.Button("Annonce", nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                        end
                       }, annoncemenu)
						end 
					end)

                    RageUI.IsVisible(MenuFarm, function()
                        ESX.PlayerData = ESX.GetPlayerData()
                        RageUI.Separator("~p~↓ ~o~Points de Farm ~p~↓")

                        RageUI.Button("Point de Récolte", nil, {RightLabel = "→ ~p~Mettre le point"}, true, {
                            onSelected = function()
                                SetNewWaypoint(Config.Recolte)
                            end
                           })
			
                        RageUI.Button("Point de Traitement", nil, {RightLabel = "→ ~p~Mettre le point"}, true, {
                            onSelected = function()
								SetNewWaypoint(Config.Traitement) 
                            end
                        })
			
                        RageUI.Button("Point de Vente", nil, {RightLabel = "→ ~p~Mettre le point"}, true, {
                            onSelected = function()
								SetNewWaypoint(Config.Vente) 
                            end
                        })
			
						end)							                     

                RageUI.IsVisible(annoncemenu, function()
                    ESX.PlayerData = ESX.GetPlayerData()
                    RageUI.Separator("~p~↓ ~o~Annonce ~p~↓")

                    RageUI.Button("Annonce [~g~OUVERTURE~s~]", nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            TriggerServerEvent('Ouvre:vigne')
                        end
                       })

                       RageUI.Button("Annonce [~r~FERMETURE~s~]", nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            TriggerServerEvent('Ferme:vigne')  
                        end
                       })

                       RageUI.Button("Annonce [~y~RECRUTEMENT~s~]", nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            TriggerServerEvent('Recru:vigne') 
                        end
                       })
                end)
			
             Wait(0)
				
             end
         end)
     end
 end
 
 -- COMMANDE OUVERTURE MENU
 
 Keys.Register('F6', 'vigneron', 'Ouvrir le menu Vigneron', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigne' then
        if IsControlJustPressed(1,167) then
        menuvigne()
        end
	end
end)