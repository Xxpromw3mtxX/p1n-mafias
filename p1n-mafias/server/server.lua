function getMaximumGrade(jobname)
    local result = MySQL.Sync.fetchAll("SELECT * FROM job_grades WHERE job_name=@jobname  ORDER BY `grade` DESC ;", {
        ['@jobname'] = jobname
    })
    if result[1] ~= nil then
        return result[1].grade
    end
    return nil
end


RegisterServerEvent('mafias:promote')
AddEventHandler('mafias:promote', function(target)

  local _source = source

  local sourceXPlayer = ESX.GetPlayerFromId(_source)
  local targetXPlayer = ESX.GetPlayerFromId(target)
  local maximumgrade = tonumber(getMaximumGrade(sourceXPlayer.job.name)) -1 

  if(targetXPlayer.job.grade == maximumgrade)then
    TriggerClientEvent('esx:showNotification', _source, _U('gov_auth'))
  else
    if(sourceXPlayer.job.name == targetXPlayer.job.name)then

      local grade = tonumber(targetXPlayer.job.grade) + 1 
      local job = targetXPlayer.job.name

      targetXPlayer.setJob(job, grade)

      TriggerClientEvent('esx:showNotification', _source, _U('promotion', targetXPlayer.name))
      TriggerClientEvent('esx:showNotification', target, _U('promoted', sourceXPlayer.name))		

    else
      TriggerClientEvent('esx:showNotification', _source, _U('no_perm'))
    end

  end 
    
end)

RegisterServerEvent('mafias:descend')
AddEventHandler('mafias:descend', function(target)

  local _source = source

  local sourceXPlayer = ESX.GetPlayerFromId(_source)
  local targetXPlayer = ESX.GetPlayerFromId(target)

  if(targetXPlayer.job.grade == 0)then
    TriggerClientEvent('esx:showNotification', _source, "Non puoi degradare di più.")
  else
    if(sourceXPlayer.job.name == targetXPlayer.job.name)then

      local grade = tonumber(targetXPlayer.job.grade) - 1 
      local job = targetXPlayer.job.name

      targetXPlayer.setJob(job, grade)

      TriggerClientEvent('esx:showNotification', _source, _U('degrade', targetXPlayer.name))
      TriggerClientEvent('esx:showNotification', target, _U('degraded', sourceXPlayer.name))

    else
      TriggerClientEvent('esx:showNotification', _source, _U('no_perm'))

    end

  end 
    
end)

RegisterServerEvent('mafias:recruit')
AddEventHandler('mafias:recruit', function(target, job, grade)

  local _source = source

  local sourceXPlayer = ESX.GetPlayerFromId(_source)
  local targetXPlayer = ESX.GetPlayerFromId(target)
  
    targetXPlayer.setJob(job, grade)

    TriggerClientEvent('esx:showNotification', _source, _U('recruit', targetXPlayer.name))
    TriggerClientEvent('esx:showNotification', target, _U('recruited', sourceXPlayer.name))

end)

RegisterServerEvent('mafias:fire')
AddEventHandler('mafias:fire', function(target)

  local _source = source

  local sourceXPlayer = ESX.GetPlayerFromId(_source)
  local targetXPlayer = ESX.GetPlayerFromId(target)
  local job = "unemployed"
  local grade = "0"

  if(sourceXPlayer.job.name == targetXPlayer.job.name)then
    targetXPlayer.setJob(job, grade)

    TriggerClientEvent('esx:showNotification', _source, _U('fire', targetXPlayer.name))
    TriggerClientEvent('esx:showNotification', target, _U('fired', sourceXPlayer.name))	
  else

    TriggerClientEvent('esx:showNotification', _source, _U('no_perm'))

  end

end)