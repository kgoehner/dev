local M = {}

M.version = "1.0"

local function env_to_boolean(var_name)
  local value = os.getenv(var_name)

  if value == nil then
    return false
  else
    local lower_value = string.lower(value)
    if lower_value == "true" or lower_value == "1" then
      return true
    elseif lower_value == "false" or lower_value == "0" then
      return false
    else
      return value ~= ""
    end
  end
end

function M.is_work_machine()
    return env_to_boolean("KGOEHNER_IS_WORK_MACHINE")
end

return M
