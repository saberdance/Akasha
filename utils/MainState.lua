WorkState = ControlState:New("WorkState")
WorkState.CanActive = function(self)
	return true
end
WorkState.NeedActive = function(self)
	return true
end
--��WorkState�±���ͨ��ActiveState������ʾָ��Ҫ���ϵ���һ��״̬
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
--��WorkState�±���ͨ��ActiveState������ʾָ��Ҫ���ϵ���һ��״̬
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
--��WorkState�±���ͨ��ActiveState������ʾָ��Ҫ���ϵ���һ��״̬
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
--��WorkState�±���ͨ��ActiveState������ʾָ��Ҫ���ϵ���һ��״̬
ImmediatelyEventState.NextState = function(self)
	return nil
end
