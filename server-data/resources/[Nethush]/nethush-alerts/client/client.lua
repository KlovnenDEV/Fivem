local isLoggedIn = false
local MouseActive = false
local AlertActive = false

QBCore = nil

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
 Citizen.SetTimeout(1250, function()
     TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
	 Citizen.Wait(250)
     isLoggedIn = true
 end)
end)

-- Code

RegisterNetEvent('nethush-alerts:client:send:alert')
AddEventHandler('nethush-alerts:client:send:alert', function(data, forBoth)
    if forBoth then
        if (QBCore.Functions.GetPlayerData().job.name == "police" or QBCore.Functions.GetPlayerData().job.name == "ambulance") and QBCore.Functions.GetPlayerData().job.onduty then
            data.callSign = data.callSign ~= nil and data.callSign or '69-69'
            data.alertId = math.random(11111, 99999)
            SendNUIMessage({
                action = "add",
                data = data,
            })
            if data.priority == 1 then
                TriggerServerEvent("nethush-sound:server:play:source", "alert-high-prio", 0.2)
            elseif data.priority == 2 then
             PlaySoundFrontend(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
              Citizen.Wait(100)
             PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
              Citizen.Wait(100)
             PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
              Citizen.Wait(100)
             PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
            elseif data.priority == 3 then
                TriggerServerEvent("nethush-sound:server:play:source", "alert-panic-button", 0.5)
            else
                PlaySoundFrontend(-1, "Lose_1st", "GTAO_FM_Events_Soundset", true)
            end
        end
    else 
        if (QBCore.Functions.GetPlayerData().job.name == "police" or QBCore.Functions.GetPlayerData().job.name == "ambulance" and QBCore.Functions.GetPlayerData().job.onduty) then
            data.callSign = data.callSign ~= nil and data.callSign or '69-69'
            data.alertId = math.random(11111, 99999)
            SendNUIMessage({
                action = "add",
                data = data,
            })
            if data.priority == 1 then
                TriggerServerEvent("nethush-sound:server:play:source", "alert-high-prio", 0.2)
            elseif data.priority == 2 then
             PlaySoundFrontend(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
              Citizen.Wait(100)
             PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
              Citizen.Wait(100)
             PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
              Citizen.Wait(100)
             PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
            elseif data.priority == 3 then
                TriggerServerEvent("nethush-sound:server:play:source", "alert-panic-button", 0.5)
            else
                PlaySoundFrontend(-1, "Lose_1st", "GTAO_FM_Events_Soundset", true)
            end
        end 
    end
    AlertActive = true
    SetTimeout(data.timeOut, function()
        AlertActive = false
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(6)
        if AlertActive then
            if IsControlJustPressed(0, Keys["LEFTALT"]) then
             if (QBCore.Functions.GetPlayerData().job.name == "police" or QBCore.Functions.GetPlayerData().job.name == "ambulance") and QBCore.Functions.GetPlayerData().job.onduty then
                SetNuiFocus(true, true)
                SetNuiFocusKeepInput(true, true)
                SetCursorLocation(0.965, 0.12)
                MouseActive = true
            end
        end
    end
        if MouseActive then
            if IsControlJustReleased(0, Keys["LEFTALT"]) then
             if (QBCore.Functions.GetPlayerData().job.name == "police" or QBCore.Functions.GetPlayerData().job.name == "ambulance") and QBCore.Functions.GetPlayerData().job.onduty then
                SetNuiFocus(false, false)
                SetNuiFocusKeepInput(false, false)
                MouseActive = false
            end
        end
    end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if MouseActive then
            DisableControlAction(0, 1, true)
            DisableControlAction(0, 2, true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 289, true)
            DisableControlAction(0, 288, true)
            DisableControlAction(0, 346, true)
            DisablePlayerFiring(PlayerPedId(), true)
        else
            Citizen.Wait(450)
        end
    end
end)

RegisterNUICallback('SetWaypoint', function(data)
    local coords = data.coords
    SetNewWaypoint(coords.x, coords.y)
    TriggerEvent('swt_notifications:Infos','GPS location set!')
end)