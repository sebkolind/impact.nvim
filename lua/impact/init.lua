local M = {}

local config = {
  mode = "split", -- one of {split, vsplit}
  close_on_success = true,
  save_before_run = true,
  scroll_on_output = true,
}
local runners = {}

M.setup = function(user_config)
  if user_config == nil then
    return
  end

  for k in pairs(config) do
    if user_config[k] ~= nil then
      config[k] = user_config[k]
    end
  end
end

M.add_runner = function(runner_config)
  table.insert(runners, runner_config)
end

local function find_runner_and_run(command)
  if #runners == 0 then
    print("Impact: No runners found")
    return
  end

  for _, options in pairs(runners) do
    if options["filetypes"] == nil then
      return
    end

    for _, filetype in pairs(options["filetypes"]) do
      if filetype == vim.bo.filetype then
        if config.scroll_on_output then
          vim.api.nvim_command(
          "autocmd TermOpen * ++once :startinsert"
          )
        end

        vim.api.nvim_command(
        config.mode
        .. " | term "
        .. " "
        .. options.commands[command]
        )

        if config.close_on_success then
          local buffer_number = vim.api.nvim_get_current_buf()
          vim.api.nvim_command(
          "autocmd TermClose * ++once if !v:event.status | execute '.. bdelete! "
          .. buffer_number
          .. "' | endif"
          )
        end

        break
      end
    end
  end
end

M.run_current_file = function()
  if config.save_before_run then
    vim.api.nvim_command("write")
  end

  find_runner_and_run("file")
end

M.run_entire_suite = function()
  find_runner_and_run("suite")
end

return M
