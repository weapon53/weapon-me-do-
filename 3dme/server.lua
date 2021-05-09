local logEnabled = false
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text, name)
	TriggerClientEvent('3dme:triggerDisplay', -1, text, source, name)
	if logEnabled then
		setLog(text, source)
	end
end)

function setLog(text, source)
	local time = os.date("%d/%m/%Y %X")
	local name = GetPlayerName(source)
	local identifier = GetPlayerIdentifiers(source)
	local data = time .. ' : ' .. name .. ' - ' .. identifier[1] .. ' : ' .. text

	local content = LoadResourceFile(GetCurrentResourceName(), "log.txt")
	local newContent = content .. '\r\n' .. data
	SaveResourceFile(GetCurrentResourceName(), "log.txt", newContent, -1)
end

RegisterCommand('temizle', function(source, args, rawCommand)
    TriggerClientEvent('chat:client:ClearChat', source)
end, false)

ESX.RegisterServerCallback('fizzfau-getrpname', function(source, cb)
    local Identifier = ESX.GetPlayerFromId(source).identifier

    MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

        cb(result[1].firstname.. " " .. result[1].lastname)
    end)
end)