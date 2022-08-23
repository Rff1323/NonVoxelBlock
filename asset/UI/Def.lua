print("startup ui")

local btn1 = self:child("Indicator")

btn1.onMouseClick = function ()
  --PackageHandlers.sendClientHandler("ShowIndicator")
  PackageHandlers.sendClientHandler("ShowIndicator")
end
--