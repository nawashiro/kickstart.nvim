return {
    "hrsh7th/nvim-cmp",
    version = '*',
    config = function()
        local cmp = require("cmp")

        cmp.setup({
            mapping = {
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif vim.fn["vsnip#available"](1) == 1 then
                        feedkey("<Plug>(vsnip-expand-or-jump)", "")
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                        feedkey("<Plug>(vsnip-jump-prev)", "")
                    end
                end, { "i", "s" }),

                -- ドキュメントスクロール
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),

                -- 補完のトリガ / キャンセル / 確定
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            },
        })
    end,
}