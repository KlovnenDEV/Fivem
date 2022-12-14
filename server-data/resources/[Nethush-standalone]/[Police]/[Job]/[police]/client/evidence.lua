local GunShotAlert = false



StatusList = {
	["fight"] = "Save hands ",
	["widepupils"] = "dilated pupils",
	["redeyes"] = "Red eye",
	["weedsmell"] = "Smells like weed",
	["alcohol"] = "Breath smells like alcohol",
	["gunpowder"] = "Gunpowder in clothing",
	["chemicals"] = "Smells chemical",
	["heavybreath"] = "Breathe heavily",
	["sweat"] = "Sweat very much",     
	["handbleed"] = "Blood on hands",
	["confused"] = "Confused",
	["alcohol"] = "Smells like alcohol",
	["heavyalcohol"] = "Smells a lot of alcohol",
}

CurrentStatusList = {}
Casings = {}
CasingsNear = {}
CurrentCasing = nil
Blooddrops = {}
BlooddropsNear = {}
CurrentBlooddrop = nil
Fingerprints = {}
FingerprintsNear = {}
CurrentFingerprint = 0

RegisterNetEvent('evidence:client:SetStatus')
AddEventHandler('evidence:client:SetStatus', function(statusId, time)
	if time > 0 and StatusList[statusId] ~= nil then 
		if (CurrentStatusList == nil or CurrentStatusList[statusId] == nil) or (CurrentStatusList[statusId] ~= nil and CurrentStatusList[statusId].time < 20) then
			CurrentStatusList[statusId] = {text = StatusList[statusId], time = time}
			TriggerEvent("chatMessage", "STATUS", "warning", CurrentStatusList[statusId].text)
		end
	elseif StatusList[statusId] ~= nil then
		CurrentStatusList[statusId] = nil
	end
	TriggerServerEvent("evidence:server:UpdateStatus", CurrentStatusList)
end)

RegisterNetEvent('evidence:client:AddBlooddrop')
AddEventHandler('evidence:client:AddBlooddrop', function(bloodId, citizenid, bloodtype, coords)
    Blooddrops[bloodId] = {
		citizenid = citizenid,
		bloodtype = bloodtype,
		coords = {
			x = coords.x,
			y = coords.y, 
			z = coords.z - 0.9,
		}
	}
end)

RegisterNetEvent("evidence:client:RemoveBlooddrop")
AddEventHandler("evidence:client:RemoveBlooddrop", function(bloodId)
	Blooddrops[bloodId] = nil
	BlooddropsNear[bloodId] = nil
    CurrentBlooddrop = 0
end)

RegisterNetEvent('evidence:client:AddFingerPrint')
AddEventHandler('evidence:client:AddFingerPrint', function(fingerId, fingerprint, coords)
    Fingerprints[fingerId] = {
		fingerprint = fingerprint,
		coords = {
			x = coords.x,
			y = coords.y, 
			z = coords.z - 0.9,
		}
	}
end)

RegisterNetEvent("evidence:client:RemoveFingerprint")
AddEventHandler("evidence:client:RemoveFingerprint", function(fingerId)
	Fingerprints[fingerId] = nil
	FingerprintsNear[fingerId] = nil
    CurrentFingerprint = 0
end)

RegisterNetEvent("evidence:client:ClearBlooddropsInArea")
AddEventHandler("evidence:client:ClearBlooddropsInArea", function()
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local blooddropList = {}
	QBCore.Functions.Progressbar("clear_blooddrops", "Take away blood..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		if Blooddrops ~= nil and next(Blooddrops) ~= nil then 
			for bloodId, v in pairs(Blooddrops) do
				if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Blooddrops[bloodId].coords.x, Blooddrops[bloodId].coords.y, Blooddrops[bloodId].coords.z, true) < 10.0 then
					table.insert(blooddropList, bloodId)
				end
			end
			TriggerServerEvent("evidence:server:ClearBlooddrops", blooddropList)
			TriggerEvent("swt_notifications:Infos","Blood taken away :)")
		end
    end, function() -- Cancel
        TriggerEvent("swt_notifications:Infos","Blood not taken away")
    end)
