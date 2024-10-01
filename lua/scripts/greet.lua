-- format.lua


-- Define a simple Lua function
function greet()
    print("Hello, Neovim!")
end


-- Create a command to call the greet function
vim.api.nvim_create_user_command('Greet', greet, {})





-- function format()
--     vim.cmd('silent !prettier --write %')
--     vim.cmd('edit!')
-- end
--
-- Alternativaly, if you're using VIM scripts, you could do
--
-- function! FormatBuffer()
--     execute 'silent !prettier --write %'
--     edit!
-- endfunction
--
--
-- nnoremap <Leader>f :call FormatBuffer()<CR>
--
-- OR
--
-- vim.api.nvim_set_keymap('n', '<Leader>f', ':lua FormatBuffer()<CR>', { noremap = true, silent = true })



-- vim.g.some_global_variable = {
--   key1 = "value",
--   key2 = 300
-- }

