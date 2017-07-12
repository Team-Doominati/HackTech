local data =
{
    company = {}
}

function data.loadCompanies()
    local file = "Data/Company.dat"
    
    for line in io.lines(file) do
        if line ~= "" then
            table.insert(data.company, line)
        end
    end
    
    print("Company data loaded: " .. #data.company .. " total companies")
end

return data
