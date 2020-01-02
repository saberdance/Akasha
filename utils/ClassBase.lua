DClass=function(parentClass)
	local class={}
 	class.__index=class
	if parentClass~=nil then
		setmetatable(class,parentClass)
		class.m_ParentClass=parentClass
	end
	
	class.New=function(self,...)
		local classObj={}
		setmetatable(classObj,self)
		assert(self.Ctor~=nil,"没有构造函数")
		classObj:Ctor(...)
		return classObj
	end
	class.ParentClass=function(self)
		return self.m_ParentClass
	end
	class.__call=function(self,...) 
		return self:DCall(...) 
	end
	return class
end