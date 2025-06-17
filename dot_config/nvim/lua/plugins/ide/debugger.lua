-- vim: ts=2 sts=2 sw=2 et

-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

local debuggers = {
  "delve",    -- Go debugger
  "cpptools", -- C/C++ debugger
}

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    -- Creates a beautiful debugger UI
    "rcarriga/nvim-dap-ui",
    -- Required dependency for nvim-dap-ui
    "nvim-neotest/nvim-nio",
    -- Installs the debug adapters for you
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    -- Add your own debuggers here
    "leoluz/nvim-dap-go",
    -- Shows variable values inline as virtual text
    'theHamsta/nvim-dap-virtual-text',
  },
  keys = function(_, keys)
    local dap = require("dap")
    local dapui = require("dapui")
    return {
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      { "<F9>",   dapui.toggle,          desc = "Debug: See last session result." },
      -- Basic debugging keymaps, feel free to change to your liking!
      { "<F5>",   dap.continue,          desc = "Debug: Start/Continue" },
      { "<S-F5>", dap.stop,              desc = "Debug: Stop" },
      { "<F6>",   dap.step_over,         desc = "Debug: Step Over" },
      { "<F7>",   dap.step_into,         desc = "Debug: Step Into" },
      { "<S-F7>", dap.step_out,          desc = "Debug: Step Out" },
      { "<F8>",   dap.toggle_breakpoint, desc = "Debug: Toggle Breakpoint" },
      {
        "<S-F8>",
        function()
          dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Debug: Set Breakpoint based on condition",
      },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      automatic_installation = true,
      handlers = {},
      ensure_installed = debuggers,
    })

    -- For more information, see |:help nvim-dap-ui|
    dapui.setup({
      icons = State.icons.dap.icons,
      controls = State.icons.dap.controls,
    })

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    require('dap-go').setup({
      delve = {
        -- Use Mason's delve installation with fallback to system delve
        path = function()
          local mason_delve = vim.fn.stdpath("data") .. "/mason/bin/dlv"
          if vim.fn.executable(mason_delve) == 1 then
            return mason_delve
          end
          -- Fallback to system delve
          return vim.fn.exepath("dlv") ~= "" and vim.fn.exepath("dlv") or "dlv"
        end,

        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        -- detached = vim.fn.has 'win32' == 0,
      }
    })
  end,
}
