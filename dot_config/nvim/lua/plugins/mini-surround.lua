return {
  "nvim-mini/mini.surround",
  version = "*",
  opts = {
    mappings = {
      add = "gsa", -- gsa" in visual mode, or gsaw) to add () around word
      delete = "gsd", -- gsd" to delete surrounding quotes
      find = "gsf", -- gsf) to find next )
      find_left = "gsF", -- gsF) to find previous )
      highlight = "gsh", -- gsh" to highlight surrounding quotes
      replace = "gsr", -- gsr"' to replace " with '
      update_n_lines = "gsn", -- Update search range

      suffix_last = "l", -- gsdl" to delete last/previous surrounding "
      suffix_next = "n", -- gsdn" to delete next surrounding "
    },
  },
}
