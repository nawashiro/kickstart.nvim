return {
    "hrsh7th/nvim-vim.cmp",
    version = '*',
    
    mapping = {
        ["<Tab>"] = vim.cmp.mapping(function(fallback)
            if vim.cmp.visible() then
                vim.cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                vim.cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = vim.cmp.mapping(function()
            if vim.cmp.visible() then
                vim.cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, { "i", "s" }),
    },
}