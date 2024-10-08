-- Define a global function that takes an argument
function Greet(name)
    print("Hello, " .. name .. "!")
    vim.notify('Loaded script: ' .. name, vim.log.levels.WARN)
    vim.notify('Loaded script: ' .. name, vim.log.levels.INFO)
end

-- Create a user command that takes an argument
vim.api.nvim_create_user_command('GreetUser',
function(opts)
    Greet(opts.args)
end, { nargs = 1 })  -- 'nargs = 1' means it takes one argument