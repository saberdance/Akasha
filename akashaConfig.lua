--[[
全局配置表，以envLoader.LoadGlobalConfig读取akasha.conf初始化
]]--

g_Env={}

function MakeConfigKeyPair(strLine)
    local key=nil
    local value=nil
    if strLine~=nil and string.len(strLine)>0 then
        key=string.match(strLine,"%[[^%s]+%]=")
        if key==nil then
            return nil,nil
        end
        local startPos,endPos=string.find(strLine,key,1,true)
        value=string.sub(strLine,endPos+1)
        key=string.sub(key,2,string.len(key)-2)
        return key,value
    end
    return nil,nil
end

function GenTableFromConfigFile(luaFileObj)
    local cfgTable={}
    for line in luaFileObj:lines() do
        local key,value=MakeConfigKeyPair(line)
        if key==nil then
            dlog.error(gerr.loadConfigFileErr .. ":")
            dlog.error("Line: " .. line .. " Does Not Avalible")
        else
            print("Load Config:[" .. key .. "]=" .. tostring(value))
            cfgTable[key]=value
        end 
    end
    return cfgTable
end