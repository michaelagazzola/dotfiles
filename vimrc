" mgazzola/vimrc

set nocompatible
set shell=/bin/bash
set encoding=utf-8

" auto-install vim-plug if not already installed.
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

" plugins

call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'         " Better support for comments.
Plug 'airblade/vim-gitgutter'           " Git diffs on the left sidebar.
Plug 'Raimondi/delimitMate'             " Better support for delimiters.
Plug 'jez/vim-superman'                 " Open man files with vim.
Plug 'tpope/vim-markdown'               " Markdown support for vim.
Plug 'tpope/vim-sensible'               " Sensible remappings for vim.
Plug 'ntpeters/vim-better-whitespace'   " Better support for whitespace.
Plug 'rust-lang/rust.vim'               " Rust support.
Plug 'christoomey/vim-tmux-navigator'   " Tmux navigator in vim.
Plug 'flazz/vim-colorschemes'           " Treasure trove of cool schemes.
Plug 'ctrlpvim/ctrlp.vim'               " Fuzzy search for files with <C-p>.
Plug 'osyo-manga/vim-over'              " incsearch for :s
Plug 'benmills/vimux'                   " Better support for tmux.
Plug 'bling/vim-bufferline'             " Buffer list in command line.
Plug 'Yggdroot/indentLine'              " Show indent lines.
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"Plug 'ryanoasis/vim-devicons'
Plug 'liuchengxu/vista.vim'
Plug 'w0rp/ale'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-obsession'
Plug 'chriskempson/base16-vim'
call plug#end()

" general config

filetype plugin indent on                 " plugin = use per-filetype plugins
                                          " indent = use per-filetype indents
                                          " on     = use filetype detection
let mapleader=','
colorscheme base16-tomorrow-night-eighties
syntax on
set backspace=indent,eol,start            " indent = allow backspace over auto-
                                          "          indent.
                                          " eol    = allow backspace over line
                                          "          breaks (join lines)
                                          " start  = allow backspace over the
                                          "          start of insert
set relativenumber
set number
set incsearch
set hlsearch
set softtabstop=2                         " number of spaces per tab
set shiftwidth=2                          " number of spaces per autoindent
set expandtab                             " use spaces instead of tabs
set t_Co=256                              " set terminal colors to 256
set cursorline
set cursorcolumn
set wildmenu                              " Show menus for buffers.
set foldmethod=syntax                     " Fold based on syntax.
set foldnestmax=10                        " Fold max 10 levels.
set foldlevel=6                           " Start autofolding after 6 levels.
set ttyfast                               " Optimize for fast terminals connections.
set gdefault                              " s[ubstitute] is global by default.
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif
set backupskip=/tmp/*,/private/tmp/*      " Don't create backups for files in certain directories.
set modeline                              " Respect modeline in files
set modelines=4
set lcs=tab:▸\ ,trail:·,nbsp:_            " make invisible characters visible
set list                                  " displays unprintable chars
set ignorecase                            " ignore case for searches
set noerrorbells
set nostartofline                         " Don’t reset cursor to start of line when moving around.
set ruler                                 " show cursor position
set shortmess=atI                         " Don’t show the intro message when starting Vim
set showmode                              " Show the current mode
set title                                 " Show the filename in the window titlebar
set showcmd                               " Show the (partial) command as it’s being typed
set scrolloff=3                           " scroll file when 3 lines from bottom

" Treat .json files as .js
autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript

" Treat .md files as Markdown
autocmd BufNewFile,BufRead *.md setlocal filetype=markdown

" Add a color column at 100 characters.
autocmd FileType * set colorcolumn=100

" Set cursorline and cursorcolumn colors.
highlight CursorLine ctermbg=17 guibg=#693939
highlight CursorColumn ctermbg=17 guibg=#592929

" If you go over the line-length, highlight the code in red.
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
autocmd FileType * match OverLength /\%101v.\+/

" Strip trailing whitespace (<leader>ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Save a file as root (<leader>W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Set %% to mean 'same dir'.
cabbr <expr> %% expand('%:p:h')

" Control splits with the arrow keys!
nnoremap <Right> <C-w>>
nnoremap <Left> <C-w><
nnoremap <Up> <C-w>+
nnoremap <Down> <C-w>-

" Redraw the screen with <C-q>
nnoremap <C-q> :redraw!<CR>

" Y == yy, which takes over newlines. Make it ignore the newline.
nmap Y y$

" NERDTree toggle.
map <Leader>nt :NERDTreeToggle<CR>
" Tagbar toggle.
map <Leader>tt :TagbarToggle<CR>

hi Search cterm=NONE ctermfg=black ctermbg=yellow

autocmd BufWritePost *.tex silent! execute "!xelatex % >/dev/null 2>&1" | redraw!

" --- bling/vim-airline settings ---------------------------------------------
set laststatus=2                            " tell vim to always display [bottom] status bar.
let g:airline_powerline_fonts=1             " use powerline-enabled fonts
let g:airline_detect_paste=1                " also consider pasted mode
let g:airline#extensions#tabline#enabled = 1    " turn on top tab bar
let g:airline_theme='badwolf'                " set the airline theme

" ----- scrooloose/syntastic settings ----------------------------------------
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"

let g:syntastic_python_checkers = ['python3']
let g:syntastic_asm_compiler = 'nasm'

" Add syntastic information to the statusline.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Put issues in a 'location list'. This prevents clashes from several different
" checkers.
let g:syntastic_always_populate_loc_list = 1

" Auto-open the location list on error.
let g:syntastic_auto_loc_list = 1

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_c_compiler_options = '-std=gnu99 -I/usr/X11/include -Wall'

" ----- Raimondi/delimitMate settings ----------------------------------------
"
" Expand delimiters across newlines.
let delimitMate_expand_cr = 1

" Filetype specific matching pairs.
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

" coc
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
"set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

nmap <Leader>v :Vista!!<CR>
let g:vista_default_executive = 'coc'
inoremap <C-c> <ESC>

set wildignore+=*/.git/*,*/node_modules/*

let g:ale_fixers = {
      \ 'javascript': ['prettier', 'eslint'],
      \ 'typescript': ['prettier', 'eslint']
      \ }
let g:ale_fix_on_save = 1

"" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

let NERDTreeHighlightCursorline = 0

let g:session_autosave_periodic = 15

set noshowmode

let g:lightline = {
      \ 'colorscheme': 'Tomorrow_Night_Eighties',
      \ }

