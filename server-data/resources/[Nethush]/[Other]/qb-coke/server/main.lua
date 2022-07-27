QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local hiddenprocess = vector3(2431.57,4971.2,42.35) -- Change this to whatever location you want. This is server side to prevent people from dumping the coords
local hiddenstart = vector3(180.04, 3033.25, 43.98) -- Change this to whatever location you want. This is server side to prevent people from dumping the coords

RegisterNetEvent('coke:updateTable')
AddEventHandler('coke:updateTable', function(bool)
    TriggerClientEvent('coke:syncTable', -1, bool)
end)

QBCore.Functions.CreateUseableItem('coke', function(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
 		TriggerClientEvent('coke:onUse', source)
	end
end)


QBCore.Functions.CreateCallback('coke:processcoords', function(source, cb)
    cb(hiddenprocess)
end)

QBCore.Functions.CreateCallback('coke:startcoords', function(source, cb)
    cb(hiddenstart)
end)

QBCore.Functions.CreateCallback('coke:pay', function(source, cb)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local amount = Config.amount
	local cashamount = Player.PlayerData.money["cash"]
    local toamount = tonumber(amount)
   
	if cashamount >= amount then
		Player.Functions.RemoveMoney('cash', amount) 
    	cb(true)
	else
		TriggerClientEvent("swt_notifications:Infos", src, "You dont have enough Money to Start")
		cb(false)
	end
end)

RegisterServerEvent("coke:processed")
AddEventHandler("coke:processed", function(x,y,z)
  	local src = source
  	local Player = QBCore.Functions.GetPlayer(src)
	local pick = Config.randBrick

		if 	TriggerClientEvent("swt_notifications:Infos", src, "Made a Coke Bag!!") then
			Player.Functions.RemoveItem('coke_brick', 1) 
			Player.Functions.AddItem('cokebaggy', 10)
			TriggerClientEvent("nethush-inventory:client:ItemBox", source, QBCore.Shared.Items['coke_brick'], "remove")
			TriggerClientEvent("nethush-inventory:client:ItemBox", source, QBCore.Shared.Items['cokebaggy'], "add")
		end
	end)

QBCore.Functions.CreateCallback('coke:process', function(source, cb)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	 
	if Player.PlayerData.item ~= nil and next(Player.PlayerData.items) ~= nil then
		for k, v in pairs(Player.PlayerData.items) do
		    if Player.Playerdata.items[k] ~= nil then
				if Player.Playerdata.items[k].name == "coke_brick" then
					cb(true)
			    else
					TriggerClientEvent("swt_notifications:Infos", src, "You do not have any coke bricks")
					cb(false)
				end
	        end
		end	
	end
end)

RegisterServerEvent("coke:GiveItem")
AddEventHandler("coke:GiveItem", function()
	local src = source
	  local Player = QBCore.Functions.GetPlayer(src)
	  local price = Config.price
	  local brick = Config.randBrick
	Player.Functions.AddMoney('cash', price)
	Player.Functions.AddItem('coke_brick', brick)
	TriggerClientEvent('nethush-inventory:client:ItemBox', src, QBCore.Shared.Items['coke_brick'], "add")
end)
