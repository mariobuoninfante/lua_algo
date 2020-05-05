local sort = require("Sort")

math.randomseed(os.time())  -- 'random' seed

local function rand_table_gen()
    -- random table generator
    outcome = {}
    local _start = 5
    local _length = math.random(_start, 25)
    local _end = _start + _length
    for i = 1, _length do 
        outcome[i] = math.random(100)
    end
    return outcome
end

local function print_table(T)
    for _, i in ipairs(T) do 
        io.write(i, " ")
    end
    io.write("\n")
end

local r_table = rand_table_gen()
print_table(r_table)
-- sort.selection(r_table, 0)  -- 2nd arg: 0/1 ascending/descending order
-- sort.insertion(r_table, 1)  -- 2nd arg: 0/1 ascending/descending order
-- sort.shell(r_table, 0)  -- 2nd arg: 0/1 ascending/descending order
sort.mergesort(r_table, 1)  -- 2nd arg: 0/1 ascending/descending order
print_table(r_table)
