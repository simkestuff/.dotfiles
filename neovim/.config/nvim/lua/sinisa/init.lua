local M = {}

function M.statusline ()
   local parts = {
        -- [[%{luaeval("require'sinisa'.mode()")}]],
        -- [[%{FugitiveStatusline()} %{get(b:,'gitsigns_status','')} ]],
        [[%{FugitiveStatusline()} ]],
        [[%<%f %h%m%r%=%-14.(%l,%c%V%) %P]],
        -- [[%{luaeval("require'sinisa'.diagnostic_status()")}]],
        -- [[%= %<%f %h%m%r ]],
        -- [[%= %{&ff}|%{&fenc}|%{luaeval("require'sinisa'.get_filetype()")} %(%l,%c%V%) %P]],
    }

   return table.concat(parts, '')
end

function M.git_branch ()
    if vim.g.loaded_fugitive then
        local branch = vim.fn.FugitiveHead()
        if branch ~= '' then
            return " (" .. branch .. ")"
        end
    end
    return ''
end

function M.diagnostic_status()
    local count = {}
    local levels = {
        errors = "Error",
        warnings = "Warn",
        info = "Info",
        hints = "Hint",
    }

    for k, level in pairs(levels) do
        count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
    end

    local errors = ""
    local warnings = ""
    local hints = ""
    local info = ""

    if count["errors"] ~= 0 then
        errors = " E" .. count["errors"]
    end
    if count["warnings"] ~= 0 then
        warnings = " W" .. count["warnings"]
    end
    if count["hints"] ~= 0 then
        hints = " H" .. count["hints"]
    end
    if count["info"] ~= 0 then
        info = " I" .. count["info"]
    end

    return errors .. warnings .. hints .. info
end

local modes = {
    ["n"] = "NORMAL",
    ["no"] = "NORMAL",
    ["v"] = "VISUAL",
    ["V"] = "VISUAL LINE",
    [""] = "VISUAL BLOCK",
    ["s"] = "SELECT",
    ["S"] = "SELECT LINE",
    [""] = "SELECT BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rv"] = "VISUAL REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
}

function M.mode()
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format(" %s ", modes[current_mode]):upper()
end

function M.get_filetype()
  local filetype = vim.bo.filetype

  if filetype == '' then return '' end
  return string.format('%s', filetype):lower()
end

return M

