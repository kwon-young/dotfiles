--   _____                        _____  _
--  / ____|                      |  __ \(_)
-- | |     __ _ _ __ _ __   ___  | |  | |_  ___ _ __ ___
-- | |    / _` | '__| '_ \ / _ \ | |  | | |/ _ \ '_ ` _ \
-- | |___| (_| | |  | |_) |  __/ | |__| | |  __/ | | | | |
--  \_____\__,_|_|  | .__/ \___| |_____/|_|\___|_| |_| |_|
--                  | |
--                  |_|
-- Author: Kwon-Young Choi
-- Date: 2025-05-28
--
-- Description:
--		Configuration file for Neovim in lua
--
-- Compatibility: Neovim 11
--

-- Various Vim settings
-- ====================

local fn = vim.fn

local dev = vim.fn.expand('$HOME') .. '/miniforge3/envs/dev/'
vim.g.python3_host_prog = dev .. 'bin/python'

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
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true
vim.opt.mouse = 'a'
vim.opt.spell = true
-- cjk is for ignoring Korean words in en and fr files
vim.opt.spelllang = {'en_us', 'fr', 'cjk'}

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
--  softtabs are 4 spaces for expandtab
vim.opt.shiftwidth = 4

-- Alignment tabs are two spaces, and never tabs. Negative means use same as
-- shiftwidth (so the 2 actually doesn't matter).
-- Works with IndentTab.
vim.opt.softtabstop = -4

-- real tabs render 4 wide. Applicable to HTML, PHP, anything using real tabs.
-- I.e., not applicable to JS.
vim.opt.tabstop = 4

-- use multiple of shiftwidth when shifting indent levels.
-- this is OFF so block comments don't get fudged when using ">>" and "<<"
vim.opt.shiftround = false

-- When on, a <Tab> in front of a line inserts blanks according to
-- 'shiftwidth'.  'tabstop' or 'softtabstop' is used in other places.  A
vim.opt.smarttab = true

-- Various Vim mappings
-- ====================

-- QWERTY layout
vim.keymap.set('', ';', ':')
vim.keymap.set('', ':', ';')

-- Escape
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'kj', '<Esc>')

vim.g.mapleader = "'"

-- Edit and source vimrc
vim.keymap.set('n', '<leader>ev', ':vsplit $MYVIMRC<cr>')
vim.keymap.set('n', '<leader>sv', ':source $MYVIMRC<cr>')
vim.keymap.set('n', '<leader>eg', ':vsplit $MYGVIMRC<cr>')
vim.keymap.set('n', '<leader>sg', ':source $MYGVIMRC<cr>')

-- Edit note file
vim.keymap.set('n', '<leader>en', ':edit $HOME/Notes/note.md<CR>GG')

-- Easy copy/pasting with X11 "+ register
vim.keymap.set('', '<leader>y', '"+y')
vim.keymap.set('', '<leader>p', '"+p')

-- delete buffer without deleting split
vim.keymap.set('n', '<leader>d', ':bp|bd#<cr>')

-- switching split
vim.keymap.set('n', '<a-l>', ':wincmd l<CR>')
vim.keymap.set('n', '<a-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<a-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<a-h>', ':wincmd h<CR>')
-- Remove search highlight
vim.keymap.set('', '<leader>h', ':nohlsearch<cr>')
-- diffing
vim.keymap.set('n', 'du', ':diffupdate<CR>')
vim.keymap.set('n', '<leader>dt', ':windo diffthis<CR>')
vim.keymap.set('n', '<leader>do', ':windo diffoff<CR>')
-- Add very magic to search command
vim.keymap.set('n', '/', '/\\v')
vim.keymap.set('n', '?', '?\\v')
-- fullscreen current buffer
vim.keymap.set('n', '<a-o>', ':tab split<CR>')

-- Neovim Terminal settings
-- ========================
local terminal = vim.api.nvim_create_augroup('terminal', { clear = true })
vim.api.nvim_create_autocmd({"TermOpen"}, {
    callback = function()
        vim.opt_local.spell = false
        vim.cmd.startinsert()
    end,
    group = terminal,
})

-- exit insert mode in terminal
vim.keymap.set('t', 'jk', '<C-\\><C-n>')
-- Switching split with alt
vim.keymap.set('t', '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<A-l>', '<C-\\><C-n><C-w>l')

