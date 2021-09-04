
RegisterNetEvent('esx:playerLoaded') 
AddEventHandler('esx:playerLoaded', function(xPlayer, isNew)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:playerLogout') 
AddEventHandler('esx:playerLogout', function(xPlayer, isNew)
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

CreateThread(function()
    while true do 
        local wait = 1000
        for k,v in pairs(Config.mafias) do 
                if ESX.PlayerData.job and ESX.PlayerData.job.name == v.job then 
                local _pos = GetEntityCoords(PlayerPedId())
                local _dist = #(_pos - v.point) < 3
                if _dist then 
                    wait = 0
                    ESX.ShowFloatingHelpNotification(_U('open_mafia'), v.point)
                    local elements = {
                        { label = _U('inventory'), value = 'inventory' },
                        { label = _U('boss_menu'), value = 'boss' }
                    }

                    if IsControlJustPressed(0, 38) then
                        ESX.UI.Menu.CloseAll()

                        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'MafiaMenu',
                        {
                            title    = _U('mafia_menu'),
                            align    = 'bottom-right',
                            elements = elements
                        }, function(data, menu)
                            if data.current.value == 'inventory' then
                                TriggerEvent('mafias:openArmory', v.job)
                            elseif data.current.value == 'boss' then
                                TriggerEvent('mafias:bossMenu')
                            end
                        end, function(data, menu)
                            menu.close()
                        end)
                    end
                end 
            end
        end
        Wait(wait)
    end
end)

AddEventHandler("mafias:bossMenu", function()
    if ESX.PlayerData.job and ESX.PlayerData.job.grade_name == "boss" then 

        local elements = {
            { label = _U('recruit_menu'), value = 'recruit' },
            { label = _U('fire_menu'), value = 'fire' },
            { label = _U('promote_menu'), value = 'promote' },
            { label = _U('descend_menu'), value = 'descend' },
        }

        ESX.UI.Menu.CloseAll()

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'BossMenu',
        {
            title    = _U('boss_menu'),
            align    = 'bottom-right',
            elements = elements
        }, function(data, menu)
            if data.current.value == 'recruit' then
                TriggerEvent('mafias:bossActions', 'recruit')
            elseif data.current.value == 'fire' then
                TriggerEvent('mafias:bossActions', 'fire')
            elseif data.current.value == 'promote' then
                TriggerEvent('mafias:bossActions', 'promote')
            elseif data.current.value == 'descend' then
                TriggerEvent('mafias:bossActions', 'descend')
            end
        end, function(data, menu)
            menu.close()
        end)
    else
        ESX.ShowNotification(_U('not_boss'))
    end
end)

AddEventHandler('mafias:bossActions', function(jobdata)
    if ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' then 
        local action = jobdata
        if action == 'recruit' then
            local job =  ESX.PlayerData.job.name
            local grade = 0
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer == -1 or closestDistance > 3.0 then
                ESX.ShowNotification(_U('noplayersnearby'))
            else
                TriggerServerEvent('mafias:recruit', GetPlayerServerId(closestPlayer), job,grade)
            end
        elseif action == 'fire' then 
            local job =  ESX.PlayerData.job.name
            local grade = 0
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer == -1 or closestDistance > 3.0 then
                ESX.ShowNotification(_U('noplayersnearby'))
            else
                TriggerServerEvent('mafias:fire', GetPlayerServerId(closestPlayer))
            end
        elseif action == 'promote' then 
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer == -1 or closestDistance > 3.0 then
                ESX.ShowNotification(_U('noplayersnearby'))
            else
                TriggerServerEvent('mafias:promote', GetPlayerServerId(closestPlayer))
            end
        elseif action == 'descend' then 
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer == -1 or closestDistance > 3.0 then
                ESX.ShowNotification(_U('noplayersnearby'))
            else
                TriggerServerEvent('mafias:descend', GetPlayerServerId(closestPlayer))
            end
        else
            ESX.ShowNotification(_U('not_boss'))
        end
    end
end)

AddEventHandler('mafias:openArmory', function(invdata)
    local setString = 'society_' .. invdata
    TriggerEvent("esx_inventoryhud:openStorageInventory", setString)
end)
