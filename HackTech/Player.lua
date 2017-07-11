local player =
{
    name = "Hacker",
    
    level = 0,
    XP = 0,
    points = 0,
    
    rep = 0,
    repLevel = 0,
    
    attack = 0,
    defense = 0,
    stealth = 0,
    analysis = 0,
    programming = 0,
    engineering = 0,
    negotiation = 0,
    
    mentHealth = 100,
    physHealth = 100,
    
    credits = 0,
    
    payment =
    {
        living = 0,
        software = 0,
        hardware = 0,
        medical = 0,
        fine = 0
    }
}

function player.addXP(amount)
    player.XP = player.XP + amount
    
    if player.XP >= player.getLevelNext() then
        player.level = player.level + 1
        player.points = player.points + 1
    end
end

function player.addRep(amount)
    if player.rep < player.getRepNext() then
        player.rep = player.rep + amount
        
        if player.rep >= player.getRepNext() then
            player.rep = player.getRepNext()
        end
    end
end

function player.upgradeRep()
    if player.rep >= player.getRepNext() then
        player.repLevel = player.repLevel + 1
    end
end

function player.upgradeStat(type)
    if player.canUpgradeStat(type) then
        player.points = player.points - (player[type] + 1)
        player[type] = player[type] + 1
    end
end

function player.canUpgradeStat(type)
    return player.points >= player[type] + 1
end

function player.getLevelNext()
    return (player.level + 1) * 100
end

function player.getRepNext()
    return (player.repLevel + 1) * 10
end

function player.damage(ment, phys)
    ment = ment or 0
    phys = phys or 0
    
    player.mentHealth = player.mentHealth - ment
    player.physHealth = player.physHealth - phys
    
    if player.mentHealth <= 0 or player.physHealth <= 0 then
        -- TODO: Game over
    end
end

return player
