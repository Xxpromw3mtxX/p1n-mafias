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
        local wait = Config.TickTime
        for k,v in pairs(Config.mafias) do 
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.job then 
                local _pos = GetEntityCoords(PlayerPedId())
                local inventory = #(_pos - v.inV) < 3
                local boss = #(_pos - v.bossM) < 3
                local cloakroom = #(_pos - v.cloaK) < 2

                if inventory then
                    wait = 0
                    ESX.ShowFloatingHelpNotification(_U('open_inv'), v.inV)
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent('mafias:openArmory', v.job)
                    end
                end

                if boss then
                    wait = 0
                    ESX.ShowFloatingHelpNotification(_U('open_mafia'), v.bossM)
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent('mafias:bossMenu', v.job)
                    end
                end

                if cloakroom then
                    wait = 0
                    ESX.ShowFloatingHelpNotification(_U('open_cloak'), v.cloaK)
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent('mafias:openCloakroom')
                    end
                end
            end
        end
        Citizen.Wait(wait)
    end
end)

AddEventHandler("mafias:bossMenu", function(jobdata)
    -- DON'T SET THIS TO TRUE
    local SocietyOptions = {
        wash = false
    }

    if ESX.PlayerData.job and ESX.PlayerData.job.grade_name == "boss" then 
        ESX.UI.Menu.CloseAll()

        TriggerEvent('esx_society:openBossMenu', jobdata, function(data, menu)
            menu.close()
        end, SocietyOptions)
    else
        TriggerEvent('mythic_notify:client:SendAlert', {type = 'error', text = _U('not_boss'), length = 2500})
    end
end)

AddEventHandler('mafias:openCloakroom', function()
    local elements = {
        {label = _U('player_clothes'), value = 'player_dressing'},
        {label = _U('remove_cloth'), value = 'remove_cloth'}
    }

	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Cloakroom', {
		title    = _U('cloakroom'),
		align    = 'bottom-right',
		elements = elements
	},	function(data, menu)
		if data.current.value == 'player_dressing' then

            ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerDressing', function(dressing)
				local elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing', {
					title    = _U('player_clothes'),
					align    = 'bottom-right',
					elements = elements
				}, function(data2, menu2)
					TriggerEvent('skinchanger:getSkin', function(skin)
						ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerOutfit', function(clothes)
							TriggerEvent('skinchanger:loadClothes', skin, clothes)
							TriggerEvent('esx_skin:setLastSkin', skin)

							TriggerEvent('skinchanger:getSkin', function(skin)
								TriggerServerEvent('esx_skin:save', skin)
							end)
						end, data2.current.value)
					end)
				end, function(data2, menu2)
					menu2.close()
				end)
			end)
		elseif data.current.value == 'remove_cloth' then
			ESX.TriggerServerCallback('esx_property:getPlayerDressing', function(dressing)
				local elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_cloth', {
					title = _U('remove_cloth'),
					align = 'bottom-right',
					elements = elements
				}, function(data2, menu2)
					menu2.close()
					TriggerServerEvent('esx_property:removeOutfit', data2.current.value)
					ESX.ShowNotification(_U('removed_cloth'))
				end, function(data2, menu2)
					menu2.close()
				end)
			end)
		end
	end, function(data, menu)
        menu.close()
    end)
end)

AddEventHandler('mafias:openArmory', function(invdata)
    local setString = 'society_' .. invdata
    TriggerEvent("esx_inventoryhud:openStorageInventory", setString)
end)