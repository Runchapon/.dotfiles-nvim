local M = {
  'LukasPietzschmann/telescope-tabs',
  dependencies = { 'nvim-telescope/telescope.nvim' },
}

M.config = function()
  require('telescope').load_extension 'telescope-tabs'
  require('telescope-tabs').setup {}
end

return M
