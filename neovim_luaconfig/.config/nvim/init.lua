--   _____                        _____  _                
--  / ____|                      |  __ \(_)               
-- | |     __ _ _ __ _ __   ___  | |  | |_  ___ _ __ ___  
-- | |    / _` | '__| '_ \ / _ \ | |  | | |/ _ \ '_ ` _ \ 
-- | |___| (_| | |  | |_) |  __/ | |__| | |  __/ | | | | |
--  \_____\__,_|_|  | .__/ \___| |_____/|_|\___|_| |_| |_|
--                  | |                                   
--                  |_|                                   
-- Author: Kwon-Young Choi
-- Date: 2021-08-29
--
-- Description:
--		Configuration file for Neovim in lua
--
-- Compatibility: Neovim 5
--

-- Various Vim settings
-- ====================

local fn = vim.fn

vim.g.python3_host_prog = "/home/kwon-young/mambaforge/envs/dev/bin/python"

vim.cmd('syntax on')

-- Enable undo files and backup files
vim.opt.undofile = true
vim.opt.backup = true
-- Neovim backupdir default has current directory which I don't like
vim.opt.backupdir:remove({'.'})

local backupdir = vim.opt.backupdir:get()[1]
if fn.empty(fn.glob(backupdir)) > 0 then
  fn.mkdir(backupdir)
end

vim.opt.number = true
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.showmatch = true
vim.opt.mouse = 'a'
vim.opt.history = 10000
vim.opt.undolevels = 1000
vim.opt.spell = true
-- cjk is for ignoring korean words in en and fr files
vim.opt.spelllang = {'en_us', 'fr', 'cjk'}
-- Turn off this horrible horrible settings
vim.opt.errorbells = false
vim.opt.showtabline = 1
vim.opt.inccommand = 'nosplit'
vim.opt.foldlevel = 99
vim.opt.foldenable = true

-- Indentation option
-- ============================================================================
-- Indenting newlines
-- ============================================================================

--  indent when creating newline
vim.opt.autoindent = true
--  add an indent level inside braces
vim.opt.smartindent = true

-- for autoindent, use same spaces/tabs mix as previous line, even if
-- tabs/spaces are mixed. Helps for docblock, where the block comments have a
-- space after the indent to align asterisks
vim.opt.copyindent = true

-- Try not to change the indent structure on "<<" and ">>" commands. I.e. keep
-- block comments aligned with space if there is a space there.
vim.opt.preserveindent = true

-- ============================================================================
-- Tabbing - overridden by editorconfig, sleuth.vim
-- ============================================================================

--  default to spaces instead of tabs
vim.opt.expandtab = true
--  softtabs are 2 spaces for expandtab
vim.opt.shiftwidth = 2

-- Alignment tabs are two spaces, and never tabs. Negative means use same as
-- shiftwidth (so the 2 actually doesn't matter).
-- Works with IndentTab.
vim.opt.softtabstop = -2

-- real tabs render 4 wide. Applicable to HTML, PHP, anything using real tabs.
-- I.e., not applicable to JS.
vim.opt.tabstop = 4

-- use multiple of shiftwidth when shifting indent levels.
-- this is OFF so block comments don't get fudged when using ">>" and "<<"
vim.opt.shiftround = false

-- When on, a <Tab> in front of a line inserts blanks according to
-- 'shiftwidth'.  'tabstop' or 'softtabstop' is used in other places.  A
vim.opt.smarttab = true

--  bs anything
vim.opt.backspace = {'indent', 'eol', 'start'}

-- Various Vim mappings
-- ====================

-- QWERTY layout
vim.api.nvim_set_keymap('', ';', ':', {noremap = true})
vim.api.nvim_set_keymap('', ':', ';', {noremap = true})

-- Escape
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {noremap = true})
vim.api.nvim_set_keymap('i', 'kj', '<Esc>', {noremap = true})

vim.g.mapleader = "'"

-- Edit and source vimrc
vim.api.nvim_set_keymap('n', '<leader>ev', ':vsplit $MYVIMRC<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>sv', ':source $MYVIMRC<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>eg', ':vsplit $MYGVIMRC<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>sg', ':source $MYGVIMRC<cr>', {noremap = true})
-- Edit note file
vim.api.nvim_set_keymap('n', '<leader>en', ':edit $HOME/Notes/note.md<CR>GG', {noremap = true})

