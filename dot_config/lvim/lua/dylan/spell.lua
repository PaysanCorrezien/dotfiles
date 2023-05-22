

-- vim.g.my_spellfile_path = "/home/dylan/.config/lvim/dict/spell.utf-8.add"
-- vim.g.my_ltexfile_path = "/home/dylan/.config/lvim/dict/ltex.dictionary.fr.txt"
vim.g.my_ltexfile_path = "/home/dylan/.local/share/chezmoi/dot_config/lvim/dict/ltex.dictionary.fr.txt"
vim.g.my_spellfile_path = "/home/dylan/.local/share/chezmoi/dot_config/lvim/dict/spell.utf-8.add"
--
-- local cmp = require("cmp")
-- local dictionary_cmp = require("DictionnaryCmp")
-- DictionnaryManager stuff
-- Add the autocommand for syncing on close
vim.cmd([[
  autocmd BufWritePost *.md lua require('DictionnaryManager').sync_on_close()
]])

-- spellchecker for markdown
vim.api.nvim_command("autocmd FileType markdown setlocal spell")
