local socket=require("socket")
print(socket._VERSION)
local sql=require("luasql.mysql")
local env=assert(sql.mysql())
local conn=assert(env:connect("cot2","root","]cotnetwork}","localhost",3306))
local cursor,errString=conn:execute([[select * from lumion_upfiles]])
local row=cursor:fetch({},"a")
while row do
	print(row.fileName)
	row=cursor:fetch(row,"a")
end
