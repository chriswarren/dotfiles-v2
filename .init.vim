set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
"
" Dependencies
let g:loaded_python_provider = 0
let g:python3_host_prog = '/usr/bin/python3'

" Plugins
call plug#begin()
  Plug 'dracula/vim' "Colorscheme
  Plug 'kien/ctrlp.vim' "fuzzy file finder
  Plug 'jremmen/vim-ripgrep' "Search with RipGrep
  Plug 'JamshedVesuna/vim-markdown-preview' "Markdown Preview
  Plug 'edkolev/tmuxline.vim' "idk -
  Plug 'vim-airline/vim-airline' "useful information like powerline
  Plug 'christoomey/vim-tmux-navigator' "navigate vim splits and tmux panes with ease
  Plug 'ryanoasis/vim-devicons' "filetype glyphs
  Plug 'rondale-sc/vim-spacejam' "remove trailing whitespace
  Plug 'tpope/vim-commentary' "comment stuff out
  Plug 'tpope/vim-rails' "rails tools
  Plug 'tpope/vim-surround' "quoting/parenthesizing
  Plug 'tpope/vim-fugitive' "git tooling
  Plug 'tpope/vim-rhubarb' "git browse
  Plug 'tpope/vim-endwise' "wisely add `end`
  Plug 'vim-ruby/vim-ruby' "ruby tooling
  Plug 'scrooloose/nerdtree' "File Tree
  Plug 'tpope/vim-unimpaired' "set paste, etc.
  Plug 'vim-syntastic/syntastic' "Syntax checking
  Plug 'iberianpig/tig-explorer.vim' "tig explorer
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'mileszs/ack.vim'
  Plug 'pechorin/any-jump.vim'
  Plug 'nvim-lua/plenary.nvim' "telescope dep
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} "telescope dep
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' } " file finding
call plug#end()

" Theme
  if (has("termguicolors"))
   set termguicolors
  endif
  syntax enable
  colorscheme dracula

" Set leader
  let mapleader=","
  let maplocalleader=","

syntax on                        " enable syntax highlighting
set cursorline                   " Highlight current line
set wrap                         " wrap long lines
set showcmd                      " show commands as we type them
set showmatch                    " highlight matching brackets
set scrolloff=4 sidescrolloff=10 " scroll the window when we get near the edge
set incsearch                    " show the first match as search strings are typed
set hlsearch                     " highlight the search matches
set ignorecase smartcase         " searching is case insensitive when all lowercase
set gdefault                     " assume the /g flag on substitutions to replace all matches in a line
set autoread                     " pick up external file modifications
set hidden                       " don't abandon buffers when unloading
set autoindent                   " match indentation of previous line
set laststatus=2                 " show status line
set display=lastline             " When lines are cropped at the screen bottom, show as much as possible
set backspace=indent,eol,start   " make backspace work in insert mode
set clipboard^=unnamed           " Use system clipboard
set shell=zsh                    " Use login shell for commands
set encoding=utf-8               " utf encoding
set number                       " line numbers
set nobackup 	 		               " no backups
set nowritebackup 	 	           " no backups
set noswapfile     	 	           " no swap file
set colorcolumn=80               " set a column at 80 chars

" match tabs/spaces
  set smarttab
  set smartindent
  set expandtab tabstop=2 softtabstop=2 shiftwidth=2

" flip the default split directions to sane ones
  set splitright
  set splitbelow

"folding settings
  set foldmethod=indent   "fold based on indent
  set foldnestmax=10      "deepest fold is 10 levels
  set nofoldenable        "dont fold by default

" remember last position in file
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" mapping the jumping between splits. Hold control while using vim nav.
  nmap <C-J> <C-W>j
  nmap <C-K> <C-W>k
  nmap <C-H> <C-W>h
  nmap <C-L> <C-W>l

" vim tab navigation
  nnoremap th :tabfirst<CR>
  nnoremap tj :tabprev<CR>
  nnoremap tk :tabnext<CR>
  nnoremap tl :tablast<CR>
  nnoremap tc :tabclose<CR>
  nnoremap tn :tabnew<CR>

" disable arrow navigation keys
  inoremap  <Up>    <NOP>
  inoremap  <Down>  <NOP>
  inoremap  <Left>  <NOP>
  inoremap  <Right> <NOP>
  noremap   <Up>    <NOP>
  noremap   <Down>  <NOP>
  noremap   <Left>  <NOP>
  noremap   <Right> <NOP>

" Quick write, quit, write + quit, quit all
  nnoremap <Leader>w :w<CR>
  nnoremap <Leader>q :q<CR>
  nnoremap <Leader>x :x<CR>
  nnoremap <Leader>Q :q!<CR>

" buffer resizing mappings
  nnoremap <S-H> :vertical resize -10<cr>
  nnoremap <S-L> :vertical resize +10<cr>

" Yank from the cursor to the end of the line, to be consistent with C and D.
  nnoremap Y y$

