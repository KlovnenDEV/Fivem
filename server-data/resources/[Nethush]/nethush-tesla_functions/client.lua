--- START OF CONFIGURATION
local vehicles = "modelx,models,model3,modely,roadster,cybertruck,semi,foxct,tr22,foxctnp,teslapd,teslax" -- define what cars can be used as a tesla (by modelname), set to "" (empty) for all cars
local debug = false
--- END OF CONFIGURATION

local tesla = nil
local tesla_blip = nil
local tesla_pilot = false
local tesla_pilot_ped = nil
local tesla_dance = false

local pilot = false
local lines = false
local crash = false
local dance = false

RegisterNetEvent('nethush:client:teslablip')
AddEventHandler('nethush:client:teslablip', function()
	if(IsPedInAnyVehicle(GetPlayerPed(-1)) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) and (vehicles:find(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), false)))) or vehicles == "")) then
		tesla = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		SetEntityAsMissionEntity(tesla, true, true)
		TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-mark', 1.0)
		TriggerEvent("swt_notifications:Success","SLMC System",'Your Tesla is now marked.\nIt can be controlled when you are not sitting in it.',"top-right",5000,true)
		if(DoesBlipExist(tesla_blip)) then
			RemoveBlip(tesla_blip)
		end
		tesla_blip = AddBlipForEntity(tesla)
		SetBlipSprite(tesla_blip, 620)
		SetBlipColour(tesla_blip, 75)
		SetBlipAsShortRange(tesla_blip, false)
		BeginTextCommandSetBlipName("STRING")
		  AddTextComponentString("Tesla")
		EndTextCommandSetBlipName(tesla_blip)
	else
		tesla = nil
		TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-mark', 1.0)
		TriggerEvent("swt_notifications:Warning","SLMC System","Your Tesla has been unmarked.","top-right",5500,true)

		if(DoesBlipExist(tesla_blip)) then
			RemoveBlip(tesla_blip)
		end
		tesla_blip = nil
	end
end)

