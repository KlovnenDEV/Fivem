QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('RoutePizza:Payment')
AddEventHandler('RoutePizza:Payment', function()
	local _source = source
	local Player = QBCore.Functions.GetPlayer(_source)
    Player.Functions.AddMoney("cash", 1000, "sold-pizza")
    TriggerClientEvent("swt_notifications:Infos", _source, "You recieved $100")
end)

RegisterServerEvent('RoutePizza:TakeDeposit')
AddEventHandler('RoutePizza:TakeDeposit', function()
	local _source = source
	local Player = QBCore.Functions.GetPlayer(_source)
    Player.Functions.RemoveMoney("bank", _source, "pizza-deposit")
    TriggerClientEvent("swt_notifications:Infos", _source, "You were charged a deposit of $100")
end)

RegisterServerEvent('RoutePizza:ReturnDeposit')
AddEventHandler('RoutePizza:ReturnDeposit', function(info)
	local _source = source
    local Player = QBCore.Functions.GetPlayer(_source)
    
    if info == 'cancel' then
        Player.Functions.AddMoney("cash", 500, "pizza-return-vehicle")
        TriggerClientEvent("swt_notifications:Infos", _source, "You returned the vehicle and recieved your deposit back")
    elseif info == 'end' then
        Player.Functions.AddMoney("cash", 3500, "pizza-return-vehicle")
        TriggerClientEvent("swt_notifications:Infos", _source, "You returned the vehicle and recieved your deposit back")
    end
end)
