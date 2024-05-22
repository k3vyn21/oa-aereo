--
-- Vars
--
universalText = true

local jobs = {
    [1] = {
        ['job'] = {
            ['street'] = "Central eolica 21", -- Central electrica
            ['coordsFirstPoint'] = vector3(2475.83, 1460.95, 36.2), -- primer evento
            ['coordsSecondPoint'] = vector3(2395.09, 1276.46, 99.59), -- segundo evento
            ['coordsTheerePoint'] = vector3(2475.83, 1460.95, 36.2), --tercer paso
            ['thirtpoint'] = vector3(731.08, -1988.26, 29.29), -- dejar vehiculo
            ['stopFurgo'] = vector3(2447.59, 1480.1, 35.27), -- detener vehiculo
            ['job0'] = false,
            ['job1'] = false,
            ['job2'] = false,
            ['job3'] = false,
            ['job4'] = false,
            ['job5'] = false
        }
    },
    [2] = {
        ['job'] = {
            ['street'] = "Central eolica 22", -- Central electrica
            ['coordsFirstPoint'] = vector3(2137.67, 1949.55, 93.79), -- primer evento
            ['coordsSecondPoint'] = vector3(2052.05, 2004.08, 123.7), -- segundo evento
            ['coordsTheerePoint'] = vector3(2137.67, 1949.55, 93.79), --tercer paso
            ['thirtpoint'] = vector3(731.08, -1988.26, 29.29), -- dejar vehiculo
            ['stopFurgo'] = vector3(2130.39, 1938.09, 93.14), -- detener vehiculo
            ['job0'] = false,
            ['job1'] = false,
            ['job2'] = false,
            ['job3'] = false,
            ['job4'] = false,
            ['job5'] = false
        }
    },
    [3] = {
        ['job'] = {
            ['street'] = "Central eolica 23", -- Central electrica
            ['coordsFirstPoint'] = vector3(2137.67, 1949.55, 93.79), -- primer evento
            ['coordsSecondPoint'] = vector3(2078.52, 1692.75, 140.52), -- segundo evento
            ['coordsTheerePoint'] = vector3(2137.67, 1949.55, 93.79), --tercer paso
            ['thirtpoint'] = vector3(731.08, -1988.26, 29.29), -- dejar vehiculo
            ['stopFurgo'] = vector3(2121.25, 1937.97, 93.12), -- detener vehiculo
            ['job0'] = false,
            ['job1'] = false,
            ['job2'] = false,
            ['job3'] = false,
            ['job4'] = false,
            ['job5'] = false
        }
    },
    [4] = {
        ['job'] = {
            ['street'] = "Central eolica 24", -- Central electrica
            ['coordsFirstPoint'] = vector3(2106.66, 2323.4, 94.29), -- primer evento
            ['coordsSecondPoint'] = vector3(2369.04, 2189.46, 140.38), -- segundo evento
            ['coordsTheerePoint'] = vector3(2106.66, 2323.4, 94.29), --tercer paso
            ['thirtpoint'] = vector3(731.08, -1988.26, 29.29), -- dejar vehiculo
            ['stopFurgo'] = vector3(2092.41, 2340.86, 93.63), -- detener vehiculo
            ['job0'] = false,
            ['job1'] = false,
            ['job2'] = false,
            ['job3'] = false,
            ['job4'] = false,
            ['job5'] = false
        }
    },
    [5] = {
        ['job'] = {
            ['street'] = "Central eolica 25", -- Central electrica
            ['coordsFirstPoint'] = vector3(2137.82, 1949.77, 93.79), -- primer evento
            ['coordsSecondPoint'] = vector3(2300.28, 1857.42, 107.0), -- segundo evento
            ['coordsTheerePoint'] = vector3(2137.82, 1949.77, 93.79), --tercer paso
            ['thirtpoint'] = vector3(731.08, -1988.26, 29.29), -- dejar vehiculo
            ['stopFurgo'] = vector3(2130.23, 1937.6, 93.85), -- detener vehiculo
            ['job0'] = false,
            ['job1'] = false,
            ['job2'] = false,
            ['job3'] = false,
            ['job4'] = false,
            ['job5'] = false
        }
    },
}

local CQT = {
    ['npc'] = {
        ['coords'] = vector4(729.37, -1974.08, 28.29, 266.24),
        ['label'] = vector3(729.37, -1974.08, 30.29) 
    }
}

