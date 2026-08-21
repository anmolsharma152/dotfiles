return {
  -- Import official LazyVim language extras for full LSP, linter, and formatter support
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.yaml" },

  -- Ensure all core LSPs, linters, and formatters are auto-installed by Mason
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- Go
        "gopls",
        "gofumpt",
        "goimports",
        -- Python
        "pyright",
        "ruff",
        "black",
        -- JS / TS / HTML / CSS
        "vtsls",
        "prettier",
        "html-lsp",
        "css-lsp",
        "emmet-ls",
        -- Rust
        "rust-analyzer",
        -- Lua & Shell
        "stylua",
        "shfmt",
      })
    end,
  },

  -- Configure Treesitter parsers for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "go",
        "gomod",
        "gowork",
        "gotmpl",
        "python",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "rust",
        "ron",
        "lua",
        "markdown",
        "json",
        "yaml",
        "toml",
      })
    end,
  },

  -- Fine-tune gopls configuration to support external module navigation
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
                nilness = true,
              },
              gofumpt = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-node_modules" },
            },
          },
        },
      },
    },
  },
}
