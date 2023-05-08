-- set a fallback
function ColorFallback(color)
    color = color or "sonokai"
    vim.cmd.colorscheme(color)

    -- set tranparent background
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorFallback()