--
-- ESX Callbacks
--
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

    PlayerData = ESX.GetPlayerData()
    
    SpawnNPC('s_m_m_dockwork_01', 'world_human_clipboard', CQT['npc']['coords'])
    while true do
        local s = 1000
        local ply = PlayerPedId()
        local dfk = GetEntityCoords(ply)
        if #(dfk - CQT['npc']['label']) < 5.0 then
            s = 5
            if #(dfk - CQT['npc']['label']) < 2.5 then
                s = 0
                if PlayerData.job2 ~= nil and PlayerData.job2.name == 'chilquinta' then
                    if universalText == true then
                        ESX.ShowFloatingHelpNotification("[~g~E~w~] Conseguir un trabajo", CQT['npc']['label'])
                        if IsControlJustPressed(0, 38) then
                            TriggerServerEvent('InteractSound_SV:PlayOnSource', 'Chilquinta', 0.9)
                            TriggerEvent('oa-aereo:StartTutorial')
                            selectedJob = jobs[math.random(1, #jobs)]
                            selectedJob['job']['job0'] = true
                            blip1 = AddBlipForCoord(selectedJob['job']['stopFurgo'])
                            SetBlipRoute(blip1, true)
                            universalText = false
                            ESX.Game.SpawnVehicle('boxville', vector3(731.97, -1960.91, 29.29), 359.94, function(ven)
                                exports['oa-fuel']:SetFuel(ven, 100)
                            end)
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                if skin.sex == 0 then
                                    TriggerEvent('skinchanger:change', 'tshirt_1', 15)
                                    TriggerEvent('skinchanger:change', 'tshirt_2', 0)
                                    TriggerEvent('skinchanger:change', 'torso_1', 73)
                                    TriggerEvent('skinchanger:change', 'torso_2', 0)
                                    TriggerEvent('skinchanger:change', 'pants_1', 36)
                                    TriggerEvent('skinchanger:change', 'pants_2', 0)
                                    TriggerEvent('skinchanger:change', 'shoes_1', 12)
                                    TriggerEvent('skinchanger:change', 'shoes_2', 0)
                                    TriggerEvent('skinchanger:change', 'helmet_1', 76)
                                    TriggerEvent('skinchanger:change', 'helmet_2', 4)
                                    TriggerEvent('skinchanger:change', 'arms', 63)
                                    TriggerEvent('skinchanger:change', 'decals_1', 1)
                                else
                                    TriggerEvent('skinchanger:change', 'tshirt_1', 15)
                                    TriggerEvent('skinchanger:change', 'tshirt_2', 0)
                                    TriggerEvent('skinchanger:change', 'torso_1', 73)
                                    TriggerEvent('skinchanger:change', 'torso_2', 0)
                                    TriggerEvent('skinchanger:change', 'pants_1', 35)
                                    TriggerEvent('skinchanger:change', 'pants_2', 0)
                                    TriggerEvent('skinchanger:change', 'shoes_1', 24)
                                    TriggerEvent('skinchanger:change', 'shoes_2', 0)
                                    TriggerEvent('skinchanger:change', 'helmet_1', -1)
                                    TriggerEvent('skinchanger:change', 'helmet_2', -1)
                                    TriggerEvent('skinchanger:change', 'arms', 83)
                                    TriggerEvent('skinchanger:change', 'decals_1', 1)
                                end
                            end)
                        end
                    else
                        ESX.ShowFloatingHelpNotification("~r~Ya estas en un encargo", CQT['npc']['label'])
                    end
                else
                    ESX.ShowFloatingHelpNotification("~r~No eres empleado de chilectra", CQT['npc']['label'])
                end
            end
        end
        Citizen.Wait(s)
    end
end)