end)

RegisterNetEvent('evidence:client:AddCasing')
AddEventHandler('evidence:client:AddCasing', function(casingId, weapon, coords, serie)
    Casings[casingId] = {
		type = weapon,
		serie = serie ~= nil and serie or "Serial number not visible..",
		coords = {
			x = coords.x,
			y = coords.y, 
			z = coords.z - 0.9,
		}
	}
end)

RegisterNetEvent("evidence:client:RemoveCasing")
AddEventHandler("evidence:client:RemoveCasing", function(casingId)
	Casings[casingId] = nil
	CasingsNear[casingId] = nil
    CurrentCasing = 0
end)

RegisterNetEvent("evidence:client:ClearCasingsInArea")
AddEventHandler("evidence:client:ClearCasingsInArea", function()
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local casingList = {}
	QBCore.Functions.Progressbar("clear_casings", "Remove the ball sleeves..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		if Casings ~= nil and next(Casings) ~= nil then 
			for casingId, v in pairs(Casings) do
				if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Casings[casingId].coords.x, Casings[casingId].coords.y, Casings[casingId].coords.z, true) < 10.0 then
					table.insert(casingList, casingId)
				end
			end
			TriggerServerEvent("evidence:server:ClearCasings", casingList)
			TriggerEvent("swt_notifications:Infos","Bullet sleeves removed :)")
		end
    end, function() -- Cancel
        TriggerEvent("swt_notifications:Infos","Ball sleeves not removed")
    end)
end)

local shotAmount = 0

--[[
	Decrease time of every status every 10 seconds
]]
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		if isLoggedIn then
			if CurrentStatusList ~= nil and next(CurrentStatusList) ~= nil then
				for k, v in pairs(CurrentStatusList) do
					if CurrentStatusList[k].time > 0 then
						CurrentStatusList[k].time = CurrentStatusList[k].time - 10
					else
						CurrentStatusList[k].time = 0
					end
				end
				TriggerServerEvent("evidence:server:UpdateStatus", CurrentStatusList)
			end
			if shotAmount > 0 then
				shotAmount = 0
			end
		end
	end
end)

--[[
	Gunpowder Status when shooting
]]
--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsPedShooting(PlayerPedId()) then
			if QBCore.Functions.GetPlayerData().job.name ~= "police" then
			   local Weapon = GetSelectedPedWeapon(PlayerPedId())
			   local SilentWeapon = IsWeaponSilent(Weapon)
			   local GunCategory = GetWeaponCategory(Weapon)
			   if not SilentWeapon then
				 if not GunShotAlert then
					   GunShotAlert = true
					 TriggerServerEvent('qb-hud:Server:GainStress', math.random(1, 4))							
					   TriggerServerEvent('qb-police:server:send:alert:gunshots', GetEntityCoords(PlayerPedId()), GunCategory, QBCore.Functions.GetStreetLabel(), IsPedInAnyVehicle(PlayerPedId()))
					   Citizen.SetTimeout(20000, function()
							GunShotAlert = false
				        end)
				 end
			 end
		   end
	 end
	end
