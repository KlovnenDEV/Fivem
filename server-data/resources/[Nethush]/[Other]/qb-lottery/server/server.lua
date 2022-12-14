QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateUseableItem("lotto-card", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
		local RandomNum = math.random(1,150)
		local Prijs = 0
		if RandomNum <= 10 then
			Prijs = 400
		elseif RandomNum >= 139 and RandomNum <= 141 then
			Prijs = 200
		elseif RandomNum >= 115 and RandomNum <= 119 then
			Prijs = 2000
		elseif RandomNum >= 71 and RandomNum <= 76 then
			Prijs = 1000
		elseif RandomNum >= 43 and RandomNum <= 51 then
			Prijs = 100
		elseif RandomNum == 56 then
			Prijs = 20000
		else
			Prijs = 0
		end
		if Prijs ~= 0 then
			local info = {
				card = Prijs
			}
			Player.Functions.AddItem("used-card", 1, false, info)
		end
		TriggerClientEvent("qb-lottery:client:open:card", source, math.random(11,99), Prijs) 
    end
end)

RegisterServerEvent('qb-lottery:server:sell:card')
AddEventHandler('qb-lottery:server:sell:card', function()
    local Player = QBCore.Functions.GetPlayer(source)
	local Item = Player.Functions.GetItemByName('used-card')
	if Item ~= nil then
		local WorthAmount = Item.info.card
		Player.Functions.RemoveItem('used-card', 1)
		Player.Functions.AddMoney('cash', WorthAmount, "used-card")
    	TriggerClientEvent('swt_notifications:Infos', source, 'Lottery cards check out worth: $' ..WorthAmount.. '.')
	else
		TriggerClientEvent('swt_notifications:Infos', source, 'You dont have any used lottery cards...')
	end
end)
