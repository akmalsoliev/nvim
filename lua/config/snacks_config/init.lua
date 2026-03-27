local keys = require("config.snacks_config.keys")
local configuration = require("config.snacks_config.configuration")
local dashboard = require("config.snacks_config.dashboard")
local notifier = require("config.snacks_config.notifier")

return {
  keys = keys,
  configuration = configuration,
  dashboard = dashboard,
  notifier = notifier,
}
