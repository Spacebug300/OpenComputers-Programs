local c = require("component")
local r = require("robot")
local term = require("term")
local sides = require("sides")
term.clear()
print("Farming Program v1.0.0")

local getCrops = {...}

if getCrops[1] == nil then
  print("Usage: farm <# of crops in a row> <# of rows>")
  os.sleep(3)
  term.clear()
  return false
elseif getCrops[2] == nil then
  print("Usage: farm <# of crops in a row> <# of rows>")
  os.sleep(3)
  term.clear()
  return false
end

local crops = tonumber(getCrops[1])
local getRows = tonumber(getCrops[2])
local rows = getRows * 2
local returnDistance = getRows * 3


local function checkForPoison()
  local itemInfo = {c.inventory_controller.getStackInInternalSlot(1), c.inventory_controller.getStackInInternalSlot(2), c.inventory_controller.getStackInInternalSlot(3), c.inventory_controller.getStackInInternalSlot(4), c.inventory_controller.getStackInInternalSlot(5), c.inventory_controller.getStackInInternalSlot(6), c.inventory_controller.getStackInInternalSlot(7), c.inventory_controller.getStackInInternalSlot(8)}
  local poisonDetected = "Poisonous potato detected in inventory! Throwing it out."

  if itemInfo[1]["name"] == "minecraft:poisonous_potato" then
    print(poisonDetected)
    r.select(1)
    r.drop()
  elseif itemInfo[2]["name"] == "minecraft:poisonous_potato" then
    print(poisonDetected)
    r.select(2)
    r.drop()
  elseif itemInfo[3]["name"] == "minecraft:poisonous_potato" then
    print(poisonDetected)
    r.select(3)
    r.drop()
  elseif itemInfo[4]["name"] == "minecraft:poisonous_potato" then
    print(poisonDetected)
    r.select(4)
    r.drop()
  elseif itemInfo[5]["name"] == "minecraft:poisonous_potato" then
    print(poisonDetected)
    r.select(5)
    r.drop()
  elseif itemInfo[6]["name"] == "minecraft:poisonous_potato" then
    print(poisonDetected)
    r.select(6)
    r.drop()
  elseif itemInfo[7]["name"] == "minecraft:poisonous_potato" then
    print(poisonDetected)
    r.select(7)
    r.drop()
  elseif itemInfo[8]["name"] == "minecraft:poisonous_potato" then
    print(poisonDetected)
    r.select(8)
    r.drop()
  end 

  return false
end

local function harvestCrop()
  r.swingDown()
  checkForPoison()
  r.select(1)
  c.inventory_controller.equip()
  r.useDown()
  return false
end

local function farmCrops()
  print("Harvesting crops in this row")
  local harvested = 0
  
  while harvested < crops do
    r.forward()
    harvestCrop()
    harvested = harvested + 1
  end

  print("Row harvested, moving onto next row...")
  return false
end

local leftOrRight = 2
local function nextRow()
  if leftOrRight == 2 then
    r.forward()
    r.turnLeft()
    r.forward()
    r.turnLeft()
    leftOrRight = leftOrRight - 1
  elseif leftOrRight == 1 then
    r.forward()
    r.turnRight()
    r.forward()
    r.forward()
    r.turnRight()
    leftOrRight = leftOrRight + 1
  end
end

local function returnToStart()
  r.turnRight()
 
  while returnDistance > 0 do
    r.forward()
    returnDistance = returnDistance - 1
  end
  r.turnRight()
  return false
end

local invSlot = 1
local function dropItems()
  while invSlot < 17 do
    r.select(invSlot)
    c.inventory_controller.dropIntoSlot(sides.front, invSlot, 64)
    invSlot = invSlot + 1
  end
  r.select(1)
  c.inventory_controller.equip()
  c.inventory_controller.dropIntoSlot(sides.front, invSlot, 64)
end

r.up()
while rows > 0 do
  farmCrops()
  nextRow()

  rows = rows - 1
end
r.down()
print("All rows harvested and replanted, returning to starting position.")
os.sleep(3)
returnToStart()
dropItems()
r.turnAround()
term.clear()
