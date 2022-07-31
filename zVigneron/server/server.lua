TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'vigne', 'alerte vigne', true, true)

TriggerEvent('esx_society:registerSociety', 'vigne', 'vigne', 'society_vigne', 'society_vigne', 'society_vigne', {type = 'public'})

RegisterServerEvent('Ouvre:vigne')
AddEventHandler('Ouvre:vigne', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Vigneron', '~p~Annonce', 'Les Vignerons sont ~g~disponibles ~s~ !', 'CHAR_LEST_MIKE_CONF', 8)
	end
end)

RegisterServerEvent('Ferme:vigne')
AddEventHandler('Ferme:vigne', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Vigneron', '~p~Annonce', 'Les Vignerons sont ~r~Indisponibles ~s~ !', 'CHAR_LEST_MIKE_CONF', 8)
	end
end)

RegisterServerEvent('Recru:vigne')
AddEventHandler('Recru:vigne', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Vigneron', '~p~Annonce', '~y~Recrutement en cours, rendez-vous au Vigneron', 'CHAR_LEST_MIKE_CONF', 8)
	end
end)

RegisterCommand('vigne', function(source, args, rawCommand)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  if xPlayer.job.name == "vigne" then
      local src = source
      local msg = rawCommand:sub(5)
      local args = msg
      if player ~= false then
          local name = GetPlayerName(source)
          local xPlayers	= ESX.GetPlayers()
      for i=1, #xPlayers, 1 do
          local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
          TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Vigneron', '~p~Annonce', ''..msg..'', 'CHAR_LEST_MIKE_CONF', 0)
      end
  else
      TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~r~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_CARSITE3', 0)
  end
else
  TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~r~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_CARSITE3', 0)
end
end, false)


ESX.RegisterServerCallback('vigne:playerinventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	local all_items = {}
	
	for k,v in pairs(items) do
		if v.count > 0 then
			table.insert(all_items, {label = v.label, item = v.name,nb = v.count})
		end
	end

	cb(all_items)

	
end)

ESX.RegisterServerCallback('vigne:getStockItems', function(source, cb)
	local all_items = {}
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigne', function(inventory)
		for k,v in pairs(inventory.items) do
			if v.count > 0 then
				table.insert(all_items, {label = v.label,item = v.name, nb = v.count})
			end
		end

	end)
	cb(all_items)
end)

ESX.RegisterServerCallback('vigne:getStockItems', function(source, cb)
	local all_items = {}
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigne', function(inventory)
		for k,v in pairs(inventory.items) do
			if v.count > 0 then
				table.insert(all_items, {label = v.label,item = v.name, nb = v.count})
			end
		end

	end)
	cb(all_items)
end)

RegisterServerEvent('vigne:putStockItems')
AddEventHandler('vigne:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item_in_inventory = xPlayer.getInventoryItem(itemName).count

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigne', function(inventory)
		if item_in_inventory >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, "- ~g~Dépot\n~s~- ~g~Coffre : ~s~Vigneron \n~s~- ~o~Quantitée ~s~: "..count.."")
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Vous n'en avez pas assez sur vous")
		end
	end)
end)

RegisterServerEvent('vigne:takeStockItems')
AddEventHandler('vigne:takeStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigne', function(inventory)
			xPlayer.addInventoryItem(itemName, count)
			inventory.removeItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, "- ~r~Retrait\n~s~- ~g~Coffre : ~s~Vigneron \n~s~- ~o~Quantitée ~s~: "..count.."")
	end)
end)


-- Farm

RegisterNetEvent('recolteraisin')
AddEventHandler('recolteraisin', function()
    local item = "raisin"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de place dans ton inventaire!")
        recoltepossible = false
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
		return
    end
end)