end)]]

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		if CurrentCasing ~= nil and CurrentCasing ~= 0 then 
			local pos = GetEntityCoords(GetPlayerPed(-1))
			if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Casings[CurrentCasing].coords.x, Casings[CurrentCasing].coords.y, Casings[CurrentCasing].coords.z, true) < 1.5 then
				DrawText3D(Casings[CurrentCasing].coords.x, Casings[CurrentCasing].coords.y, Casings[CurrentCasing].coords.z, "~g~G~w~ - Kogelhuls ~b~#"..Casings[CurrentCasing].type)
				if IsControlJustReleased(0, Keys["G"]) then
					local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, Casings[CurrentCasing].coords.x, Casings[CurrentCasing].coords.y, Casings[CurrentCasing].coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
					local street1 = GetStreetNameFromHashKey(s1)
					local street2 = GetStreetNameFromHashKey(s2)
					local streetLabel = street1
					if street2 ~= nil then
						streetLabel = streetLabel .. " | " .. street2
					end
					local info = {
						label = "Kogelhuls",
						type = "casing",
						street = streetLabel:gsub("%'", ""),
						ammolabel = Config.AmmoLabels[QBCore.Shared.Weapons[Casings[CurrentCasing].type]["ammotype"]],
						ammotype = Casings[CurrentCasing].type,
						serie = Casings[CurrentCasing].serie,
					}
					TriggerServerEvent("evidence:server:AddCasingToInventory", CurrentCasing, info)
				end
			end
		end

		if CurrentBlooddrop ~= nil and CurrentBlooddrop ~= 0 then 
			local pos = GetEntityCoords(GetPlayerPed(-1))
			if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Blooddrops[CurrentBlooddrop].coords.x, Blooddrops[CurrentBlooddrop].coords.y, Blooddrops[CurrentBlooddrop].coords.z, true) < 1.5 then
				DrawText3D(Blooddrops[CurrentBlooddrop].coords.x, Blooddrops[CurrentBlooddrop].coords.y, Blooddrops[CurrentBlooddrop].coords.z, "~g~G~w~ - Bloed ~b~#"..DnaHash(Blooddrops[CurrentBlooddrop].citizenid))
				if IsControlJustReleased(0, Keys["G"]) then
					local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, Blooddrops[CurrentBlooddrop].coords.x, Blooddrops[CurrentBlooddrop].coords.y, Blooddrops[CurrentBlooddrop].coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
					local street1 = GetStreetNameFromHashKey(s1)
					local street2 = GetStreetNameFromHashKey(s2)
					local streetLabel = street1
					if street2 ~= nil then
						streetLabel = streetLabel .. " | " .. street2
					end
					local info = {
						label = "Bloedmonster",
						type = "blood",
						street = streetLabel:gsub("%'", ""),
						dnalabel = DnaHash(Blooddrops[CurrentBlooddrop].citizenid),
						bloodtype = Blooddrops[CurrentBlooddrop].bloodtype,
					}
					TriggerServerEvent("evidence:server:AddBlooddropToInventory", CurrentBlooddrop, info)
				end
			end
		end

		if CurrentFingerprint ~= nil and CurrentFingerprint ~= 0 then 
			local pos = GetEntityCoords(GetPlayerPed(-1))
			if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Fingerprints[CurrentFingerprint].coords.x, Fingerprints[CurrentFingerprint].coords.y, Fingerprints[CurrentFingerprint].coords.z, true) < 1.5 then
				DrawText3D(Fingerprints[CurrentFingerprint].coords.x, Fingerprints[CurrentFingerprint].coords.y, Fingerprints[CurrentFingerprint].coords.z, "~g~G~w~ - Fingerprint ")
				if IsControlJustReleased(0, Keys["G"]) then
					local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, Fingerprints[CurrentFingerprint].coords.x, Fingerprints[CurrentFingerprint].coords.y, Fingerprints[CurrentFingerprint].coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
					local street1 = GetStreetNameFromHashKey(s1)
					local street2 = GetStreetNameFromHashKey(s2)
					local streetLabel = street1
					if street2 ~= nil then
						streetLabel = streetLabel .. " | " .. street2
					end
					local info = {
						label = "Fingerprint",
						type = "fingerprint",
						street = streetLabel:gsub("%'", ""),
						fingerprint = Fingerprints[CurrentFingerprint].fingerprint,
					}
					TriggerServerEvent("evidence:server:AddFingerprintToInventory", CurrentFingerprint, info)
				end
			end
		end
	end
end)

