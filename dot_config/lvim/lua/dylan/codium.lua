-- vim.keymap.set("i", "<C-a>", function()
--   return vim.fn["codeium#Accept"]()
-- end, { expr = true })

-- vim.keymap.set("i", "<c-k>", function()
--   return vim.fn["codeium#CycleCompletions"](1)
-- end, { expr = true })

-- vim.keymap.set("i", "<c-j>", function()
--   return vim.fn["codeium#CycleCompletions"](-1)
-- end, { expr = true })

-- vim.keymap.set("i", "<c-x>", function()
--   return vim.fn["codeium#Clear"]()
-- end, { expr = true })

-- codeium setup
-- table.insert(lvim.builtin.cmp.sources, { name = "dictionnary" })
-- lvim.builtin.cmp.formatting.source_names.dictionnary = "(Dictionnary)"
-- table.insert(lvim.builtin.cmp.sources, { name = "codeium" })
-- lvim.builtin.cmp.formatting.source_names.codeium = "(Codeium)"
-- local default_format = lvim.builtin.cmp.formatting.format
-- lvim.builtin.cmp.formatting.format = function(entry, vim_item)
-- 	vim_item = default_format(entry, vim_item)
-- 	if entry.source.name == "codeium" then
-- 		vim_item.kind = ""
-- 		vim_item.kind_hl_group = "CmpItemKindTabnine"
-- 	end
-- 	if entry.source.name == "spell" then
-- 		vim_item.kind = kind.cmp_kind.TypeParameter
-- 		vim_item.kind_hl_group = "CmpItemKindTabnine"
-- 	end
-- 	-- if entry.source.name == "Dictionnary" then
-- 	--   vim_item.kind = kind.icons.repo
-- 	--   vim_item.kind_hl_group = "CmpItemKindTabnine"
-- 	-- end
-- 	return vim_item
-- end

