require "lfs"
g_WorkRoot=lfs.currentdir()

function InitPath()
	package.path = g_WorkRoot .. "/?.lua;" .. package.path
	package.path = g_WorkRoot .. "/utils/?.lua;" .. package.path
	package.path = g_WorkRoot .. "/collector/?.lua;" .. package.path
	package.path = g_WorkRoot .. "/api/?.lua;" .. package.path
	package.path = g_WorkRoot .. "/database/?.lua;" .. package.path
	package.path = g_WorkRoot .. "/socket/?.lua;" .. package.path
end

InitPath()
require "errorDefination"
require "utils.init"
require "envLoader"
require "akashaConfig"
dlog.Init()
function Main()
	dlog.info("Akasha Started")
	env.LoadGlobalConfig("./akasha.conf")
end

function PMain()
	local cond,err = pcall(Main)
	if cond == false then
		dlog.error(err)
	end	
end

print("start....")

PMain()

-- local socket=require("socket")
-- print(socket._VERSION)
-- local sql=require("luasql.mysql")
-- local env=assert(sql.mysql())
-- local conn=assert(env:connect("cot2","root","]cotnetwork}","localhost",3306))
-- local cursor,errString=conn:execute([[select * from lumion_upfiles]])
-- local row=cursor:fetch({},"a")
-- while row do
	-- print(row.fileName)
	-- row=cursor:fetch(row,"a")
-- end