Citizen.CreateThread(function()
    while true do
        local ply = PlayerPedId()
        local dfk = GetEntityCoords(ply)
        while selectedJob == nil do
            Citizen.Wait(100)
        end
        if selectedJob['job']['job0'] == true then
            DrawText("Ve a reparar el ~g~eolico~w~ en ~y~"..selectedJob['job']['street'])
            if #(dfk - selectedJob['job']['stopFurgo']) < 3.0 then
                ESX.ShowFloatingHelpNotification("[~g~E~w~] Para aparcar el camion", selectedJob['job']['stopFurgo'])
                if IsControlJustPressed(0, 38) then
                    ESX.TriggerServerCallback('oa-aereo:giveItem', function()
                    
                    end, 'herramienta', 1)
                    ExecuteCommand("Me Saca una caja de herramientas detras de la furgoneta")
                    --ESX.TriggerServerCallback('oa-aereo:giveItem', function()
                    
                    --end, 'router', 1)
                    SetBlipRoute(blip1, false)
                    RemoveBlip(blip1)
                    blip2 = AddBlipForCoord(selectedJob['job']['coordsFirstPoint'])
                    SetBlipRoute(blip2, true)
                    FreezeEntityPosition(GetVehiclePedIsIn(ply), true)
                    selectedJob['job']['job0'] = false
                    selectedJob['job']['job1'] = true
                end
            end
        end
        if selectedJob['job']['job1'] == true then
            DrawText("Ve a la ~g~Central Electrica~w~ en ~y~"..selectedJob['job']['street'])
            if #(dfk - selectedJob['job']['coordsFirstPoint']) < 3.0 then
                ESX.ShowFloatingHelpNotification("[~g~E~w~] Para Apagar el eolico", selectedJob['job']['coordsFirstPoint'])
                if IsControlJustPressed(0, 38) then
                    TriggerEvent("mythic_progbar:client:progress", {name = "unique_action_name",duration = 7 * 1000, label = "Apagando..."})
                    FreezeEntityPosition(ply, true)
                    ExecuteCommand("e mechanic")
                    --exports.oa_xp:ESXP_Add(5)
                    Citizen.Wait(7000)
                    FreezeEntityPosition(ply, false)
                    ClearPedTasks(ply)
                    SetBlipRoute(blip2, false)
                    RemoveBlip(blip2)
                    --ESX.TriggerServerCallback('oa-aereo:removeItem', function()
                    
                    --end, 'antena', 1)
                    blip3 = AddBlipForCoord(selectedJob['job']['coordsSecondPoint'])
                    SetBlipRoute(blip3, true)
                    selectedJob['job']['job1'] = false
                    selectedJob['job']['job2'] = true
                end
            end
        end
        if selectedJob['job']['job2'] == true then
            DrawText("Ve a reparar el ~g~eolico~w~ en ~y~"..selectedJob['job']['street'])
            if #(dfk - selectedJob['job']['coordsSecondPoint']) < 2 then
                ESX.ShowFloatingHelpNotification("[~g~E~w~] Para reparar eolico", selectedJob['job']['coordsSecondPoint'])
                if IsControlJustPressed(0, 38) then
                    TriggerEvent("mythic_progbar:client:progress", {name = "unique_action_name",duration = 10 * 1000, label = "Reparando..."})
                    FreezeEntityPosition(ply, true)
                    ExecuteCommand("e mechanic3")
                    --exports.oa_xp:ESXP_Add(2)
                    Citizen.Wait(10000)
                    FreezeEntityPosition(ply, false)
                    ClearPedTasks(ply)
                    SetBlipRoute(blip3, false)
                    RemoveBlip(blip3)
                    ESX.TriggerServerCallback('oa-aereo:removeItem', function()
                    
                    end, 'herramienta', 1)
                    blip4 = AddBlipForCoord(selectedJob['job']['coordsTheerePoint'])
                    SetBlipRoute(blip4, true)
                    selectedJob['job']['job2'] = false
                    selectedJob['job']['job3'] = true
                end
            end
        end
        if selectedJob['job']['job3'] == true then
            DrawText("Ve a reiniciar la ~g~energia~w~ en ~y~"..selectedJob['job']['street'])
            if #(dfk - selectedJob['job']['coordsTheerePoint']) < 2 then
                ESX.ShowFloatingHelpNotification("[~g~E~w~] Reinicar la energia", selectedJob['job']['coordsTheerePoint'])
                if IsControlJustPressed(0, 38) then
                    TriggerEvent("mythic_progbar:client:progress", {name = "unique_action_name",duration = 9 * 1000, label = "Reiniciando..."})
                    FreezeEntityPosition(ply, true)
                    ExecuteCommand("e mechanic")
                    --exports.oa_xp:ESXP_Add(5)
                    Citizen.Wait(9000)
                    FreezeEntityPosition(ply, false)
                    ClearPedTasks(ply)
                    SetBlipRoute(blip4, false)
                    RemoveBlip(blip4)
                    blip5 = AddBlipForCoord(selectedJob['job']['thirtpoint'])
                    SetBlipRoute(blip5, true)
                    selectedJob['job']['job3'] = false
                    selectedJob['job']['job4'] = true
                    selectedJob['job']['job5'] = true
                end
            end
        end
        if selectedJob['job']['job4'] == true then
            DrawText("Ve a dejar la ~g~furgoneta")
            if selectedJob['job']['job5'] == true then
                if #(dfk - selectedJob['job']['stopFurgo']) < 5 then
                    if IsVehicleModel(GetVehiclePedIsIn(ply), GetHashKey('boxville')) then
                        ESX.ShowFloatingHelpNotification("[~g~E~w~] Para encender el motor", selectedJob['job']['stopFurgo'])
                        if IsControlJustPressed(0, 38) then
                            FreezeEntityPosition(GetVehiclePedIsIn(ply), false)
                            selectedJob['job']['job5'] = false
                        end
                    else
                        ESX.ShowFloatingHelpNotification("~r~Montate en la furgoneta", selectedJob['job']['stopFurgo'])
                    end
                end
            end
            if #(dfk - selectedJob['job']['thirtpoint']) < 5 then
                ESX.ShowFloatingHelpNotification("[~g~E~w~] Para dejar la camioneta", selectedJob['job']['thirtpoint'])
                if IsControlJustPressed(0, 38) then
                    if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1)), GetHashKey('boxville')) then
                        DeleteEntity(GetVehiclePedIsIn(ply))
                        SetBlipRoute(blip5, false)
                        RemoveBlip(blip5)
                        ESX.TriggerServerCallback('oa-aereo:addMoney', function()
                        
                        end)
                        selectedJob['job']['job4'] = false
                        universalText = true
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                            local model = nil
                
                            if skin.sex == 0 then
                                model = GetHashKey("mp_m_freemode_01")
                            else
                                model = GetHashKey("mp_f_freemode_01")
                            end
                
                            RequestModel(model)
                            while not HasModelLoaded(model) do
                                RequestModel(model)
                                Citizen.Wait(1)
                            end
                
                            SetPlayerModel(PlayerId(), model)
                            SetModelAsNoLongerNeeded(model)
                
                            TriggerEvent('skinchanger:loadSkin', skin)
                            TriggerEvent('esx:restoreLoadout')
                            local playerPed = GetPlayerPed(-1)
                            SetPedArmour(playerPed, 0)
                            ClearPedBloodDamage(playerPed)
                            ResetPedVisibleDamage(playerPed)
                            ClearPedLastWeaponDamage(playerPed)
                        end)
                    end
                end
            end
        end
        Citizen.Wait(0)
    end
