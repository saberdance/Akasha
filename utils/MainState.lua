WorkState = ControlState:New("WorkState")
WorkState.CanActive = function(self)
	return true
end
WorkState.NeedActive = function(self)
	return true
end
--在WorkState下必须通过ActiveState命令显示指定要集合的下一个状态
WorkState.NextState = function(self)
	return nil
end
----------------------
EventState = ControlState:New("EventState")

EventState.CanActive = function(self)
	return true
end
EventState.NeedActive = function(self)
	return true
end
--在WorkState下必须通过ActiveState命令显示指定要集合的下一个状态
EventState.NextState = function(self)
	return nil
end

----------------------
ExceptionState = ControlState:New("ExceptionState")

ExceptionState.CanActive = function(self)
	return true
end
ExceptionState.NeedActive = function(self)
	return true
end
--在WorkState下必须通过ActiveState命令显示指定要集合的下一个状态
ExceptionState.NextState = function(self)
	return nil
end

-----------------------
ImmediatelyEventState = ControlState:New("ImmediatelyEventState")

ImmediatelyEventState.CanActive = function(self)
	return true
end
ImmediatelyEventState.NeedActive = function(self)
	return true
end
--在WorkState下必须通过ActiveState命令显示指定要集合的下一个状态
ImmediatelyEventState.NextState = function(self)
	return nil
end