RegisterNetEvent('nethush:client:teslapilot')
AddEventHandler('nethush:client:teslapilot', function()
	if(IsPedInAnyVehicle(GetPlayerPed(-1), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) and (vehicles:find(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), false)))) or vehicles == "")) then
		waypoint = Citizen.InvokeNative(0xFA7C7F0AADF25D09, GetFirstBlipInfoId(8), Citizen.ResultAsVector())
		if(IsWaypointActive()) then
			if(pilot) then
				pilot = false
				TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-autopilot-stop', 1.0)
				TriggerEvent('TrewHudUI_CL:DisableAutopilot')
				TriggerEvent("swt_notifications:Warning","SLMC System","Autopilot canceled.","top-right",5500,true)

				ClearPedTasks(GetPlayerPed(-1))
			else
				if(crash) then
					crash = false
					TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-cancel', 1.0)
					TriggerEvent("swt_notifications:Negative","SLMC System",'Crash avoidance deactivated.',"top-right",5500,true)

				end
				pilot = true
				TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-autopilot-start', 1.0)
				TriggerEvent('TrewHudUI_CL:EnableAutopilot')
				TriggerEvent("swt_notifications:Success","SLMC System",'Autopilot activated..',"top-right",5000,true)

				TaskVehicleDriveToCoord(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), 0), waypoint["x"], waypoint["y"], waypoint["z"], 100.0, 1.0, GetHashKey(GetVehiclePedIsIn(GetPlayerPed(-1), 0)), 1074528293, 1.0, 1)
				Citizen.CreateThread(function()
					while pilot do
						Wait(100)
						if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1))["x"], GetEntityCoords(GetPlayerPed(-1))["y"], GetEntityCoords(GetPlayerPed(-1))["z"], waypoint["x"], waypoint["y"], waypoint["z"], 0) < 10.0) then
							while GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), 0)) - 1.0 > 0.0 do
								SetVehicleForwardSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), 0), GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), 0)) - 1.0)
								Wait(100)
							end
							pilot = false
							ClearPedTasks(GetPlayerPed(-1))
							TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-autopilot-stop', 1.0)
							TriggerEvent("swt_notifications:Negative","SLMC System",'Autopilot deactivated.',"top-right",5500,true)

						end
						if(IsControlPressed(27, 63) or IsControlPressed(27, 64) or IsControlPressed(27, 71) or IsControlPressed(27, 72) or IsControlPressed(27, 76)) then
							pilot = false
							ClearPedTasks(GetPlayerPed(-1))
							TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-autopilot-stop', 1.0)
							TriggerEvent('TrewHudUI_CL:DisableAutopilot')
							TriggerEvent("swt_notifications:Negative","SLMC System",'Autopilot deactivated.',"top-right",5500,true)
						end
					end
				end)
			end
		else
			TriggerEvent("swt_notifications:Negative","SLMC System",'No waypoint set.',"top-right",5500,true)

		end
	elseif(tesla) then
			if(tesla_pilot) then
				if(tesla_pilot_ped) then
					--DeletePed(tesla_pilot_ped)
					RemovePedElegantly(tesla_pilot_ped)
				end
				local playerPed = PlayerPedId()
				tesla_pilot = false
				tesla_pilot_ped = nil
				SetVehicleEngineOn(tesla, false, false, false)
				TriggerEvent("swt_notifications:Warning","SLMC System","Autopilot canceled.","top-right",5500,true)
				ClearPedTasks(playerPed)
			else
				local playerPed = PlayerPedId()
				RequestModel(225514697)
				while not HasModelLoaded(225514697) do
					Wait(5)
				end
				TriggerEvent("swt_notifications:Success","SLMC System",'Autopilot activated..',"top-right",5000,true)
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_STAND_MOBILE', 0, true)
				tesla_pilot = true
				tesla_pilot_ped = CreatePed(0, 225514697, GetEntityCoords(tesla)["x"], GetEntityCoords(tesla)["y"], GetEntityCoords(tesla)["z"], 0.0, false, true)
				SetEntityAsMissionEntity(tesla_pilot_ped, true, true)
				SetPedIntoVehicle(tesla_pilot_ped, tesla, -1)
				SetEntityInvincible(tesla_pilot_ped, true)
				SetEntityVisible(tesla_pilot_ped, false, 0)
				player_coords = GetEntityCoords(GetPlayerPed(-1))
				TaskVehicleDriveToCoord(tesla_pilot_ped, tesla, player_coords.x, player_coords.y, player_coords.z, 100.0, 1.0, GetHashKey(tesla), 1074528293, 1.0, 1)
				Citizen.CreateThread(function()
					while tesla_pilot do
						--TaskPlayPhoneGestureAnimation(GetPlayerPed(playerIdx), v_3, v_2, v_4, 0.25, 0.25, 0, 0)
						Wait(100)
						if(GetDistanceBetweenCoords(GetEntityCoords(tesla)["x"], GetEntityCoords(tesla)["y"], GetEntityCoords(tesla)["z"], player_coords.x, player_coords.y, player_coords.z, 0) < 10.0) then
							while GetEntitySpeed(tesla) - 1.0 > 0.0 do
								SetVehicleForwardSpeed(tesla, GetEntitySpeed(tesla) - 1.0)
								Wait(100)
							end
							tesla_pilot = false
							--DeletePed(tesla_pilot_ped)
							RemovePedElegantly(tesla_pilot_ped)
							tesla_pilot_ped = nil
							SetVehicleEngineOn(tesla, false, false, false)
							TriggerEvent("swt_notifications:Negative","SLMC System",'Autopilot deactivated.',"top-right",5500,true)
							ClearPedTasks(playerPed)
						end
					end
				end)
			end
	else
		TriggerEvent("swt_notifications:Negative","SLMC System",'Only available in a Tesla..',"top-right",5500,true)

	end	
end)		


