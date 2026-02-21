return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            automatic_installation = true,
            ensure_installed = {
                -- Core
                "lua_ls",
                "basedpyright",
                "vtsls",  -- Modern TypeScript LSP (replaces ts_ls)
                "astro",

                -- Web
                "html",
                "cssls",
                "tailwindcss",

                -- Systems
                "rust_analyzer",
                "clangd",
                "gopls",

                -- Data / config
                "jsonls",
                "yamlls",
                "bashls",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "b0o/SchemaStore.nvim",
        },
        opts = {
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = { version = "LuaJIT" },
                            diagnostics = { globals = { "vim" } },
                            workspace = {
                                checkThirdParty = false,
                                library = { vim.env.VIMRUNTIME },
                            },
                            telemetry = { enable = false },
                        },
                    },
                },

                basedpyright = {
                    settings = {
                        basedpyright = {
                            analysis = {
                                typeCheckingMode = "standard",
                                autoSearchPaths = true,
                                useLibraryCodeForTypes = true,
                                diagnosticMode = "openFilesOnly",
                            },
                        },
                    },
                },

                vtsls = {
                    settings = {
                        typescript = {
                            inlayHints = {
                                parameterNames = { enabled = "all" },
                                parameterTypes = { enabled = true },
                                variableTypes = { enabled = true },
                                propertyDeclarationTypes = { enabled = true },
                                functionLikeReturnTypes = { enabled = true },
                            },
                        },
                        javascript = {
                            inlayHints = {
                                parameterNames = { enabled = "all" },
                                parameterTypes = { enabled = true },
                                variableTypes = { enabled = true },
                                propertyDeclarationTypes = { enabled = true },
                                functionLikeReturnTypes = { enabled = true },
                            },
                        },
                    },
                },

                astro = {},

                html = {
                    filetypes = { "html", "htmldjango", "astro" },
                },

                cssls = {
                    settings = {
                        css = {
                            validate = true,
                            lint = { unknownAtRules = "ignore" },
                        },
                    },
                },

                tailwindcss = {
                    filetypes = {
                        "html",
                        "astro",
                        "css",
                        "scss",
                        "javascript",
                        "javascriptreact",
                        "typescript",
                        "typescriptreact",
                    },
                },

                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                                loadOutDirsFromCheck = true,
                            },
                            checkOnSave = {
                                command = "clippy",
                            },
                            procMacro = {
                                enable = true,
                            },
                        },
                    },
                },

                clangd = {
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                    },
                },

                gopls = {
                    settings = {
                        gopls = {
                            analyses = {
                                unusedparams = true,
                                shadow = true,
                            },
                            staticcheck = true,
                            gofumpt = true,
                        },
                    },
                },

                -- JSON with schema validation
                jsonls = {
                    on_new_config = function(new_config)
                        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
                        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
                    end,
                    settings = {
                        json = {
                            validate = { enable = true },
                        },
                    },
                },

                -- YAML
                yamlls = {
                    on_new_config = function(new_config)
                        new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
                        vim.list_extend(new_config.settings.yaml.schemas, require("schemastore").yaml.schemas())
                    end,
                    settings = {
                        yaml = {
                            validate = true,
                        },
                    },
                },

                bashls = {},
            },
        },
    },
}
