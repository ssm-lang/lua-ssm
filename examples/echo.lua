local ssm = require("ssm") { backend = "luv" }

function ssm.pause(d)
  local t = ssm.Channel {}
  t:after(ssm.msec(d), { [1] = 1 })
  ssm.wait(t)
end

ssm.start(function()
  local stdin, stdout = ssm.io.get_stdin(), ssm.io.get_stdout()
  while ssm.wait(stdin) do
    if not stdin.data then
      break
    end
    local str = stdin.data
    ssm.pause(250)
    stdout.data = str
  end
  stdout.data = nil
end)