-- Easy copy/pasting with X11 "+ register
vim.api.nvim_set_keymap('', '<leader>y', '"+y', {noremap = true})
vim.api.nvim_set_keymap('', '<leader>p', '"+p', {noremap = true})

-- delete buffer without deleting split
vim.api.nvim_set_keymap('n', '<leader>d', ':bp|bd#<cr>', {noremap = true})

-- switching split
vim.api.nvim_set_keymap('n', '<a-l>', ':wincmd l<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<a-k>', ':wincmd k<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<a-j>', ':wincmd j<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<a-h>', ':wincmd h<CR>', {noremap = true})
-- Remove search highlight
vim.api.nvim_set_keymap('', '<leader>h', ':nohlsearch<cr>', {noremap = true})
-- diffing
vim.api.nvim_set_keymap('n', 'du', ':diffupdate<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>dt', ':windo diffthis<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>do', ':windo diffoff<CR>', {noremap = true})
-- Add very magic to search command
vim.api.nvim_set_keymap('n', '/', '/\\v', {noremap = true})
vim.api.nvim_set_keymap('n', '?', '?\\v', {noremap = true})
-- fullscreen current buffer
vim.api.nvim_set_keymap('n', '<a-o>', ':tab split<CR>', {noremap = true})

-- Neovim Terminal settings
-- ========================
vim.api.nvim_exec([[
  augroup terminal
    autocmd!
    autocmd TermOpen * setlocal nospell
    autocmd TermOpen * setlocal nonumber
    autocmd TermOpen * startinsert
  augroup END
]], false)

-- exit insert mode in terminal
vim.api.nvim_set_keymap('t', 'jk', '<C-\\><C-n>', {noremap = true})
-- Switching split with alt
vim.api.nvim_set_keymap('t', '<A-h>', '<C-\\><C-n><C-w>h', {noremap = true})
vim.api.nvim_set_keymap('t', '<A-j>', '<C-\\><C-n><C-w>j', {noremap = true})
vim.api.nvim_set_keymap('t', '<A-k>', '<C-\\><C-n><C-w>k', {noremap = true})
vim.api.nvim_set_keymap('t', '<A-l>', '<C-\\><C-n><C-w>l', {noremap = true})

-- Prolog filetype detection
vim.g.filetype_pl = 'prolog'

-- Highlight on yank
vim.api.nvim_exec(
[[
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="Underlined", timeout=500}
augroup end
]], false)


local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd('packadd packer.nvim')
end

local use = require('packer').use
require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'junegunn/seoul256.vim'

  -- interface
  use 'tpope/vim-sleuth'
  use 'tpope/vim-flagship'
  use 'blueyed/vim-qf_resize'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'lambdalisue/suda.vim'

  -- tables
  use 'godlygeek/tabular'

  -- git
  use 'tpope/vim-fugitive'

  -- languages
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-calc'
  use 'kdheepak/cmp-latex-symbols'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'rafamadriz/friendly-snippets' -- Snippets database
  use 'terrortylor/nvim-comment'
  use 'mfussenegger/nvim-dap'
  use 'mfussenegger/nvim-dap-python'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'theHamsta/nvim-dap-virtual-text'
  use 'lewis6991/spellsitter.nvim'

  -- python
  use { 'dccsillag/magma-nvim', run = ':UpdateRemotePlugins' }

  -- async
  use {
    'skywind3000/asynctasks.vim',
    requires = {'skywind3000/asyncrun.vim'}
  }

end)

-- Seoul256 configuration
vim.g.seoul256_srgb = 1
vim.g.seoul256_background = 236
vim.cmd('colorscheme seoul256')

-- status line configuration with vim-flagship
function _G.ListNumberEntry(listtype)
  local list = ''
  local prefix = ''
  if listtype == 'qf' then
    list = fn.getqflist()
    prefix = 'qf='
  elseif listtype == 'loc' then
    list = fn.getloclist(fn.winnr())
    prefix = 'loc='
  end

  if #list then
    local num_valid_entry = 0
    for _, line in ipairs(list) do
      num_valid_entry = num_valid_entry + line['valid']
    end
    if num_valid_entry > 0 then
      return prefix .. num_valid_entry
    end
  end
  return ''