RegisterNetEvent('traitementjusraisin')
AddEventHandler('traitementjusraisin', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local raisin = xPlayer.getInventoryItem('raisin').count
    local jus_raisin = xPlayer.getInventoryItem('jus_raisin').count
	local grand_cru = xPlayer.getInventoryItem('grand_cru').count

    if jus_raisin > 250 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de jus de raisin...')
    elseif raisin < 5 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de jus de raisin pour traiter...')
    else
        xPlayer.removeInventoryItem('raisin', 5)
        xPlayer.addInventoryItem('jus_raisin', 5)
		xPlayer.addInventoryItem('grand_cru', 1)
    end
end)


RegisterServerEvent('selljusraisin')
AddEventHandler('selljusraisin', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local jus_raisin = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "jus_raisin" then
			jus_raisin = item.count
		end
	end
    
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
        societyAccount = account
    end)
    
    if jus_raisin > 0 then
        xPlayer.removeInventoryItem('jus_raisin', 1)
        xPlayer.addMoney(Config.Jus)
        societyAccount.addMoney(Config.JusEntreprise)
        TriggerClientEvent('esx:showNotification', xPlayer.source, "~s~Vous avez gagner ~g~"..Config.Jus.."$~s~ la vente d'un jus de raisin")
        TriggerClientEvent('esx:showNotification', xPlayer.source, "~s~La société a gagné ~g~"..Config.JusEntreprise.."$~s~ pour la vente d'un jus de raisin")
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous n'avez plus rien à vendre")
    end
end)

RegisterServerEvent('sellgrandcru')
AddEventHandler('sellgrandcru', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local grand_cru = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "grand_cru" then
			grand_cru = item.count
		end
	end
    
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
        societyAccount = account
    end)
    
    if grand_cru > 0 then
        xPlayer.removeInventoryItem('grand_cru', 1)
        xPlayer.addMoney(Config.GrandCru)
        societyAccount.addMoney(Config.GrandCruEntreprise)
        TriggerClientEvent('esx:showNotification', xPlayer.source, "~s~Vous avez gagner ~g~"..Config.GrandCru.."$~s~ la vente d'un ~p~grand cru")
        TriggerClientEvent('esx:showNotification', xPlayer.source, "~s~La société à gagné ~g~"..Config.GrandCruEntreprise.."$~s~ pour la vente d'un ~p~grand cru")
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous n'avez plus rien à vendre")
    end
end)

RegisterServerEvent('vigne:withdrawMoney')
AddEventHandler('vigne:withdrawMoney', function(society, amount, money_soc)
	local xPlayer = ESX.GetPlayerFromId(source)
	local src = source
  
	TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
	  if account.money >= tonumber(amount) then
		  xPlayer.addMoney(amount)
		  account.removeMoney(amount)
		  TriggerClientEvent("esx:showNotification", src, "- ~o~Retiré \n~s~- ~g~Somme : "..amount.."$")
	  else
		  TriggerClientEvent("esx:showNotification", src, "- ~r~L'entreprise \n~s~- ~g~Pas assez d'argent")
	  end
	end)
	  
  end)

RegisterServerEvent('vigne:depositMoney')
AddEventHandler('vigne:depositMoney', function(society, amount)

	local xPlayer = ESX.GetPlayerFromId(source)
	local money = xPlayer.getMoney()
	local src = source
  
	TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
	  if money >= tonumber(amount) then
		  xPlayer.removeMoney(amount)
		  account.addMoney(amount)
		  TriggerClientEvent("esx:showNotification", src, "- ~o~Déposé \n~s~- ~g~Somme : "..amount.."$")
	  else
		  TriggerClientEvent("esx:showNotification", src, "- ~r~Erreur \n~s~- ~g~Pas assez d'argent")
	  end
	end)
	
end)

ESX.RegisterServerCallback('vigne:getSocietyMoney', function(source, cb, soc)
	local money = nil
		MySQL.Async.fetchAll('SELECT * FROM addon_account_data WHERE account_name = @society ', {
			['@society'] = soc,
		}, function(data)
			for _,v in pairs(data) do
				money = v.money
			end
			cb(money)
		end)
end)

