package = "lua-ssm"
version = "0.0.1-1"
source = {
   url = "https://github.com/ssm-lang/lua-ssm",
}
description = {
   summary = "Sparse synchronous model in Lua",
   homepage = "https://github.com/ssm-lang/lua-ssm",
   license = "MIT",
   maintainer = "John Hui <j-hui@cs.columbia.edu>",
}
dependencies = {
   "lua >= 5.1, < 5.5",
}
build = {
   type = "builtin",
   modules = {
      ssm = "lua/ssm.lua",
      ["ssm.backend.luv"] = "lua/ssm/backend/luv.lua",
      ["ssm.backend.simulation"] = "lua/ssm/backend/simulation.lua",
      ["ssm.core"] = "lua/ssm/core.lua",
      ["ssm.dbg"] = "lua/ssm/dbg.lua",
      ["ssm.lib.Priority"] = "lua/ssm/lib/Priority.lua",
      ["ssm.lib.PriorityQueue"] = "lua/ssm/lib/PriorityQueue.lua",
      ["ssm.lib.lua"] = "lua/ssm/lib/lua.lua",
   }
}
