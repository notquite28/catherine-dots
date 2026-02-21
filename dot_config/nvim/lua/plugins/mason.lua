return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- Lua
        "stylua",

        -- Python: formatters, linters, type checkers
        "black",          -- formatter
        "isort",          -- import sorter
        "ruff",           -- fast linter (replaces flake8, pylint)
        "mypy",           -- type checker
        "debugpy",        -- debugger

        -- JavaScript/TypeScript: formatters, linters
        "prettier",       -- formatter (JS, TS, JSON, CSS, HTML, Markdown)
        "eslint_d",       -- linter (faster than eslint)

        -- Rust
        "rustfmt",        -- formatter
        "codelldb",       -- debugger (also works for C/C++)

        -- C/C++
        "clang-format",   -- formatter
        "cpptools",       -- debugger

        -- Go
        "gofumpt",        -- formatter
        "goimports",      -- import formatter
        "golangci-lint",  -- linter
        "delve",          -- debugger

        -- Shell
        "shellcheck",
        "shfmt",

        -- YAML/JSON
        "yamllint",

        -- Markdown
        "markdownlint",

        -- SQL (common for backend work)
        "sqlfluff",       -- formatter/linter
      },
    },
  },
}
