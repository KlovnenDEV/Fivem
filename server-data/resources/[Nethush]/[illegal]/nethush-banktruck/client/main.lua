QBCore = nil

local CurrentCops = 0

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
  Citizen.SetTimeout(1000, function()
      TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
      Citizen.Wait(150)
      QBCore.Functions.TriggerCallback('qb-banktruck:server:GetConfig', function(config)
          config = Config
      end)
  end)
end)

RegisterNetEvent('qb-police:SetCopCount')
AddEventHandler('qb-police:SetCopCount', function(Amount)
    CurrentCops = Amount
end)

-- Code

RegisterNetEvent('qb-truckrob:client:UseCard')
AddEventHandler('qb-truckrob:client:UseCard', function()
local Vehicle = QBCore.Functions.GetClosestVehicle()
local model = GetDisplayNameFromVehicleModel(GetEntityModel(Vehicle))
local PedPos = GetEntityCoords(PlayerPedId())
local GetTruckCoords = GetOffsetFromEntityInWorldCoords(Vehicle, 0.0, -2.0, 1.0)
local TruckDist = GetDistanceBetweenCoords(PedPos.x, PedPos.y, PedPos.z, GetTruckCoords.x, GetTruckCoords.y, GetTruckCoords.z, true)
local Plate = GetVehicleNumberPlateText(Vehicle)
if TruckDist <= 5.0 then
    if model:lower() == 'stockade' then
        if CurrentCops >= Config.PoliceNeeded then
          if not Config.RobbedPlates[Plate] then
            local StreetLabel = QBCore.Functions.GetStreetLabel()
            TriggerEvent('nethush-inventory:client:set:busy', true)
            TriggerServerEvent('qb-police:server:send:banktruck:alert', GetEntityCoords(PlayerPedId()), Plate, StreetLabel)
            StartRobbingVan(Vehicle)
           else
            TriggerEvent("swt_notifications:Infos","This truck has been recently robbed..")
            end
        else
            TriggerEvent("swt_notifications:Infos","Not enough police.. (0 required)")
        end
          else
              TriggerEvent("swt_notifications:Infos","This is not a bank truck smartass..")
          end
      else
          TriggerEvent("swt_notifications:Infos","No trucks nearby..")
    end
end)

RegisterNetEvent('qb-banktruck:plate:table')
AddEventHandler('qb-banktruck:plate:table', function(Plate)
    Config.RobbedPlates[Plate] = true
end)

