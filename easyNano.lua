local term = require("term")
local component = require("component")
local modem = component.modem

modem.open(1)

function startScreen()
  term.clear()
  print("EasyNano Initiated. To exit, enter index number 000 and enter twice.")
  print("Enter Index #: ")
end

local running = true
local stopRunning = 000
while running do
  startScreen()

  local index = tonumber(term.read())

  if index == stopRunning then
    running = false
  end

  print("On(1) Or Off(0): ")
  local onOrOff = tonumber(term.read())

  if onOrOff == 1 then
    onOrOff = true
  elseif onOrOff == 0 then
    onOrOff = false
  else
    print("Invalid Sign")
    os.sleep(1)
  end

  modem.broadcast(1, "nanomachines", "setInput", index, onOrOff)
end
