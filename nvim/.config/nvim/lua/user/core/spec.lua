LAZY_PLUGIN_SPEC = {}

-- for better management of plugins
function Spec(item)
  table.insert(LAZY_PLUGIN_SPEC, { import = item })
end
