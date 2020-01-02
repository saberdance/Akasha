
module("Course",package.seeall)
function Stop()
  gWorld:StopAI()
end
function Start(func,...)
	gWorld:StartFunc(func,...)
end
