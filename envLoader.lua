module("env",package.seeall)

function LoadGlobalConfig(strPath)
    local conFile,msg=io.open(strPath,"r")
    if conFile==nil then
        dlog.error(dberr.loadConfFileError+":"+msg)
        return nil
    end
    dlog.info("load Global Config File: " .. strPath .. " success")
    g_Env=GenTableFromConfigFile(conFile)
    print "---------g_Env--------"
    for key, value in pairs(g_Env) do
        print(key .. "=" .. value)
    end
    print "----------------------"
    dlog.info("Load Global Config File Done")
end