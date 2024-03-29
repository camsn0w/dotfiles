
filetype plugin indent on
syntax on

call plug#begin()
" Themes
Plug 'vim-airline/vim-airline-themes'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'shaunsingh/nord.nvim'
" For language support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-snippets'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'is0n/jaq-nvim' " code runner
Plug 'TovarishFin/vim-solidity'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'MunifTanjim/nui.nvim'
" Git/Github 
Plug 'github/copilot.vim'
Plug 'tpope/vim-fugitive' " for git
Plug 'pwntester/octo.nvim'
" Session
Plug 'rmagatti/auto-session'
" Navagation and utils
Plug 'ggandor/lightspeed.nvim'
Plug 'ctrlpvim/ctrlp.vim' 
Plug 'max-0406/autoclose.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'sharkdp/fd'
Plug 'nvim-telescope/telescope.nvim'
Plug 'declancm/cinnamon.nvim'
" Bar 
Plug 'romgrk/barbar.nvim'
Plug 'vim-airline/vim-airline'
Plug 'mechatroner/rainbow_csv'
call plug#end()

set encoding=utf-8

colorscheme nord

" Change directory to the current file's location
"set autochdir

" Set airline theme
let g:airline_theme='base16_nord'

" Set the leader key to alt
let mapleader = ','

" Display colors properly across all modes
set termguicolors

" Show line numbers relative to the current cursor position
set relativenumber

" Move to previous/next
nnoremap <silent>    <A-1> :BufferGoto 1<CR>
nnoremap <silent>    <A-2> :BufferGoto 2<CR>
nnoremap <silent>    <A-3> :BufferGoto 3<CR>
nnoremap <silent>    <A-4> :BufferGoto 4<CR>
nnoremap <silent>    <A-5> :BufferGoto 5<CR>
nnoremap <silent>    <A-6> :BufferGoto 6<CR>
nnoremap <silent>    <A-7> :BufferGoto 7<CR>
nnoremap <silent>    <A-8> :BufferGoto 8<CR>
nnoremap <silent>    <A-9> :BufferLast<CR>
nnoremap <silent>    <A-tab> :BufferNext<CR>

" Close buffer
nnoremap <silent>    <A-c> :BufferClose<CR>

" Close/Open NvimTree
nnoremap t :NvimTreeToggle<CR>

" COC STUFF
lua require'nvim-tree'.setup {}
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" END COC STUFF

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

" END TERMINAL STUFF
"set shell=/bin/bash


" TreeSitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
ensure_installed = {"go", "python"},
  highlight = {
    enable = true,              
    additional_vim_regex_highlighting = true,
  },
}
EOF

" Use system clipboard
set clipboard+=unnamedplus

" Telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" Octo
lua require 'octo'.setup{}

" Highlight yanked text
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END
