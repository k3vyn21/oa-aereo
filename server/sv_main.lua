--
-- Var
--
Money = math.random(45000, 69000)

--
-- ESX Callbacks
--
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

--
-- Callacks
--
ESX.RegisterServerCallback('oa-aereo:giveItem', function(source, cb, item, count)
    local user = ESX.GetPlayerFromId(source)
    user.addInventoryItem(item, count)
end)

ESX.RegisterServerCallback('oa-aereo:removeItem', function(source, cb, item, count)
    local user = ESX.GetPlayerFromId(source)
    user.removeInventoryItem(item, count)
end)

ESX.RegisterServerCallback('oa-aereo:addMoney', function(source, cb)
    local user = ESX.GetPlayerFromId(source)
    user.addMoney(Money)
    --TriggerClientEvent('chatMessage', user.source, 'Chilquinta', {255, 255, 0}, ' Has recibido '..Money.."$")
    TriggerClientEvent("pNotify:SendNotification", user.source, {text = "<center><strong><b style='color:#9e66f2'>CHILQUINTA</b><strong><br /> <br /> Toma aqui tienes tu dinero $ "..Money.." <center>", type = "info", queue = "global", timeout = 5000, layout = "centerRight" })
end)