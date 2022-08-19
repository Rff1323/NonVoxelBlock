print("startup ui")

local btn = self:child("Submit")
local editBox = self:child("Editbox")
local text = self:child("Text")
local btn1 = self:child("Indicator")
local yawText = self:child("Text1")

btn.onMouseClick = function ()
  print(Global.Function:Round(123.454))
  
  local num = Global.Function:Round(tonumber(editBox.Text))
  
  text.Text = tostring(num)
end

btn1.onMouseClick = function ()
  --PackageHandlers.sendClientHandler("ShowIndicator")
  PackageHandlers.sendClientHandler("ShowIndicator")
end
--
Lib.subscribeEvent("UpdateYawText",function(yaw,pitch)
  yawText.Text = "Yaw: "..tostring(yaw).."\n".."Pitch: "..tostring(pitch)
end)
--
