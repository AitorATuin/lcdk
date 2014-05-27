local MkModule = {}

local function file_exists (file)
    local fd = io.open(file)
    if not fd then
        return false
    end
    fd:close()
    return true
end

libs = {
   nWrapper = "NSWRAPPER",
   asasad = "NSWRAPPER"

}

local function alienize (libname, env)
    local paths = {
        os.getenv(env or "") or "./",
        os.getenv("HOME") .. "/.lua/lib/",
    }
    local success, lib, o = pcall(aliend.load, libname)
    if lib then return lib end
    for p in package.cpath:gmatch("[^;]+") do
        paths[#paths+1] = p:match("(.+)/+[^/]+$")
    end
--    local lib, success
    local str = ""
    for _, p in ipairs(paths) do
        local file = p .. "/" .. libname
        if file_exists(file) then
            success, lib, o = pcall(alien.load,
                p.."/"..libname)
            if success then
                return lib
            else
                return nil, string.format("Could not open file %s: %s",
                    file, lib)
            end
        end
    end
    return nil, string.format("Could not found file %s", libname)
end

MkModule.make = function (conf)
   local L = {}
   local M = {}
   M.configure = function ()
      for i, lconf in pairs(conf.libraries) do
         local lib, err = alienize(lconf.libname, lconf.env)
         if not lib then
            error(err)
         end
         L[lconf.name] = lib
      end
      -- Perform custom initialization
      (conf.init or function () end)()
      -- Configure bindings
      if (conf.bindings) then
         for lib, bindings in pairs(conf.bindings) do
            for m, v in pairs(bindings) do
               L[lib][m]:types(v) -- configure binding types
               M[v.rename or m] = L[lib] -- add to module
            end
         end
      end
      -- return new module
      return setmetatable(M, {
                             __index = conf.methods
      })
   end
   return M
end

return MkModule
