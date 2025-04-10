return {
  url = "ssh://git.amazon.com/pkg/NinjaHooks",
  branch = "mainline",
  -- This magic setup is copied from https://github.com/folke/lazy.nvim/issues/183#issuecomment-1376469054
  ft = "brazil-config",
  config = function(plugin)
    vim.opt.rtp:prepend(plugin.dir .. "/configuration/vim/amazon/brazil-config")
    require("lazy.core.loader").packadd(plugin.dir .. "/configuration/vim/amazon/brazil-config")
  end,
  init = function(plugin)
    require("lazy.core.loader").ftdetect(plugin.dir .. "/configuration/vim/amazon/brazil-config")
  end,
}
