local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(GangInfo)
    PlayerData.gang = GangInfo
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)


RegisterNetEvent('hs-storage:client:spawncrate', function()
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local forward   = GetEntityForwardVector(playerPed)
    local x, y, z   = table.unpack(coords + forward * 1.0)

    local model = `bkr_prop_crate_set_01a`
    RequestModel(model)
    while (not HasModelLoaded(model)) do
        Wait(1)
    end
    QBCore.Functions.Progressbar('name_here', 'PLACING Crate...', 1000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'missfinale_c2ig_11',
        anim = 'pushcar_offcliff_f',
        flags = 16,
    }, {}, {}, function()
        local obj = CreateObject(model, x, y, z, true, false, true)
        PlaceObjectOnGroundProperly(obj)
        SetEntityAsMissionEntity(obj)

        TriggerServerEvent('QBCore:Server:RemoveItem', 'crate', 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['crate'], "remove")
    end)
end)

RegisterNetEvent('hs-storage:client:deletecrate', function()
    local coords = GetEntityCoords(PlayerPedId())
    local obj = QBCore.Functions.GetClosestObject(coords)
    if DoesEntityExist(obj) then
        QBCore.Functions.Progressbar('name_here', 'TAKING TABLE...', 1000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'missfinale_c2ig_11',
            anim = 'pushcar_offcliff_f',
            flags = 16,
        }, {}, {}, function()
            DeleteEntity(obj)
            
            TriggerServerEvent('QBCore:Server:AddItem', 'crate', 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['crate'], "Add")
        end)
    end
end)


RegisterNetEvent('hs-storage:StashAvailability1', function()
	exports['qb-menu']:openMenu({
		{
			id = 0,
			header = "Open Locker SL_634734",
			txt = "",
			params = {
			event = "qb-storagelockers:Stash1",
			}
		},
	})
end)
-- RegisterNetEvent('hs-storage:StashAvailability2', function()
-- 	exports['qb-menu']:openMenu({
-- 		{
-- 			id = 0,
-- 			header = "Open Locker SL_54367",
-- 			txt = "",
-- 			params = {
-- 			event = "qb-storagelockers:Stash2",
-- 			}
-- 		},
-- 	})
-- end)

RegisterNetEvent('qb-storagelockers:Stash1', function()
	local keyboard = exports["qb-keyboard"]:KeyboardInput({
		header = "Enter Password",
		rows = {
			{
				id = 0,
				txt = ""
			}
		}
	})
    if keyboard ~= nil then
        if keyboard[1].input == Config.SL_634734 then
            EnterStash1()
        end
    end
end)

RegisterNetEvent('qb-storagelockers:Stash2', function()
	local keyboard = exports["qb-keyboard"]:KeyboardInput({
		header = "Enter Password",
		rows = {
			{
				id = 0,
				txt = ""
			}
		}
	})
    if keyboard ~= nil then
        if keyboard[1].input == Config.SL_54367 then
            EnterStash2()
        end
    end
end)

function EnterStash1()
    TriggerEvent("inventory:client:SetCurrentStash", "SL_634734")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "SL_634734", {
        maxweight = 4000000,
        slots = 500,
    })
end

function EnterStash2()
    TriggerEvent("inventory:client:SetCurrentStash", "SL_54367")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "SL_54367", {
        maxweight = 4000000,
        slots = 500,
    })
end




