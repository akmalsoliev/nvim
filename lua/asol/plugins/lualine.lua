local colors = {
  -- Main colors
  normal_fg = "#CCD5E5",
  normal_bg = "#191d23",
  panel_bg = "#1B1F25",
  float_bg = "#1C2127",
  normal_bg_alt = "#20252E",
  normal_bg_accent = "#242932",
  comment_fg = "#474B65",
  nontext_fg = "#363848",

  -- Accent colors
  important = "#6A8BE3",
  keyword = "#A9B9EF",
  constant = "#BCB6EC",
  string = "#74BAA8",
  cursor = "#5DCD9A",
  search = "#E9B872",
  number = "#B85B53",

  -- Status colors
  info = "#1A8C9B",
  warn = "#FFA630",
  error = "#F71735",

  -- Git colors
  git_add_col = "#366A4C",
  git_change_col = "#3F58BB",
  git_delete_col = "#942B27",
}

local custom_theme = {
  normal = {
    a = { fg = colors.normal_bg, bg = colors.important },
    b = { fg = colors.normal_fg, bg = colors.normal_bg_alt },
    c = { fg = colors.normal_fg, bg = colors.normal_bg },
  },

  insert = {
    a = { fg = colors.normal_bg, bg = colors.string },
  },

  visual = {
    a = { fg = colors.normal_bg, bg = colors.constant },
  },

  replace = {
    a = { fg = colors.normal_bg, bg = colors.number },
  },

  command = {
    a = { fg = colors.normal_bg, bg = colors.search },
  },

  inactive = {
    a = { fg = colors.comment_fg, bg = colors.panel_bg },
    b = { fg = colors.comment_fg, bg = colors.panel_bg },
    c = { fg = colors.comment_fg, bg = colors.normal_bg },
  },
}

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = custom_theme,
      component_separators = "",
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = { "filetype" },
      lualine_y = { "progress" },
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = { "nvim-tree" },
  },
  dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
}