RegisterNetEvent('nethush:client:teslacrash')
AddEventHandler('nethush:client:teslacrash', function()	
	if(IsPedInAnyVehicle(GetPlayerPed(-1), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) and (vehicles:find(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), false)))) or vehicles == "")) then
		if(crash) then
			crash = false
			TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-cancel', 1.0)
			TriggerEvent("swt_notifications:Negative","SLMC System",'Crash avoidance deactivated.',"top-right",5500,true)
		elseif(pilot) then
			pilot = false
			ClearPedTasks(GetPlayerPed(-1))
			TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-autopilot-stop', 1.0)
			TriggerEvent('TrewHudUI_CL:DisableAutopilot')
			TriggerEvent("swt_notifications:Negative","SLMC System",'Autopilot deactivated.',"top-right",5500,true)
			crash = true
			TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-cancel', 1.0)
			TriggerEvent("swt_notifications:Success","SLMC System",'Crash avoidance activated..',"top-right",5000,true)

		else
			RequestModel(225514697)
			while not HasModelLoaded(225514697) do
				Wait(5)
			end
			crash = true
			TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-cancel', 1.0)
			TriggerEvent("swt_notifications:Success","SLMC System",'Crash avoidance activated..',"top-right",5000,true)
			Citizen.CreateThread(function()
				while crash do
					Wait(5)
					if(IsPedInAnyVehicle(GetPlayerPed(-1), false)) then
						if(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) < 0.2) then -- standing
							if(debug) then
								DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).z, 255, 50, 50, 1.0, 10.0)
								DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).z, 255, 50, 50, 1.0, 10.0)
								DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).z, 255, 50, 50, 1.0, 10.0)
								DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).z, 255, 50, 50, 1.0, 10.0)
								DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).z, 255, 50, 50, 1.0, 10.0)
							end
							if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).z, 1.5, false) or IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).z, 1.5, false)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 23, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
							if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).z, 1.5)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 22, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
							if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).z, 1.5)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 14, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
							if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).z, 1.5)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 13, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
							if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).z, 1.5) or IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).z, 1.5)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 23, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
							if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).z, 1.5)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 22, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
							if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).z, 1.5)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 14, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
							if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).z, 1.5)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 13, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
						elseif(GetVehicleCurrentGear(GetVehiclePedIsIn(GetPlayerPed(-1), false)) == 0) then -- reverse
							if(debug) then
								DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 4.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 4.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 4.5, 0.0).z, 255, 50, 50, 1.0, 10.0)
								DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 3.5, 0.0).z, 255, 50, 50, 1.0, 10.0)
								DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 3.5, 0.0).z, 255, 50, 50, 1.0, 10.0)
							end
							if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 4.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 4.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 4.5, 0.0).z, 1.5, false)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 22, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
							if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 3.5, 0.0).z, 1.5, false)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 14, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
							if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 3.5, 0.0).z, 1.5, false)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 13, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
							if(IsAnyPedNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 4.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 4.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 4.5, 0.0).z, 1.5)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 22, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
							if(IsAnyPedNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 3.5, 0.0).z, 1.5)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 14, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
							if(IsAnyPedNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 3.5, 0.0).z, 1.5)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 13, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
							if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 4.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 4.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 4.5, 0.0).z, 1.5)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 22, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
							if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 3.5, 0.0).z, 1.5)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 14, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
							if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 3.5, 0.0).z, 1.5)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 13, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
							if(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) < 4.0) then
								if(debug) then
									DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).z, 255, 50, 50, 1.0, 10.0)
									DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).z, 255, 50, 50, 1.0, 10.0)
								end
								if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).z, 1.5, false) or IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).z, 1.5, false)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 27, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyPedNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).z, 1.5) or IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 27, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -3.5, 0.0).z, 1.5) or IsAnyPedNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -3.5, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 27, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
							elseif(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) > 12.0) then
								if(debug) then
									DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -13.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -13.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -13.0, 0.0).z, 255, 50, 50, 1.0, 10.0)
									DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -13.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -13.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -13.0, 0.0).z, 255, 50, 50, 1.0, 10.0)
								end
								if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -13.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -13.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -13.0, 0.0).z, 1.5, false) or IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -13.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -13.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -13.0, 0.0).z, 1.5, false)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 27, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyPedNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -13.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -13.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -13.0, 0.0).z, 1.5) or IsAnyPedNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -13.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -13.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -13.0, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 27, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -13.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -13.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -13.0, 0.0).z, 1.5) or IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -13.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -13.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -13.0, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 27, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
							else
								if(debug) then
									DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).z, 255, 50, 50, 1.0, 10.0)
									DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).z, 255, 50, 50, 1.0, 10.0)
								end
								if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).z, 1.5, false) or IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).z, 1.5, false)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 27, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyPedNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).z, 1.5) or IsAnyPedNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 27, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).z, 1.5) or IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 27, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
							end
						else -- normal
							if(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) < 4.0) then
								if(debug) then
									DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).z, 255, 50, 50, 1.0, 10.0)
									DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).z, 255, 50, 50, 1.0, 10.0)
									DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).z, 255, 50, 50, 1.0, 10.0)
								end
								if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).z, 1.5, false)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 22, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).z, 1.5, false)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).z, 1.5, false)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 5, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyPedNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 22, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyPedNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyPedNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 5, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 3.5, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 22, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 2.5, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 2.5, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 5, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
							elseif(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) > 25.0) then
								if(debug) then
									DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 26.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 26.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 26.0, 0.0).z, 255, 50, 50, 1.0, 10.0)
									DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 25.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 25.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 25.0, 0.0).z, 255, 50, 50, 1.0, 10.0)
									DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 25.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 25.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 25.0, 0.0).z, 255, 50, 50, 1.0, 10.0)
								end
								if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 26.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 26.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 26.0, 0.0).z, 1.5, false)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 22, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 25.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 25.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 25.0, 0.0).z, 1.5, false)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 25.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 25.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 25.0, 0.0).z, 1.5, false)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 5, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyPedNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 26.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 26.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 26.0, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 22, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyPedNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 25.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 25.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 25.0, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyPedNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 25.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 25.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 25.0, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 5, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 26.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 26.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, 26.0, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 22, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 25.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 25.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, 25.0, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 25.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 25.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, 25.0, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 5, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
							else
								if(debug) then
									DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).z, 255, 50, 50, 1.0, 10.0)
									DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).z, 255, 50, 50, 1.0, 10.0)
									DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).z, 255, 50, 50, 1.0, 10.0)
								end
								if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).z, 1.5, false)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 22, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).z, 1.5, false)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).z, 1.5, false)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 5, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyPedNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 22, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyPedNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyPedNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 5, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)), 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 22, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
								if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -2.0, GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) - 1.0, 0.0).z, 1.5)) then
									TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 5, 200)
									TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
								end
							end
							if(debug) then
								DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -4.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -4.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -4.5, 0.0).z, 255, 50, 50, 1.0, 10.0)
								DrawLightWithRange(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -4.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -4.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -4.5, 0.0).z, 255, 50, 50, 1.0, 10.0)
							end
							if(IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -4.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -4.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -4.5, 0.0).z, 1.5, false) or IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -4.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -4.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -4.5, 0.0).z, 1.5, false)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 9, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
							if(IsAnyPedNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -4.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -4.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -4.5, 0.0).z, 1.5, false) or IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -4.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -4.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -4.5, 0.0).z, 1.5)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 9, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
							if(IsAnyVehicleNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -4.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -4.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -4.5, 0.0).z, 1.5, false) or IsAnyObjectNearPoint(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -4.5, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -4.5, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -4.5, 0.0).z, 1.5)) then
								TaskVehicleTempAction(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 9, 200)
								TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-detect', 1.0)
							end
						end
						if(HasEntityBeenDamagedByAnyObject(GetVehiclePedIsIn(GetPlayerPed(-1), false)) or HasEntityBeenDamagedByAnyVehicle(GetVehiclePedIsIn(GetPlayerPed(-1), false))) then
							crash = false
							TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-cancel', 1.0)
							TriggerEvent("swt_notifications:Warning","SLMC System","Crash Avoidance canceled.","top-right",5500,true)

							ClearEntityLastDamageEntity(GetVehiclePedIsIn(GetPlayerPed(-1), false))
						end
					else
						crash = false
						TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-crash-avoidance-cancel', 1.0)
						TriggerEvent("swt_notifications:Negative","SLMC System",'Crash avoidance deactivated.',"top-right",5500,true)
					end
				end
			end)
		end
    else
		TriggerEvent("swt_notifications:Negative","SLMC System",'Only available in a Tesla..',"top-right",5500,true)

	end
