local M = {}

local sched = require("ssm.core.sched")
local Process = require("ssm.core.Process")
local Time = require("ssm.core.Time")

function Tick()
  local now = sched.advanceTime()

  if now == Time.NEVER then
    return false
  end

  for c in sched.scheduledEvents() do
    c:update()
  end

  for p in sched.scheduledProcesses() do
    Process.continue(p)
  end

  return true
end

return M
