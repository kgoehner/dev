local work = require("utils.work")

if not work.is_work_machine() then return {} end

return {
  {
    name = 'amazonq',
    url = 'ssh://git.amazon.com/pkg/AmazonQNVim',
    opts = {
      ssoStartUrl = 'https://amzn.awsapps.com/start',
    },
  },
}
