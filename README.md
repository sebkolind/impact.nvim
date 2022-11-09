# Impact.nvim

A simple test runner for Neovim.

## Installation

Use your favorite package manager.

```bash
require "paq" {
  "sebkolind/impact.nvim";
}
```

## Getting started

```lua
local impact = require("impact")

impact.setup({
  mode = "split", -- default, can be "vsplit"
  close_on_success = true, -- default
  save_before_run = true, -- default
  scroll_on_output = true, -- default
})

-- Add a runner for specific filetypes
impact.add_runner({
  filetypes ={
    "typescript"
  },
  commands = {
    file = "jest %", -- Used on require'impact'.run_current_file()
    suite = "jest", -- Used on require'impact'.run_entire_suite()
  }
})

-- Add some mappings of your taste
vim.keymap.set("n", "<Leader>t", impact.run_current_file, {})
vim.keymap.set("n", "<Leader>ts", impact.run_entire_suite, {})

-- Or add a command if that is your thing
vim.api.nvim_create_user_command("RunCurrentFile", "lua require'impact'.run_current_file()")
vim.api.nvim_create_user_command("RunEntireSuite", "lua require'impact'.run_entire_suite()")
```

## Contribute

Feel free to contribute!
