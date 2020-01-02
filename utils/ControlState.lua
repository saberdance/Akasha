--require "ClassBase"
ControlState=DClass()
local GlobalThreadTable = {}
ControlState.Ctor=function(self,name)
	self.Name = name
	self.FunctionObj = nil
	self.Coroutine = nil
	self.SleepTime = 0
	self.StartSleepTime = 0
	self.ActionStack = {}
	self.Enable = true
end
ControlState.Clear = function(self,name)
	self.Name = name
  self.FunctionObj = nil
	self.Coroutine = nil
	self.SleepTime = 0
	self.StartSleepTime = 0
	self.ActionStack = {}
	self.Enable = true
end
ControlState.CreateThread = function(self)
  if GlobalThreadTable[self.Coroutine] ~= nil then
    GlobalThreadTable[self.Coroutine] = nil
  end
	self.Coroutine = coroutine.create(self.FunctionObj)
  GlobalThreadTable[self.Coroutine] = self
end
ControlState.Start = function(self,func,...)
	self:Stop()
	print(self.Name.." Started...")
	local arg={...}
	local pfunc=function() 
		local bOk, err= pcall(function() func(self,unpack(arg)) end )
		if bOk == false then
		  adb.Stack:Clear()
		end
	end
		--±£´æÆðÀ´ 
	self.FunctionObj=pfunc
	self:CreateThread()
end
ControlState.Stop = function(self)
	if self.Coroutine ~= nil then
		GlobalThreadTable[self.Coroutine] = nil
    self.Coroutine = nil
	end
end
ControlState.Finished = function(self)
	if self.Coroutine ~= nil then
		return coroutine.status(self.Coroutine) == "dead"
	end
	return true
end
ControlState.Restart = function(self)
	if self.FunctionObj ~= nil then
		--print(self.FunctionObj)
		self:Stop()
    self:CreateThread()
	end
end

function ControlState.tick()
	return os.clock()*1000
end

ControlState.Sleep = function(self,ms)
	ms = ms or 20
	self.SleepTime = ms
	self.StartSleepTime = self:tick()
	coroutine.yield()
end
ControlState.Resume = function(self)
	if self.Coroutine == nil or self:Finished() then
		return
	end
	coroutine.resume(self.Coroutine)
end

ControlState.RunOnce = function(self)
	local deltaTime = self:tick() - self.StartSleepTime
	if deltaTime>=self.SleepTime then
		self:Resume(false)
	end
end
CurrentState = function()
  return GlobalThreadTable[coroutine.running()]
end
GSleep = function(ms)
	local targetState = CurrentState()
  if targetState == nil then
    error("GSleep")
    return
  end
  targetState:Sleep(ms)
end