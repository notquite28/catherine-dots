-- ============================================================================
-- OpenCode.nvim Plugin Configuration
-- ============================================================================
-- OpenCode is an AI-powered coding assistant for Neovim that provides
-- context-aware code suggestions and interactions.
-- ============================================================================

return {
  "nickjvandyke/opencode.nvim",
  version = "*", -- Use the latest stable release

  -- ============================================================================
  -- Dependencies
  -- ============================================================================
  dependencies = {
    {
      -- Snacks.nvim provides enhanced UI components for opencode
      ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
      "folke/snacks.nvim",
      optional = true,
      opts = {
        -- Enhances the `ask()` function with better input UI
        input = {},

        -- Enhances the `select()` function with a picker interface
        picker = {
          actions = {
            -- Custom action to send selected items to opencode
            opencode_send = function(...)
              return require("opencode").snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                -- Alt+A: Send selected items from picker to opencode
                -- Available in both normal and insert mode
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },

        -- Enables the `snacks` terminal provider for opencode
        terminal = {},
      },
    },
  },

  -- ============================================================================
  -- Configuration Function
  -- ============================================================================
  config = function()
    -- OpenCode configuration options
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Add your custom configuration here
      -- Use goto definition on the type or field for details
    }

    -- Enable automatic file reloading (required for opts.events.reload)
    vim.o.autoread = true

    -- ============================================================================
    -- Keybindings
    -- ============================================================================

    -- ┌─────────────────────────────────────────────────────────────────────┐
    -- │ Primary Actions                                                     │
    -- └─────────────────────────────────────────────────────────────────────┘

    -- <leader>oa: Ask opencode a question with "@this: " prefix
    -- Works in normal and visual mode
    -- Submits immediately without additional input
    vim.keymap.set({ "n", "x" }, "<leader>oa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode…" })

    -- <leader>ox: Open action selector to execute opencode commands
    -- Works in normal and visual mode
    vim.keymap.set({ "n", "x" }, "<leader>ox", function()
      require("opencode").select()
    end, { desc = "Execute opencode action…" })

    -- <leader>oo: Toggle opencode panel visibility
    -- Works in normal mode only
    vim.keymap.set("n", "<leader>oo", function()
      require("opencode").toggle()
    end, { desc = "Toggle opencode" })

    -- ┌─────────────────────────────────────────────────────────────────────┐
    -- │ Operator Mappings (Add Code Context to OpenCode)                   │
    -- └─────────────────────────────────────────────────────────────────────┘

    -- go<motion>: Add range to opencode (operator mode)
    -- Examples:
    --   - goip: Add inner paragraph
    --   - go}: Add from cursor to end of paragraph
    --   - goG: Add from cursor to end of file
    -- Works in normal and visual mode
    vim.keymap.set({ "n", "x" }, "go", function()
      return require("opencode").operator("@this ")
    end, { desc = "Add range to opencode", expr = true })

    -- goo: Add current line to opencode (mnemonic: "go + o for one line")
    -- Works in normal mode only
    vim.keymap.set("n", "goo", function()
      return require("opencode").operator("@this ") .. "_"
    end, { desc = "Add line to opencode", expr = true })

    -- ┌─────────────────────────────────────────────────────────────────────┐
    -- │ Scrolling Commands                                                  │
    -- └─────────────────────────────────────────────────────────────────────┘

    -- Shift+Ctrl+U: Scroll opencode panel up by half a page
    vim.keymap.set("n", "<S-C-u>", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "Scroll opencode up" })

    -- Shift+Ctrl+D: Scroll opencode panel down by half a page
    vim.keymap.set("n", "<S-C-d>", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "Scroll opencode down" })


  end,
}

-- ============================================================================
-- Keybinding Summary
-- ============================================================================
-- Main Actions:
--   <leader>oa   Ask opencode with "@this: " prefix (normal/visual)
--   <leader>ox   Execute opencode action (normal/visual)
--   <leader>oo   Toggle opencode panel (normal)
--
-- Operator Mode:
--   go<motion>   Add motion range to opencode (normal/visual)
--   goo          Add current line to opencode (normal)
--
-- Scrolling:
--   <S-C-u>      Scroll opencode up half page (normal)
--   <S-C-d>      Scroll opencode down half page (normal)
--
-- Picker (when using snacks.nvim):
--   <A-a>        Send selected items to opencode (normal/insert in picker)
-- ============================================================================
