return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            -- Set space as the leader key
            vim.g.mapleader = ' '
            vim.g.maplocalleader = ' '
            
            -- Load telescope builtin functions
            local builtin = require("telescope.builtin")
            
            -- Map keybindings to match your old config
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
            vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
            vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
            
            -- Special search in current buffer with dropdown
            vim.keymap.set('n', '<leader>/', function()
                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })
            
            -- Search in open files
            vim.keymap.set('n', '<leader>s/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Live Grep in Open Files',
                }
            end, { desc = '[S]earch [/] in Open Files' })
            
            -- Search in Neovim config files
            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = '[S]earch [N]eovim files' })
            
            -- Function for searching and scoping into a directory (keep this from your current config)
            function search_and_scope_into_directory()
                builtin.find_files({
                    prompt_title = "Search Directories",
                    find_command = {"fd", "--type", "d", "--hidden", "--follow"},
                    attach_mappings = function(prompt_bufnr, map)
                        local actions = require("telescope.actions")
                        actions.select_default:replace(function()
                            local selection = require("telescope.actions.state").get_selected_entry()
                            local selected_dir = selection.path
                            -- Change the current working directory to the selected directory
                            vim.cmd("cd " .. selected_dir)
                            actions.close(prompt_bufnr)
                        end)
                        return true
                    end,
                })
            end
            
            -- Keep your Alt+d shortcut for directory search
            vim.keymap.set("n", "<A-d>", search_and_scope_into_directory)
        end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
                defaults = {
                    file_ignore_patterns = {
                        "node_modules", "build", "dist", "yarn.lock"
                    },
                    vimgrep_arguments = {
                        "rg",
                        "--follow",        
                        "--hidden",        
                        "--no-heading",    
                        "--with-filename",
                        "--line-number",
                        "--column",        
                        "--smart-case",    
                        "--glob=!/.git/*",
                        "--glob=!/.idea/",
                        "--glob=!**/.vscode/",
                        "--glob=!/build/*",
                        "--glob=!/dist/",
                        "--glob=!/yarn.lock",
                        "--glob=!/package-lock.json",
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        find_command = {
                            "rg",
                            "--files",
                            "--hidden",
                            "--glob=!**/.git/",
                            "--glob=!/.idea/*",
                            "--glob=!/.vscode/",
                            "--glob=!**/build/",
                            "--glob=!/dist/*",
                            "--glob=!/yarn.lock",
                            "--glob=!**/package-lock.json",
                        },
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