--[[
	Bullet Casings stuff
]]
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if isLoggedIn then 
			if PlayerJob.name == 'police' or PlayerJob.name == 'police1' or PlayerJob.name == 'police2' or PlayerJob.name == 'police3' or PlayerJob.name == 'police4' or PlayerJob.name == 'police5' or PlayerJob.name == 'police6' or PlayerJob.name == 'police7' or PlayerJob.name == 'police8' and onDuty then
				if IsPlayerFreeAiming(PlayerId()) and GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_FLASHLIGHT") then
					if next(Casings) ~= nil then
						local pos = GetEntityCoords(GetPlayerPed(-1), true)
						for k, v in pairs(Casings) do
							if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords.x, v.coords.y, v.coords.z, true) < 12.5 then
								CasingsNear[k] = v
								if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords.x, v.coords.y, v.coords.z, true) < 1.5 then
									CurrentCasing = k
								end
							else
								CasingsNear[k] = nil
							end
						end
					else
						CasingsNear = {}
					end
					if next(Blooddrops) ~= nil then
						local pos = GetEntityCoords(GetPlayerPed(-1), true)
						for k, v in pairs(Blooddrops) do
							if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords.x, v.coords.y, v.coords.z, true) < 12.5 then
								BlooddropsNear[k] = v
								if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords.x, v.coords.y, v.coords.z, true) < 1.5 then
									CurrentBlooddrop = k
								end
							else
								BlooddropsNear[k] = nil
							end
						end
					else
						BlooddropsNear = {}
					end
					if next(Fingerprints) ~= nil then
						local pos = GetEntityCoords(GetPlayerPed(-1), true)
						for k, v in pairs(Fingerprints) do
							if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords.x, v.coords.y, v.coords.z, true) < 12.5 then
								FingerprintsNear[k] = v
								if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords.x, v.coords.y, v.coords.z, true) < 1.5 then
									CurrentFingerprint = k
								end
							else
								FingerprintsNear[k] = nil
							end
						end
					else
						FingerprintsNear = {}
					end
				else
					Citizen.Wait(1000)
				end
			else
				Citizen.Wait(5000)
			end
		end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		if isLoggedIn and BlooddropsNear ~= nil then
			if IsPlayerFreeAiming(PlayerId()) and GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_FLASHLIGHT") then
				if PlayerJob.name == 'police' or PlayerJob.name == 'police1' or PlayerJob.name == 'police2' or PlayerJob.name == 'police3' or PlayerJob.name == 'police4' or PlayerJob.name == 'police5' or PlayerJob.name == 'police6' or PlayerJob.name == 'police7' or PlayerJob.name == 'police8' and onDuty then
					for k, v in pairs(BlooddropsNear) do
						if v ~= nil then
							DrawMarker(27, v.coords.x, v.coords.y, v.coords.z - 0.05, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.11, 0.11, 0.3, 250, 0, 50, 255, false, true, 2, false, false, false, false)
						end
					end
				end
			else
				Citizen.Wait(1000)
			end
		else
			Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		if isLoggedIn and CasingsNear ~= nil then
			if IsPlayerFreeAiming(PlayerId()) and GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_FLASHLIGHT") then
				if PlayerJob.name == 'police' or PlayerJob.name == 'police1' or PlayerJob.name == 'police2' or PlayerJob.name == 'police3' or PlayerJob.name == 'police4' or PlayerJob.name == 'police5' or PlayerJob.name == 'police6' or PlayerJob.name == 'police7' or PlayerJob.name == 'police8' and onDuty then
					for k, v in pairs(CasingsNear) do
						if v ~= nil then
							DrawMarker(27, v.coords.x, v.coords.y, v.coords.z - 0.05, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.11, 0.11, 0.3, 50, 0, 250, 255, false, true, 2, false, false, false, false)
						end
					end
				end
			else
				Citizen.Wait(1000)
			end
		else
			Citizen.Wait(1000)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		if isLoggedIn and FingerprintsNear ~= nil then
			if IsPlayerFreeAiming(PlayerId()) and GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_FLASHLIGHT") then
				if PlayerJob.name == 'police' or PlayerJob.name == 'police1' or PlayerJob.name == 'police2' or PlayerJob.name == 'police3' or PlayerJob.name == 'police4' or PlayerJob.name == 'police5' or PlayerJob.name == 'police6' or PlayerJob.name == 'police7' or PlayerJob.name == 'police8' and onDuty then
					for k, v in pairs(FingerprintsNear) do
						if v ~= nil then
							DrawMarker(27, v.coords.x, v.coords.y, v.coords.z - 0.05, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.11, 0.11, 0.3, 23, 173, 12, 255, false, true, 2, false, false, false, false)
						end
					end
				end
			else
				Citizen.Wait(1000)
			end
		else
			Citizen.Wait(1000)
        end
    end
