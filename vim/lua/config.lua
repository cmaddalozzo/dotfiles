local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    prompt_prefix = "🔎 ",
    selection_caret = "> ",
    mappings = {
      i = {
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-j>"] = actions.move_selection_next,
      }
    }
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      mappings = {
        ["i"] = {
          ["<C-e>"] = require("telescope").extensions.file_browser.actions.create,
        },
      },
    },
  },
}

require("telescope").load_extension "file_browser"

require("trouble").setup {}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}

require'neuron'.setup {
    virtual_titles = true,
    mappings = true,
    run = nil, -- function to run when in neuron dir
    neuron_dir = "~/Documents/Notes",
    leader = "gz", -- the leader key to for all mappings, remember with 'go zettel'
}
