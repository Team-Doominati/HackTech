local table = {}

function table.init2DArray(size)
    local t = {}
    
    for i = 1, size do
        t[i] = {}
    end
    
    return t
end

function table.copy(o, seen)
    seen = seen or {} -- Cache
    
    if o == nil then
        return nil
    end
    
    if seen[o] then
        return seen[o]
    end

    local no
    
    if type(o) == 'table' then
        no = {}
        seen[o] = no
        
        for k, v in next, o, nil do
            no[table.copy(k, seen)] = table.copy(v, seen)
        end
        
        setmetatable(no, table.copy(getmetatable(o), seen))
    else -- number, string, boolean, etc
        no = o
    end
    
    return no
end

return table
