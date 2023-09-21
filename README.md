# Impact.nvim

A simple test runner for Neovim. The plugin provides an easy way to run your current file or the entire test suite.

## Use case

Currently working on my Jest tests in `stuff.test.ts`. Instead of running those in a separate terminal, I can use Impact to run the current file with ease - either 
with a custom command or a keymap, or both if you are feeling fancy.

All I have to do is to add a runner for Jest on Typescript files:

```lua
impact.add_runner({
  filetypes = {
    "typescript"
  },
  commands = {
    file = "jest %",
    suite = "jest",
  }
})
```

## Installation

Use your favorite package manager.

```lua
use "sebkolind/impact.nvim"
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
vim.api.nvim_create_user_command("RunCurrentFile", "lua require('impact').run_current_file()")
vim.api.nvim_create_user_command("RunEntireSuite", "lua require('impact').run_entire_suite()")
```

## TODO

[] Run closest test based on cursor position

## Contribute

Feel free to contribute!