" Unhighlight search results
  map <Leader><space> :nohl<cr>

" ctrlp
 if get(g:, 'loaded_ctrlp', 1)
   let g:ctrlp_match_window_reversed = 0
   " let g:ctrlp_working_path_mode = 'a'
   let g:ctrlp_max_height = 20
   let g:ctrlp_match_window_bottom = 0
   let g:ctrlp_switch_buffer = 0
   let g:ctrlp_custom_ignore = '\v(\.DS_Store|\.sass-cache|\.scssc|tmp|\.bundle|\.git|node_modules|vendor|bower_components|deps|_build)$'
   let g:ctrlp_working_path_mode = 'w'
   if executable('ag')
      let g:ctrlp_user_command = 'ag %s
             \ -l
             \ --nocolor
             \ --ignore .git
             \ --ignore .svn
             \ --ignore "*.class"
             \ --ignore "*.o"
             \ --ignore "*.obj"
             \ --ignore "*.rbc"
             \ --ignore features/cassettes
             \ --ignore spec/cassettes
             \ --ignore tmp/cache
             \ --ignore vendor/gems
             \ --ignore vendor/ruby
             \ -g ""'
   endif
 endif

 command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" AnyJump

let g:any_jump_disable_default_keybindings = 1
" Use AnyJump to search for the word under the cursor
nnoremap <leader><bs> :AnyJump <cr>

" ripgrep
" " Use ripgrep for searching ⚡️
" Options include:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge sql file dumps as it slows down the search
" --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
  let g:rgcommand = 'rg --vimgrep --type-not sql --smart-case'
  " nnoremap <leader><bs> :Rg '\b<c-r><c-w>\b'<cr>
  nnoremap <leader>a :Rg<space>

" NERDTree configuration
  let NERDTreeIgnore=['\~$', 'tmp', '\.git', '\.bundle', '.DS_Store', 'tags', '.swp']
  let NERDTreeShowHidden=1
  let g:NERDTreeDirArrows=0
  let g:NERDTreeNodeDelimiter = "\u00a0"
  map <Leader>n :NERDTreeToggle<CR>
  map <Leader>fnt :NERDTreeFind<CR>
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif   " Automaticaly
    " close nvim if NERDTree is only thing left open

" Markdown preview
  let vim_markdown_preview_toggle=1
  let vim_markdown_preview_hotkey='<C-m>'
  let vim_markdown_preview_github=1

" Make Syntastic work for yml as well as yaml
autocmd BufRead,BufNewFile *.yml set filetype=yaml
autocmd FileType yml setlocal commentstring=#

" Spell check my git commits so I don't look wuite as bad
autocmd FileType gitcommit setlocal spell
autocmd FileType markdown setlocal spell

" Tmux status bar
  let g:tmuxline_preset = {
    \'win'    : '#I #W',
    \'cwin'    : '#I #W #F',
    \ }
  let g:tmuxline_powerline_separators = 0

" toggle quickfix with <Leader> c
  let g:toggle_list_no_mappings=1
  nmap <script> <silent> <Leader>c :call ToggleQuickfixList()<CR>

" use <tab> for trigger completion and navigate to the next complete item
  inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

    function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  let g:coc_snippet_next = '<tab>'

" use <C-j/k> to nav completion list
  inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"


if filereadable(expand('~/.init.vim.local'))
  source ~/.init.vim.local
endif

" leader + vv splits pane and opens Ctrl P
map <Leader>vv :vsp<cr><C-p>
map <Leader> <esc>
map <Leader>ss :sp<cr><C-p>
map <Leader> <esc>

" abreeevs
inoreabbrev bpry require 'pry'; binding.pry

" format JSON with python
nnoremap <Leader>j :%!python -m json.tool<cr>

" Use powerline fonts with airline
let g:airline_powerline_fonts = 1

" Gross hack to hopefully make it obvious when I forget to write a buffer
function! AirlineInit()
  " first define a new part for modified
  call airline#parts#define('modified', {
    \ 'raw': '%m',
    \ 'accent': 'red',
    \ })

  " then override the default layout for section c with your new part
  let g:airline_section_c = airline#section#create(['%<', '%f', 'modified', ' ', 'readonly'])
endfunction

" TigExplorer Stuff
" open tig with current file
nnoremap <Leader>T :TigOpenCurrentFile<CR>

" open tig with Project root path
nnoremap <Leader>t :TigOpenProjectRootDir<CR>

" open tig grep
nnoremap <Leader>g :TigGrep<CR>

" resume from last grep
nnoremap <Leader>r :TigGrepResume<CR>

" open tig grep with the selected word
vnoremap <Leader>g y:TigGrep<Space><C-R>"<CR>

" open tig grep with the word under the cursor
nnoremap <Leader>cg :<C-u>:TigGrep<Space><C-R><C-W><CR>

" open tig blame with current file
nnoremap <Leader>b :TigBlame<CR>

autocmd VimEnter * call AirlineInit()