-- Prolog filetype detection
vim.g.filetype_pl = 'prolog'

-- Highlight on yank
local YankHighlight = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd({"TextYankPost"}, {
    callback = function()
        vim.hl.on_yank({higroup="Underlined", timeout=500})
    end,
    group = YankHighlight,
})

-- LSP
-- ===

vim.lsp.config('*', {
    capabilities = {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            }
        }
    },
    root_markers = { '.git' },
})
vim.lsp.config.luals = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                }
            }
        }
    }
}
vim.lsp.config.clangd = {
    cmd = { 'clangd', '--background-index' },
    root_markers = { 'compile_commands.json', 'compile_flags.txt' },
    filetypes = { 'c', 'cpp' },
}
vim.lsp.config.pylsp = {
    cmd = { 'pylsp' },
    root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile',
    'environment.yml' },
    filetypes = { 'python' },
}
vim.lsp.config.prolog_ls = {
    cmd = { '/home/kwon-young/prog/swipl-devel/install/bin/swipl', '-g', 'use_module(library(lsp_server)).', '-g', 'lsp_server:main', '-t', 'halt',
    '--', 'stdio' },
    root_markers = { 'pack.pl' },
    filetypes = { 'prolog' },
}
vim.env.DOTNET_ROOT = dev .. 'lib/dotnet'
vim.lsp.config.marksman = {
    cmd = { 'marksman', 'server' },
    root_markers = { '.marksman.toml' },
    filetypes = { 'markdown', 'markdown.mdx' },
}
vim.lsp.config.bashls = {
    cmd = { 'bash-language-server', 'start' },
    filetypes = { 'bash', 'sh' },
}

vim.lsp.enable({ 'luals', 'clangd', 'pylsp', 'prolog_ls', 'marksman', 'bashls' })
vim.diagnostic.config({ virtual_lines = true })

-- LSP autocompletion
-- ==================
vim.cmd[[set completeopt+=menuone,noselect,popup,fuzzy]]

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
        if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            -- client.server_capabilities.completionProvider.triggerCharacters = chars

            vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
        end
    end,
})

-- Tabline, defines how tabpages title looks like
-- For convenience of cross-probjects development, show project names directly.
function MyTabLine()
    local tabline = ""
    for index = 1, vim.fn.tabpagenr('$') do
        -- Select the highlighting for the current tabpage.
        if index == vim.fn.tabpagenr() then
            tabline = tabline .. '%#TabLineSel#'
        else
            tabline = tabline .. '%#TabLine#'
        end

	-- set the tab page number (for mouse clicks)
        tabline = tabline .. '%' .. index .. 'T'
        -- tab number
        tabline = tabline .. ' ' .. index
        local win_num = vim.fn.tabpagewinnr(index)
        local working_directory = vim.fn.getcwd(win_num, index)
        local project_name = vim.fn.fnamemodify(working_directory, ":t")
        tabline = tabline .. " " .. project_name .. " "
    end

    tabline = tabline .. '%#TabLineFill#%T'

    return tabline
end
vim.go.tabline = "%!v:lua.MyTabLine()"


-- Bootstrap lazy.nvim
-- ===================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local colors = {
    active = {
        bg = '#875f5f',
        fg = '#d7d7af',
    },
    inactive = {
        bg = '#d7d7af',
        fg = '#444444',
    },
}

local lualine_theme = {
    visual = {
        b = { fg = colors.active.fg, bg = colors.active.bg },
        a = { fg = colors.active.fg, bg = colors.active.bg, gui = 'bold' },
    },
    inactive = {
        b = { fg = colors.inactive.fg, bg = colors.inactive.bg },
        c = { fg = colors.inactive.fg, bg = colors.inactive.bg },
        a = { fg = colors.inactive.fg, bg = colors.inactive.bg, gui = 'bold' },
    },
    insert = {
        b = { fg = colors.active.fg, bg = colors.active.bg },
        a = { fg = colors.active.fg, bg = colors.active.bg, gui = 'bold' },
    },
    replace = {
        b = { fg = colors.active.fg, bg = colors.active.bg },
        a = { fg = colors.active.fg, bg = colors.active.bg, gui = 'bold' },
    },
    normal = {
        b = { fg = colors.active.fg, bg = colors.active.bg },
        c = { fg = colors.active.fg, bg = colors.active.bg },
        a = { fg = colors.active.fg, bg = colors.active.bg, gui = 'bold' },
    },
}