end

vim.api.nvim_exec([[
function! QuickfixNumberEntry()
  return v:lua.ListNumberEntry('qf')
endfunction

function! LocationlistNumberEntry()
  return v:lua.ListNumberEntry('loc')
endfunction

augroup quickloc
  autocmd!
  autocmd User Flags call Hoist('buffer', 6, 'QuickfixNumberEntry')
  autocmd User Flags call Hoist('buffer', 7, 'LocationlistNumberEntry')
augroup END
]], false)

-- Telescope
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
      n = {
        ["<esc>"] = actions.close,
      },
    },
  }
}

vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua require"telescope.builtin".find_files({ hidden = true })<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua require"telescope.builtin".live_grep({ hidden = true })<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>jh', '<cmd>Telescope help_tags<cr>', {noremap = true})

-- suda.vim configuration
vim.g.suda_smart_edit = 1

-- Fugitive
vim.api.nvim_set_keymap('n', '<leader>gs', ':Git<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gd', ':Gdiff<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gw', ':Gwrite<CR>', {noremap = true})


-- LSP settings
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  vim.cmd[[
  augroup LspDiagnostics
    autocmd!
    autocmd User LspDiagnosticsChanged lua vim.lsp.diagnostic.set_loclist({open_loclist = false})
  augroup END
  ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local sumneko_root_path = vim.fn.getenv 'HOME' .. '/prog/lua-language-server' -- Change to your sumneko root installation
local sumneko_binary = sumneko_root_path .. '/bin/Linux/lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Enable the following language servers
local servers = {
  clangd = {},
  sumneko_lua = {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          preloadFileSize = 500,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
  pylsp = {},
}

for lsp, settings in pairs(servers) do
  settings.on_attach = on_attach
  settings.capabilities = capabilities
  nvim_lsp[lsp].setup(settings)
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect,noinsert'

-- luasnip setup
local luasnip = require 'luasnip'
require("luasnip.loaders.from_vscode").lazy_load {}

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    -- ['<CR>'] = cmp.mapping.confirm {
    --   behavior = cmp.ConfirmBehavior.Replace,
    --   select = true,
    -- },
    ['<Tab>'] = function(fallback)
      if luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'path' },
    { name = 'buffer' },
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'calc' },
    { name = 'latex_symbols' },
  },
}

-- nvim-comment
require('nvim_comment').setup({line_mapping = "<leader>cc", operator_mapping = "<leader>c"})

-- nvim-dap
local dap = require('dap')
require('dap-python').setup('/home/kwon-young/mambaforge/envs/dev/bin/python')
dap.adapters.lldb = {
  type = 'executable',
  command = 'lldb-vscode', -- adjust as needed
  name = "lldb"
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = false,
  },
}

-- If you want to use this for rust and c, add something like this:
dap.configurations.c = dap.configurations.cpp

vim.api.nvim_set_keymap('n', '<F8>', ':lua require("dap").toggle_breakpoint()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<F9>', ':lua require("dap").continue()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<F10>', ':lua require("dap").step_over()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<F11>', ':lua require("dap").step_into()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<F12>', ':lua require("dap").step_out()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>B', ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>lp', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>dr', ':lua require("dap").repl.open()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>dl', ':lua require("dap").run_last()<CR>', {noremap = true, silent = true})
require("dapui").setup{}

-- treesitter
require('nvim-treesitter.configs').setup {
  indent = {
    enable = true
  },
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.api.nvim_set_keymap('', '<leader>l', '<cmd>echo nvim_treesitter#statusline(1000)<CR>', {noremap = true, silent = true})

-- nvim-dap-virtual-text
-- show virtual text for current frame (recommended)
vim.g.dap_virtual_text = true

-- spellsitter.nvim
require('spellsitter').setup()

-- async
vim.g.asyncrun_open = 6
vim.api.nvim_set_keymap('n', '<F5>', ':AsyncTask build-test<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<F6>', ':AsyncTask test<CR>', {noremap = true, silent = true})


vim.api.nvim_exec([[
augroup cutecat
  autocmd!
  autocmd VimEnter * echo ">^.^<"
augroup END
]], false)
