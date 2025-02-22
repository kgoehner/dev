return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    notifier = { enabled = true },
    statuscolumn = { enabled = true },
    gitbrowse = {
      notify = true,
      remote_patterns = {
        { "^(https?://.*)%.git$"                , "%1" },
        { "^git@(.+):(.+)%.git$"                , "https://%1/%2" },
        { "^git@(.+):(.+)$"                     , "https://%1/%2" },
        { "^git@(.+)/(.+)$"                     , "https://%1/%2" },
        { "^ssh://git@(.*)$"                    , "https://%1" },
        { "^ssh://git.amazon.com:2222/pkg/(.*)$", "code.amazon.com/packages/%1" },
        { "^ssh://([^:/]+)(:%d+)/(.*)$"         , "https://%1/%3" },
        { "^ssh://([^/]+)/(.*)$"                , "https://%1/%2" },
        { "ssh%.dev%.azure%.com/v3/(.*)/(.*)$"  , "dev.azure.com/%1/_git/%2" },
        { "^https://%w*@(.*)"                   , "https://%1" },
        { "^git@(.*)"                           , "https://%1" },
        { ":%d+"                                , "" },
        { "%.git$"                              , "" },
      },
      url_patterns = {
        ["github%.com"] = {
          branch = "/tree/{branch}",
          file = "/blob/{branch}/{file}#L{line_start}-L{line_end}",
          commit = "/commit/{commit}",
        },
        ["gitlab%.com"] = {
          branch = "/-/tree/{branch}",
          file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
          commit = "/-/commit/{commit}",
        },
        ["bitbucket%.org"] = {
          branch = "/src/{branch}",
          file = "/src/{branch}/{file}#lines-{line_start}-L{line_end}",
          commit = "/commits/{commit}",
        },
        ["code.amazon%.com"] = {
          branch = "/trees/heads/{branch}",
          file = "/blobs/{branch}/--/{file}#L{line_start}-L{line_end}",
          commit = "/commits/{commit}",
        },
      },
    },
  },
  keys = {
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
    { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    { "<leader>tt", function() Snacks.terminal() end, desc = "Toggle Terminal" },
    { "<leader>gl", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit" },
    { "<leader>gL", function() Snacks.lazygit.log() end, desc = "Lazygit" },
  }
}
