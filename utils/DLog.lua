dlog={}
dlog.header=function() return "" end     --Ĭ����HEADER
dlog.UseLog=true						 --Ĭ�Ϲر�Log����

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
  local OldPrint = _G.print
	_G.print=dlog.debug
end		


dlog.Init=function()
	local uin=[[akasha]]
	dglogfileName=[[./Log/]]..uin..[[.log]] 
	dglogfile=io.open(dglogfileName,"w") --��Ҫ��Ϊ�˴����ļ�
	if dglogfile~=nil then
		dglogfile:close()	
	end
	TimeLogFileName=GetTimeLogFileName(uin)
	dgtimelogfile=io.open(TimeLogFileName,"a") --��Ҫ��Ϊ�˴����ļ�
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

----------����豸-----------
FileDevice={}
FileDevice.output=function(Msg,szFileName)
	local Time=os.date("%X",os.time())
	Msg= Time .. Msg .. "\n"
	OutputFile=io.open(szFileName,"a")
	if OutputFile~=nil then
		OutputFile:write(Msg)
		OutputFile:flush()
		OutputFile:close()
	end
end

----------dlogģ��-------------
doutput={}
doutput.__call=function(self,...)
	if self.show then
		local szMsg = {...}
		if #szMsg == 0 then
		  return
		end
		local Msg=self.keyword
		for i=1,#szMsg do
		  Msg = Msg .. tostring(szMsg[i])
		end
		local FileLogHeader=dlog.header()
		Msg=FileLogHeader .. Msg
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
dlog.warning.keyword="[Warning]"
setmetatable(dlog.warning,doutput)

dlog.debug={}
dlog.debug.show=true
dlog.debug.keyword="[Debug]"
setmetatable(dlog.debug,doutput)

dlog.info={}
dlog.info.show=true
dlog.info.keyword="[Log]"
setmetatable(dlog.info,doutput)