-- Setup lazy.nvim
-- ===============
require("lazy").setup({
    spec = {
        -- colorscheme
        {
            'junegunn/seoul256.vim',
            lazy = false, -- make sure we load this during startup if it is your main colorscheme
            priority = 1000, -- make sure to load this before all the other start plugins
            config = function()
                -- load the colorscheme here
                vim.g.seoul256_srgb = 1
                vim.g.seoul256_background = 236
                vim.cmd('colorscheme seoul256')
            end,
        },
        -- indent
        { 'tpope/vim-sleuth', lazy = false },
        -- statusline
        {
            'nvim-lualine/lualine.nvim',
            lazy = false,
            opts = {
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" }
                },
                sections = {
                    lualine_a = {}
                },
                extensions = {'quickfix', 'fugitive'},
                options = {
                    theme = lualine_theme,
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                    path = 1,
                },
            }
        },
        -- quickfix
        { 'blueyed/vim-qf_resize', lazy = false },
        -- picker
        {
            'nvim-telescope/telescope.nvim', tag = '0.1.8',
            dependencies = { 'nvim-lua/plenary.nvim' },
            config = function()
                local builtin = require('telescope.builtin')
                vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' } )
                vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Telescope live grep' } )
                vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Telescope buffers' } )
                vim.keymap.set('n', '<leader>jh', builtin.help_tags, { desc = 'Telescope help tags' } )
            end,
        },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            init = function()
                require('telescope').load_extension('fzf')
            end,
        },
        -- sudo
        {
            'lambdalisue/suda.vim',
            lazy = false,
            init = function()
                vim.g.suda_smart_edit = 1
            end
        },
        -- tables
        { 'godlygeek/tabular', cmd = 'Tabularize' },
        -- git
        { 'tpope/vim-fugitive', lazy = false },
        -- languages
        {
            'terrortylor/nvim-comment',
            lazy = false,
            config = function()
                require('nvim_comment').setup({
                    line_mapping = "<leader>cc",
                    operator_mapping = "<leader>c"
                })
            end
        },
        {
            'nvim-treesitter/nvim-treesitter',
            branch = 'master',
            lazy = false,
            build = ':TSUpdate',
            config = function()
                require'nvim-treesitter.configs'.setup {
                    -- highlight = {
                        --     enable = true,
                        --     -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                        --     -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                        --     -- Using this ;option may slow down your editor, and you may see some duplicate highlights.
                        --     -- Instead of true it can also be a list of languages
                        --     additional_vim_regex_highlighting = false,
                        -- },
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
                end,
            },
            { "rafamadriz/friendly-snippets" },
            {
                'DimitrisDimitropoulos/yasp.nvim',
                -- lazy loading is not required, since it is handled internally
                lazy = false,
                opts = {
                    -- 💀 WARNING: the following must be provided by the user
                    -- the paths to the package.json files, no default given, must be provided
                    paths = {
                        -- for friendly-snippets installed via lazy.nvim
                        vim.fn.stdpath 'data' .. '/lazy/friendly-snippets/package.json',
                        -- for snippets in the users config directory
                        -- vim.fn.expand('$MYVIMRC'):match '(.*[/\\])' .. 'snippets/path/to/package.json',
                    },
                    -- the accompanying descriptions for the paths, no default given, must be provided
                    descs = { 'F-S', 'User' },
                },
            },
        },
        -- Configure any other settings here. See the documentation for more details.
        -- automatically check for plugin updates
        checker = { enabled = true },
    })

    -- Fugitive
    vim.keymap.set('n', '<leader>gs', ':Git<CR>')
    vim.keymap.set('n', '<leader>gc', ':Git commit<CR>')
    vim.keymap.set('n', '<leader>gd', ':Gdiff<CR>')
    vim.keymap.set('n', '<leader>gw', ':Gwrite<CR>')

    local cutecat = vim.api.nvim_create_augroup('cutecat', { clear = true })
    vim.api.nvim_create_autocmd({"VimEnter"}, {
        callback = function()
            vim.cmd([[highlight Visual ctermfg=NONE]])
            print(">^.^<")
        end,
        group = cutecat,
    })