end)


RegisterNetEvent('nethush:client:tesladance')
AddEventHandler('nethush:client:tesladance', function()	
    if(IsPedInAnyVehicle(GetPlayerPed(-1), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) and (vehicles:find(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), false)))) or vehicles == "")) then
		if(dance) then
			dance = false
			SetVehicleDoorsShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
			TriggerEvent('PlaylollySounds_CL:PlayOnOne', '', 1.0)
			TriggerEvent("swt_notifications:Warning","SLMC System","Dance mode stopped.","top-right",5500,true)


			for i = 0, 6 do
				SetVehicleDoorShut(tesla, i, false) -- will close all doors from 0-6
			end
		else
			dance = true
			TriggerEvent('PlaylollySounds_CL:PlayOnOne', 'tesla-dance', 1.0)
			TriggerEvent("swt_notifications:Success","SLMC System",'Dance mode started...',"top-right",5000,true)

			Citizen.CreateThread(function()
				SetVehRadioStation(GetVehiclePedIsIn(GetPlayerPed(-1), false), 'OFF')
				while dance do
					Wait(100)
					SetVehicleDoorOpen(GetVehiclePedIsIn(GetPlayerPed(-1), false), math.random(0, 6), false, false)
					SetVehicleDoorShut(GetVehiclePedIsIn(GetPlayerPed(-1), false), math.random(0, 6), false)
				end
			end)
		end
	else
		TriggerEvent("swt_notifications:Negative","SLMC System",'Only available in a Tesla..',"top-right",5500,true)
	end
	
