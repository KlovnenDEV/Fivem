QBCore = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(200)
        end
    end
end)

-- Code

local radioMenu = false
local isLoggedIn = false

function enableRadio(enable)
  if enable then
    SetNuiFocus(enable, enable)
    PhonePlayIn()
    SendNUIMessage({
      type = "open",
    })
    radioMenu = enable
  end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

Citizen.CreateThread(function()
  while true do
    if QBCore ~= nil then
      if isLoggedIn then
        QBCore.Functions.TriggerCallback('qb-radio:server:GetItem', function(hasItem)
          if not hasItem then
            if exports.tokovoip_script ~= nil and next(exports.tokovoip_script) ~= nil then
              local PlayerData = QBCore.Functions.GetPlayerData()
              local playerName = GetPlayerName(PlayerId())
              --local getPlayerRadioChannel = exports["mumble-voip"]:GetPlayersInRadioChannel(playerName, "radio:channel")

              if getPlayerRadioChannel ~= "nil" then
                exports["mumble-voip"]:removePlayerFromRadio(getPlayerRadioChannel)
                exports["mumble-voip"]:SetRadioChannel(playerName, "radio:channel", "nil", true)
                exports["mumble-voip"]:SetMumbleProperty("radioEnabled", true)
                TriggerEvent('swt_notifications:Infos','You are removed from your current frequency!')
              end
            end
          end
        end, "radio")
      end
    end

    Citizen.Wait(10000)
  end
end)

RegisterNUICallback('joinRadio', function(data, cb)
  local _source = source
  local PlayerData = QBCore.Functions.GetPlayerData()
  local playerName = GetPlayerName(PlayerId())
  --local getPlayerRadioChannel = exports["mumble-voip"]:GetPlayersInRadioChannel(playerName, "radio:channel")

  if tonumber(data.channel) <= Config.MaxFrequency then
    if tonumber(data.channel) ~= tonumber(getPlayerRadioChannel) then
      if tonumber(data.channel) <= Config.RestrictedChannels then
        if(PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'doctor') then
          exports["mumble-voip"]:removePlayerFromRadio(getPlayerRadioChannel)
          exports["mumble-voip"]:SetRadioChannel(playerName, "radio:channel", tonumber(data.channel), true);
          exports["mumble-voip"]:addPlayerToRadio(tonumber(data.channel), "Radio", "radio")
          exports["mumble-voip"]:SetMumbleProperty("radioEnabled", true)
          if SplitStr(data.channel, ".")[2] ~= nil and SplitStr(data.channel, ".")[2] ~= "" then 
            TriggerEvent("swt_notifications:Infos",Config.messages['joined_to_radio'] .. data.channel .. ' MHz </b>')
          else
            TriggerEvent("swt_notifications:Infos",Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
          end
        else
          TriggerEvent("swt_notifications:Infos",Config.messages['restricted_channel_error'])
        end
      end

      if tonumber(data.channel) > Config.RestrictedChannels then
        exports["mumble-voip"]:removePlayerFromRadio(getPlayerRadioChannel)
        exports["mumble-voip"]:SetRadioChannel(playerName, "radio:channel", tonumber(data.channel), true);
        exports["mumble-voip"]:addPlayerToRadio(tonumber(data.channel), "Radio", "radio")
        exports["mumble-voip"]:SetMumbleProperty("radioEnabled", true)
        if SplitStr(data.channel, ".")[2] ~= nil and SplitStr(data.channel, ".")[2] ~= "" then 
          TriggerEvent("swt_notifications:Infos",Config.messages['joined_to_radio'] .. data.channel .. ' MHz </b>')
        else
          TriggerEvent("swt_notifications:Infos",Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
        end
      end
    else
      if SplitStr(data.channel, ".")[2] ~= nil and SplitStr(data.channel, ".")[2] ~= "" then 
        TriggerEvent("swt_notifications:Infos",Config.messages['you_on_radio'] .. data.channel .. ' MHz </b>')
      else
        TriggerEvent("swt_notifications:Infos",Config.messages['you_on_radio'] .. data.channel .. '.00 MHz </b>')
      end
    end
  else
    TriggerEvent('swt_notifications:Infos','This frequency is not available.')
  end
  cb('ok')
end)

RegisterNUICallback('leaveRadio', function(data, cb)
  local playerName = GetPlayerName(PlayerId())
  --local getPlayerRadioChannel = exports["mumble-voip"]:GetPlayersInRadioChannel(playerName, "radio:channel")
  if getPlayerRadioChannel == "nil" then
    TriggerEvent("swt_notifications:Infos",Config.messages['not_on_radio'])
  else
    exports["mumble-voip"]:removePlayerFromRadio(getPlayerRadioChannel)
    exports["mumble-voip"]:SetRadioChannel(playerName, "radio:channel", "nil", true)
    exports["mumble-voip"]:SetMumbleProperty("radioEnabled", false)
    if SplitStr(getPlayerRadioChannel, ".")[2] ~= nil and SplitStr(getPlayerRadioChannel, ".")[2] ~= "" then 
      TriggerEvent("swt_notifications:Infos",Config.messages['you_leave'] .. getPlayerRadioChannel .. ' MHz </b>')
    else
      TriggerEvent("swt_notifications:Infos",Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')
    end
    
  end
  cb('ok')
end)

RegisterNUICallback('escape', function(data, cb)
  SetNuiFocus(false, false)
  radioMenu = false
  PhonePlayOut()
  cb('ok')
end)

RegisterNetEvent('qb-radio:use')
AddEventHandler('qb-radio:use', function()
  enableRadio(true)
end)

RegisterNetEvent('qb-radio:onRadioDrop')
AddEventHandler('qb-radio:onRadioDrop', function()
  local playerName = GetPlayerName(PlayerId())
  --local getPlayerRadioChannel = exports["mumble-voip"]:GetPlayersInRadioChannel(playerName, "radio:channel")

  if getPlayerRadioChannel ~= "nil" then
    exports["mumble-voip"]:removePlayerFromRadio(getPlayerRadioChannel)
    exports["mumble-voip"]:SetRadioChannel(playerName, "radio:channel", "nil", true)
    exports["mumble-voip"]:SetMumbleProperty("radioEnabled", false)
    TriggerEvent("swt_notifications:Infos",Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')
  end
end)

function SplitStr(inputstr, sep)
	if sep == nil then
			sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
	end
	return t
end