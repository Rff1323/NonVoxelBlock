print('script_client:hello world')

UI:openWindow("UI/Def")

local ClientBuilder = require "script_client.ClientBuilder"

ClientBuilder:Start()

World.Timer(10, function()
    --local guiMgr = GUIManager:Instance()
	--local window = UI:openWindow("")
end)