end)

--
-- Funcs
--
SpawnNPC = function(modelo, anim, x,y,z,h)
    hash = GetHashKey(modelo)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(1)
    end
    crearNPC = CreatePed(5, hash, x,y,z,h, false, true)
    FreezeEntityPosition(crearNPC, true)
    SetEntityInvincible(crearNPC, true)
    SetBlockingOfNonTemporaryEvents(crearNPC, true)
    TaskStartScenarioInPlace(crearNPC, anim, 0, false)
end

DrawText = function(text)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(0, 1)
end

Citizen.CreateThread(function()
    blip = AddBlipForCoord(CQT['npc']['label'])
    SetBlipSprite(blip, 603)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.9)
    SetBlipColour(blip, 30)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Central Chilectra")
    EndTextCommandSetBlipName(blip)
end)

--
-- Job callback
--

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	PlayerData.job2 = job2
end)

----HUI
Citizen.CreateThread(function()
    while true do
        if guiEnabled then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown

            DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate

            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride

            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click"
                })
            end
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('oa-aereo:forceEnd')
AddEventHandler('oa-aereo:forceEnd', function()
    selectedJob['job']['job0'] = false
    selectedJob['job']['job1'] = false
    selectedJob['job']['job2'] = false
    selectedJob['job']['job3'] = false
    selectedJob['job']['job4'] = false
    DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
end)

RegisterNetEvent('oa-aereo:StartTutorial')
AddEventHandler('oa-aereo:StartTutorial',function()
	EnableGui(true)
end)

RegisterNUICallback('closeNUI', function(data, cb)
    EnableGui(false)
end) 

function EnableGui(enable)
    SetNuiFocus(enable)
    guiEnabled = enable

    SendNUIMessage({
        type = "enabledElectro",
        enable = enable
    })
end