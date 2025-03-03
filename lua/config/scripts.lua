-- vim.cmd('runtime! lua/scripts/**/*.lua')

local function load_lua_files_from_dir(dir)
    local files = vim.fn.readdir(dir)
    for _, file in ipairs(files) do
        if file:match('%.lua$') then -- match lua files only
            local fpath = 'scripts.' .. file:gsub('%.lua$', '')
            require(fpath)
        end
    end
end

local dir = vim.fn.stdpath('config') .. '/lua/scripts'
load_lua_files_from_dir(dir)

-- vim: ts=2 sts=2 sw=2 et