end)


RegisterNetEvent('nethush:client:teslalines')
AddEventHandler('nethush:client:teslalines', function()	
	if(IsPedInAnyVehicle(GetPlayerPed(-1), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) and (vehicles:find(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), false)))) or vehicles == "")) then
		if(lines) then
			TriggerEvent("swt_notifications:Negative","SLMC System",'Reverse lines deactivated..',"top-right",5500,true)

			lines = false
		else
			TriggerEvent("swt_notifications:Success","SLMC System",'Reverse lines activated....',"top-right",5000,true)

			lines = true
			Citizen.CreateThread(function()
				while lines do
					Wait(5)
					if(IsPedInAnyVehicle(GetPlayerPed(-1)) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1)) then
						if(GetVehicleCurrentGear(GetVehiclePedIsIn(GetPlayerPed(-1), false)) == 0) then
							DrawLine(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -2.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -2.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0, -2.0, 0.0).z, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0 - (GetVehicleSteeringAngle(GetVehiclePedIsIn(GetPlayerPed(-1), false)) / GetVehicleHandlingFloat(GetVehiclePedIsIn(GetPlayerPed(-1), false), "CHandlingData", "fSteeringLock")), -6.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0 - (GetVehicleSteeringAngle(GetVehiclePedIsIn(GetPlayerPed(-1), false)) / GetVehicleHandlingFloat(GetVehiclePedIsIn(GetPlayerPed(-1), false), "CHandlingData", "fSteeringLock")), -6.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0 - (GetVehicleSteeringAngle(GetVehiclePedIsIn(GetPlayerPed(-1), false)) / GetVehicleHandlingFloat(GetVehiclePedIsIn(GetPlayerPed(-1), false), "CHandlingData", "fSteeringLock")), -6.0, 0.0).z, 255, 255, 255, 255)
							DrawLine(GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -2.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -2.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0, -2.0, 0.0).z, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0 - (GetVehicleSteeringAngle(GetVehiclePedIsIn(GetPlayerPed(-1), false)) / GetVehicleHandlingFloat(GetVehiclePedIsIn(GetPlayerPed(-1), false), "CHandlingData", "fSteeringLock")), -6.0, 0.0).x, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0 - (GetVehicleSteeringAngle(GetVehiclePedIsIn(GetPlayerPed(-1), false)) / GetVehicleHandlingFloat(GetVehiclePedIsIn(GetPlayerPed(-1), false), "CHandlingData", "fSteeringLock")), -6.0, 0.0).y, GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1.0 - (GetVehicleSteeringAngle(GetVehiclePedIsIn(GetPlayerPed(-1), false)) / GetVehicleHandlingFloat(GetVehiclePedIsIn(GetPlayerPed(-1), false), "CHandlingData", "fSteeringLock")), -6.0, 0.0).z, 255, 255, 255, 255)
						end
					else
						lines = false
					end
				end
			end)
		end
	else
		TriggerEvent("swt_notifications:Negative","SLMC System",'Only available in a Tesla..',"top-right",5500,true)
	end
end)
