dlog={}
dlog.header=function() return "" end     --默认无HEADER
dlog.UseLog=true						 --默认关闭Log开关

local OldPrint=nil

local function GetTimeLogFileName(uin)
	local CurDate=os.date("*t",os.time())
	local CurDateStr=CurDate.month .. [[-]] .. CurDate.day 
	local TimeLogFilePath=[[./Log/]]..uin..[[_]]..CurDateStr .. [[.log]]
	return TimeLogFilePath 
end

local dglogfileName=nil
local dglogfile=nil
local TimeLogFileName=nil
local dgtimelogfile=nil

dlog.HookPrint= function()
	OldPrint = _G.print
	_G.print=dlog.debug
end


dlog.Init=function()
	local uin=[[akasha]]
	lfs.mkdir("./Log")
	dglogfileName=[[./Log/]]..uin..[[.log]]
	dglogfile=io.open(dglogfileName,"w") --主要是为了创建文件
	if dglogfile~=nil then
		dglogfile:close()
	end
	TimeLogFileName=GetTimeLogFileName(uin)
	dgtimelogfile=io.open(TimeLogFileName,"a") --主要是为了创建文件
	if dgtimelogfile~=nil then
		dgtimelogfile:close()
	end	
	dlog.HookPrint()
	if dlog.UseLog==false then
		--dlog.error.show=false
		dlog.debug.show=false
		dlog.warning.show=false
		dlog.info.show=false
	end
end

----------输出设备-----------
FileDevice={}
FileDevice.output=function(Msg,szFileName)
	local Msg=Msg .. "\n"
	OutputFile=io.open(szFileName,"a")
	if OutputFile~=nil then
		OutputFile:write(Msg)
		OutputFile:flush()
		OutputFile:close()
	end
end

----------dlog模块-------------
doutput={}
doutput.__call=function(self,...)
	if self.show then
		local szMsg = {...}
		if #szMsg == 0 then
		  return
		end
		local Msg=""
		local PureMsg=""
		for i=1,#szMsg do
		  PureMsg = PureMsg .. tostring(szMsg[i])
		end
		local Time=os.date("%X",os.time())
		Msg=Time .. " " .. self.keyword .. ":" .. PureMsg
		OldPrint(Msg)
		FileDevice.output(Msg,dglogfileName)
		FileDevice.output(Msg,TimeLogFileName)	
	end
end

dlog.error={}
dlog.error.show=true
dlog.error.keyword="[Error]"
setmetatable(dlog.error,doutput)

dlog.warning={}
dlog.warning.show=true
dlog.warning.keyword="[Warn]"
setmetatable(dlog.warning,doutput)

dlog.debug={}
dlog.debug.show=true
dlog.debug.keyword="[Debug]"
setmetatable(dlog.debug,doutput)

dlog.info={}
dlog.info.show=true
dlog.info.keyword="[Log]"
setmetatable(dlog.info,doutput)