function StartRobbingVan(Veh)
    IsRobbing = true
    local TimeSearch = math.random(25000, 55000)
    local Coords = GetEntityCoords(Veh)
    local PedPos = GetEntityCoords(PlayerPedId())
    if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
        local pos = GetEntityCoords(GetPlayerPed(-1))
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
    end
    SearchAnim()
    QBCore.Functions.Progressbar("open_locker", "Validating card..", math.random(25000, 50000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        IsRobbing = false
        local Plate = GetVehicleNumberPlateText(Veh)
        TriggerServerEvent('qb-bankrob:server:remove:card')
        TriggerEvent('nethush-inventory:client:set:busy', false)
        TriggerServerEvent('qb-banktruck:server:OpenTruck', Veh)
        TriggerServerEvent('qb-banktruck:server:set:truckamount', 'Count-Minus', 1)
        StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
        TriggerEvent("swt_notifications:Infos","Success!")
    end, function() -- Cancel
        IsRobbing = false
        TriggerEvent('nethush-inventory:client:set:busy', false)
        StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
        TriggerEvent("swt_notifications:Infos","Canceled..")
    end)
    Citizen.CreateThread(function()
        while IsRobbing do
            TriggerServerEvent('qb-hud:Server:GainStress', math.random(2, 3))
            Citizen.Wait(12000)
        end
    end)
end

function SearchAnim()
    exports['nethush-assets']:RequestAnimationDict("anim@gangops@facility@servers@")
    TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire" ,3.0, 3.0, -1, 16, 0, false, false, false)
    Citizen.CreateThread(function()
        while IsRobbing do
            TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Citizen.Wait(1000)
        end
   end)
end

RegisterNetEvent('qb-banktruck:client:OpenTruck')
AddEventHandler('qb-banktruck:client:OpenTruck', function(Veh)
    local Plate = GetVehicleNumberPlateText(Veh)
    RequestModel("s_m_m_strpreach_01")
    while not HasModelLoaded("s_m_m_strpreach_01") do
        Wait(10)
    end
    SetVehicleUndriveable(Veh, true)
    SetVehicleEngineHealth(Veh, 100.0)
    SetVehicleBodyHealth(Veh, 100.0)
    SetEntityAsNoLongerNeeded(Veh)
    for i = -1, 4 do
    Citizen.Wait(1) 
    local Yew = CreatePedInsideVehicle(Veh, 5, "s_m_m_strpreach_01", i, 1, 1)
    SetPedShootRate(Yew, 750)
    SetPedCombatAttributes(Yew, 46, true)
    SetPedFleeAttributes(Yew, 0, 0)
    SetPedAsEnemy(Yew,true)
    SetPedArmour(Yew, 200.0)
    SetPedMaxHealth(Yew, 900.0)
    SetPedAlertness(Yew, 3)
    SetPedCombatRange(Yew, 0)
    SetPedCombatMovement(Yew, 3)
    TaskCombatPed(Yew, PlayerPedId(), 0,16)
    TaskLeaveVehicle(Yew, Veh, 0)
    GiveWeaponToPed(Yew, GetHashKey("WEAPON_SMG"), 5000, true, true)
    SetPedRelationshipGroupHash(Yew, GetHashKey("HATES_PLAYER"))
    end
    SetVehicleDoorOpen(Veh, 6, false, true)
    SetVehicleDoorOpen(Veh, 7, false, true)
    RobbingVan = true
    Citizen.CreateThread(function()
        while RobbingVan do
            Citizen.Wait(5)
            local PedPos = GetEntityCoords(PlayerPedId())
            local GetTruckCoords = GetOffsetFromEntityInWorldCoords(Veh, 0.0, -3.5, 0.5)
            local TruckDist = GetDistanceBetweenCoords(PedPos.x, PedPos.y, PedPos.z, GetTruckCoords.x, GetTruckCoords.y, GetTruckCoords.z, true)
            if TruckDist <= 4.2 then
            if not Config.RobbedPlates[Plate] then
             DrawText3D(GetTruckCoords.x, GetTruckCoords.y, GetTruckCoords.z, '~g~E~s~ - Steal goods')
             DrawMarker(2, GetTruckCoords.x, GetTruckCoords.y, GetTruckCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
             if IsControlJustPressed(0, 38) then
                TriggerServerEvent('qb-banktruck:server:updateplates', Plate)
                RobbingVan = false
                KankerJanken()
             end
            end
          end
        end
    end)
end)

function KankerJanken()
    LeegTrekken = true
    if math.random(1, 100) <= 85 and not IsWearingHandshoes() then
        local pos = GetEntityCoords(GetPlayerPed(-1))
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
    end
    QBCore.Functions.Progressbar("open_locker", "Stealing goods..", math.random(34000, 58000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@heists@ornate_bank@grab_cash_heels",
        anim = "grab",
        flags = 16,
    }, {
       model = "prop_cs_heist_bag_02",
       bone = 57005,
       coords = { x = -0.005, y = 0.00, z = -0.16 },
       rotation = { x = 250.0, y = -30.0, z = 0.0 },
    }, {}, function() -- Done
        LeegTrekken = false
        StopAnimTask(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 1.0)
        TriggerEvent("swt_notifications:Infos","Success!")
    end, function() -- Cancel
        LeegTrekken = false
        StopAnimTask(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 1.0)
        TriggerEvent("swt_notifications:Infos","Canceled..")
    end)
    Citizen.CreateThread(function()
        while LeegTrekken do
            -- Als je dit triggert zie ik dat je cheat kanker nerd.
            TriggerServerEvent('blijf:uit:mijn:scripts:rewards')
            Citizen.Wait(6500)
        end
    end)
    Citizen.CreateThread(function()
        while LeegTrekken do
            TriggerServerEvent('qb-hud:Server:GainStress', math.random(2, 3))
            Citizen.Wait(12000)
        end
    end)
end

function DrawText3D(x, y, z, text)
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(true)
  AddTextComponentString(text)
  SetDrawOrigin(x,y,z, 0)
  DrawText(0.0, 0.0)
  local factor = (string.len(text)) / 370
  DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
  ClearDrawOrigin()
end

function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == GetHashKey("mp_m_freemode_01") then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end