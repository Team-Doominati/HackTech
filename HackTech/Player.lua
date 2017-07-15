local player =
{
    name = "Hacker",
    
    health =
    {
        mental = 100,
        mentalMax = 100,
        physical = 100,
        physicalMax = 100
    },
    
    stats =
    {
        level = 0,
        XP = 0,
        points = 0,
        
        attack = 0,
        defense = 0,
        stealth = 0,
        analysis = 0,
        programming = 0,
        engineering = 0,
        negotiation = 0
    },

    rep =
    {
        level = 0,
        XP = 0,
    },
    
    credits = 0,
    
    payment =
    {
        living = 500,
        software = 0,
        hardware = 0,
        medical = 0,
        fine = 0
    },
    
    mission = {},
    
    project =
    {
    }
}

function player.addXP(amount)
    player.stats.XP = player.stats.XP + amount
    
    if player.stats.XP >= player.getLevelNext() then
        player.stats.level = player.stats.level + 1
        player.stats.points = player.stats.points + 1
    end
end

function player.addRep(amount)
    if player.rep.XP < player.getRepNext() then
        player.rep.XP = player.rep.XP + amount
        
        if player.rep.XP >= player.getRepNext() then
            player.rep.XP = player.getRepNext()
        end
    end
end

function player.addPayment(type, amount)
    player.payment[type] = player.payment[type] + amount
end

function player.upgradeRep()
    if player.rep.XP >= player.getRepNext() then
        player.rep.level = player.rep.level + 1
    end
end

function player.upgradeStat(type)
    if player.canUpgradeStat(type) then
        player.stats.points = player.stats.points - (player.stats[type] + 1)
        player.stats[type] = player.stats[type] + 1
        
        if type == "defense" then
            player.health.mental = player.health.mental + 10
            player.health.mentalMax = player.health.mentalMax + 10
            player.health.physical = player.health.physical + 10
            player.health.physicalMax = player.health.physicalMax + 10
        end
    end
end

function player.canUpgradeStat(type)
    return player.stats.points >= player.stats[type] + 1
end

function player.startProject(type, level)
    -- tODO
end

function player.advanceDay()
    ht.day = ht.day + 1
    
    if player.mission ~= nil and player.mission.accepted then
        if player.mission.deadline == ht.day then
            Mission.abandon()
        end
    end
    
    if player.getPaymentDays == 0 then
        local payment = palyer.getTotalPayment()
        
        player.credits = player.credits - payment
        
        if player.credits <= -10000 then
            -- TODO: Game over
        end
    end
end

function player.getLevelNext()
    return (player.stats.level + 1) * 100
end

function player.getRepNext()
    return (player.rep.level + 1) * 10
end

function player.getTotalPayment()
    local total = 0
    
    for key, amount in pairs(player.payment) do
        total = total + amount
    end
    
    return total
end

function player.getPaymentDays()
    return 30 - ht.day % 30
end

function player.damage(ment, phys)
    ment = ment or 0
    phys = phys or 0
    
    player.health.mental = player.health.mental - ment
    player.health.physical = player.health.physical - phys
    
    if player.health.mental <= 0 or player.health.physical <= 0 then
        -- TODO: Game over
    end
end

return player
