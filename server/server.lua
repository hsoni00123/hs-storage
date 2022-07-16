local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("crate", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('hs-storage:client:Spawncrate', source)
    end
end)

