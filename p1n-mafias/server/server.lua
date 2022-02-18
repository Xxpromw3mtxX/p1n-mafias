ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

for k,v in pairs(Config.mafias) do
    TriggerEvent('esx_society:registerSociety', v.name, v.label, 'society_'..v.job, 'society_'..v.job, 'society_'..v.job, {type = 'public'})
end