if World.isClient then
require "script_client.main"
else
require "script_server.main"
end
require "script_common.main"

local Function = require "script_server.Function"

Global.Function = Function