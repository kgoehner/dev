return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    notifier = { enabled = true },
    remote_patterns = {
      { "^(https?://.*)%.git$"              , "%1" },
      { "^git@(.+):(.+)%.git$"              , "https://%1/%2" },
      { "^git@(.+):(.+)$"                   , "https://%1/%2" },
      { "^git@(.+)/(.+)$"                   , "https://%1/%2" },
      { "^ssh://git@(.*)$"                  , "https://%1" },
      { "^ssh://([^:/]+)(:%d+)/(.*)$"       , "https://%1/%3" },
      { "^ssh://([^/]+)/(.*)$"              , "https://%1/%2" },
      { "ssh%.dev%.azure%.com/v3/(.*)/(.*)$", "dev.azure.com/%1/_git/%2" },
      { "^https://%w*@(.*)"                 , "https://%1" },
      { "^git@(.*)"                         , "https://%1" },
      { ":%d+"                              , "" },
      { "%.git$"                            , "" },
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
    },
  },
  keys = {
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" }
  }
}
