local NearNpc, CurrentNpc = false, nil

function SpawnNpcs()
    for k, v in pairs(Config.PedInteraction) do
        exports['nethush-assets']:RequestModelHash(v['Model'])
        NpcPed = CreatePed(4, v['Model'], v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'] - 0.95, v['Coords']['H'], false, false)
        FreezeEntityPosition(NpcPed, true)
        SetEntityInvincible(NpcPed, true)
        SetBlockingOfNonTemporaryEvents(NpcPed, true)
        SetPedConfigFlag(NpcPed, 410, true)
        if v['Animation'] ~= nil then
            TaskStartScenarioInPlace(NpcPed, v['Animation'], 0, true)
        end
        v['CurrentPedNumber'] = NpcPed
    end
end

function DespawnNpcs()
    for k, v in pairs(Config.PedInteraction) do
        DeleteEntity(v['CurrentPedNumber'])
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        if LoggedIn then
            NearNpc = false
            for k, v in pairs(Config.PedInteraction) do
                local PlayerCoords = GetEntityCoords(PlayerPedId())
                local Distance = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'], true)
                if Distance < 2 then
                    NearNpc, CurrentNpc = true, k
                end
            end
            if not NearNpc then
                Citizen.Wait(1500)
                CurrentNpc = nil
            end
        end
    end
end)

RegisterNetEvent('nethush-illegal:client:talk:to:npc')
AddEventHandler('nethush-illegal:client:talk:to:npc', function()
    Citizen.SetTimeout(150, function()
        PlayAmbientSpeech1(Config.PedInteraction[CurrentNpc]['CurrentPedNumber'], "GENERIC_HI", "SPEECH_PARAMS_FORCE_NORMAL")
        if Config.PedInteraction[CurrentNpc]['InteractAnimation'] ~= nil then
            exports['nethush-assets']:RequestAnimationDict(Config.PedInteraction[CurrentNpc]['InteractAnimation']['AnimDict'])
            TaskPlayAnim(PlayerPedId(), Config.PedInteraction[CurrentNpc]['InteractAnimation']['AnimDict'], Config.PedInteraction[CurrentNpc]['InteractAnimation']['AnimName'], 8.0, 1.0, 4500, 1, 0, 0, 0, 0)
            TaskPlayAnim(Config.PedInteraction[CurrentNpc]['CurrentPedNumber'], Config.PedInteraction[CurrentNpc]['InteractAnimation']['AnimDict'], Config.PedInteraction[CurrentNpc]['InteractAnimation']['AnimName'], 8.0, 1.0, 4500, 1, 0, 0, 0, 0)
            Citizen.Wait(4650)
            if Config.PedInteraction[CurrentNpc]['Animation'] ~= nil then
                TaskStartScenarioInPlace(Config.PedInteraction[CurrentNpc]['CurrentPedNumber'], Config.PedInteraction[CurrentNpc]['Animation'], 0, true)
            end 
        end
        if Config.PedInteraction[CurrentNpc]['Name'] == 'Tyrone' or Config.PedInteraction[CurrentNpc]['Name'] == 'Tyries' or Config.PedInteraction[CurrentNpc]['Name'] == 'Dodge' or Config.PedInteraction[CurrentNpc]['Name'] == 'Dwayne' or Config.PedInteraction[CurrentNpc]['Name'] == 'Meth' or Config.PedInteraction[CurrentNpc]['Name'] == 'Coke' or Config.PedInteraction[CurrentNpc]['Name'] == 'Achmed' or Config.PedInteraction[CurrentNpc]['Name'] == 'Richard' then
            local Shop = {label = Config.PedInteraction[CurrentNpc]['Name'], items = Config.PedInteraction[CurrentNpc]['Products'], slots = 5}
            TriggerServerEvent("nethush-inventory:server:OpenInventory", "shop", "StreetDealer_"..Config.PedInteraction[CurrentNpc]['Name'], Shop)
        elseif Config.PedInteraction[CurrentNpc]['Name'] == 'Locksmith' or Config.PedInteraction[CurrentNpc]['Name'] == 'Toolshop1' or Config.PedInteraction[CurrentNpc]['Name'] == 'Toolshop2' or Config.PedInteraction[CurrentNpc]['Name'] == 'Sea Store' or Config.PedInteraction[CurrentNpc]['Name'] == 'Bartender' then
            TriggerEvent('nethush-stores:server:open:shop')
        elseif Config.PedInteraction[CurrentNpc]['Name'] == 'Bank' then
            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
                if HasItem then
                 --   TriggerServerEvent('nethush-burgershot:server:sell:tickets')
                else
                  TriggerEvent("swt_notifications:Infos","You have no receipts..")
                end
            end, 'burger-ticket')
        elseif Config.PedInteraction[CurrentNpc]['Name'] == 'SellElectronics' then
            TriggerServerEvent('nethush-illegal:server:sell:electrnoics')
        end
    end)
end)