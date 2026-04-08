local keys = require("snacks_config.keys")
local configuration = require("snacks_config.configuration")
local dashboard = require("snacks_config.dashboard")
local notifier = require("snacks_config.notifier")

return {
  keys = keys,
  configuration = configuration,
  dashboard = dashboard,
  notifier = notifier,
}
