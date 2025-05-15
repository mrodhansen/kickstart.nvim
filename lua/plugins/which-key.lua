return {
  "folke/which-key.nvim",
  event = "VimEnter", -- Load when Vim starts
  config = function()
    local wk = require("which-key")

    wk.setup({
      -- delay between pressing a key and opening which-key (milliseconds)
      delay = 0,
      icons = {
        -- Set to true if you have a Nerd Font installed
        mappings = vim.g.have_nerd_font or false,
        -- Define icons for keys
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      
      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    })

    -- Define which-key mappings
    -- This is optional but useful for documenting key groups
    wk.register({
      -- Define your key groups here
      ["<leader>"] = {
        s = { name = "[S]earch" },
        c = { name = "[C]ode" },
        d = { name = "[D]ocument" },
        r = { name = "[R]ename" },
        w = { name = "[W]orkspace" },
        t = { name = "[T]oggle" },
        h = { name = "Git [H]unk" },
      },
    })
  end
}