end)

local SilentWeapons = {
	"WEAPON_PETROLCAN",
	"WEAPON_STUNGUN",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_UNARMED",	
}
Citizen.CreateThread( function()
    local currentWeapon = GetSelectedPedWeapon(GetPlayerPed(-1))
	local isArmed = false
	local timeCheck = 0
    while true do
        Citizen.Wait(50)
        if not isArmed then
            if IsPedArmed(GetPlayerPed(-1), 7) and not IsPedArmed(GetPlayerPed(-1), 1) then
                currentWeapon = GetSelectedPedWeapon(GetPlayerPed(-1))
                isArmed = true
                timeCheck = 7
            end
		end
		if isArmed then
			if PlayerJob.name == 'police' or PlayerJob.name == 'police1' or PlayerJob.name == 'police2' or PlayerJob.name == 'police3' or PlayerJob.name == 'police4' or PlayerJob.name == 'police5' or PlayerJob.name == 'police6' or PlayerJob.name == 'police7' or PlayerJob.name == 'police8' then
				if IsPedShooting(PlayerPedId()) then
					local Weapon = GetSelectedPedWeapon(PlayerPedId())
					local SilentWeapon = IsWeaponSilent(Weapon)
					local GunCategory = GetWeaponCategory(Weapon)
					if not SilentWeapon then
						if not GunShotAlert then
							GunShotAlert = true
							TriggerServerEvent('qb-police:server:send:alert:gunshots', GetEntityCoords(PlayerPedId()), GunCategory, QBCore.Functions.GetStreetLabel(), IsPedInAnyVehicle(PlayerPedId()))
							Citizen.SetTimeout(2000, function()
								GunShotAlert = false
							end)
						end
					end
				end
			end
		else
			Citizen.Wait(1000)
		end
    end
end)

function IsWeaponSilent(Weapon)
	local IsSilent = false
	 for k, v in pairs(Config.SilentWeapons) do
	  if GetHashKey(v) == Weapon then		
	  	IsSilent = true
	  end
	 end
 return IsSilent
end

function GetWeaponCategory(Weapon)
	local WeaponCategory = 'Unknown'
	local WeaponGroupHash = GetWeapontypeGroup(Weapon)
	if Config.WeaponHashGroup[WeaponGroupHash] ~= nil then 
		WeaponCategory = Config.WeaponHashGroup[WeaponGroupHash]['name']
	end
	return WeaponCategory
end

function IsPedNearby()
	local retval = false
	local PlayerPeds = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        table.insert(PlayerPeds, ped)
    end
    local player = GetPlayerPed(-1)
    local coords = GetEntityCoords(player)
	local closestPed, closestDistance = QBCore.Functions.GetClosestPed(coords, PlayerPeds)
	if not IsEntityDead(closestPed) and closestDistance < 100.0 then
		retval = true
	end
	return retval
end

function IsSilentWeapon(weapon)
	local retval = false
	for k, v in pairs(SilentWeapons) do
		if GetHashKey(v) == weapon then 
			retval = true
		end
	end
	if not retval then 
		QBCore.Functions.TriggerCallback('police:IsSilencedWeapon', function(result)
			retval = result
			return result
		end, weapon)
		Citizen.Wait(100)
		return retval
	else
		return retval
	end
end

function DropBulletCasing(weapon)
	local randX = math.random() + math.random(-1, 1)
	local randY = math.random() + math.random(-1, 1)
	local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(GetPlayerFromServerId(playerId)), randX, randY, 0)
	TriggerServerEvent("evidence:server:CreateCasing", weapon, coords)
	Citizen.Wait(300)
end

function DnaHash(s)
    local h = string.gsub(s, ".", function(c)
		return string.format("%02x", string.byte(c))
	end)
    return h
end