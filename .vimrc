set nocompatible

let g:os_osx = has('macunix')
let g:os_linux = has('unix') && !has('macunix') && !has('win32unix')
let g:os_windows = has('win32')
let g:is_nvim = has('nvim')
let s:is_gui = has('gui_running')

" vundle configurations {{{
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'pangloss/vim-javascript'
"Plugin 'vim-scripts/VimRepress'
"Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'lervag/vimtex'
if version >= 800
    if has('nvim')
      Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
      Plugin 'Shougo/deoplete.nvim'
      Plugin 'roxma/nvim-yarp'
      Plugin 'roxma/vim-hug-neovim-rpc'
    endif
endif
let g:deoplete#enable_at_startup = 1
"let g:deoplete#sources = {}
"let g:deoplete#sources._=['omni', 'buffer', 'member', 'tag', 'ultisnips', 'file']
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
Plugin 'godlygeek/tabular'
Plugin 'vim-scripts/cream-capitalization'
"Plugin 'vim-syntastic/syntastic'
Plugin 'tpope/vim-surround'
"Plugin 'iamcco/markdown-preview.vim'
Plugin 'chiedo/vim-case-convert'
Plugin 'Yggdroot/LeaderF'
"Python-mode {{{
 "let g:pymode_breakpoint_cmd = "__import__('pdb').set_trace()  # XXX BREAKPOINT"
 "let g:pymode_lint_on_write = 0
"}}}
"Unused {{{
"Plugin 'python-mode/python-mode'
"Plugin 'ervandew/supertab'
"Plugin 'danielmiessler/VimBlog'
" Plugin 'vim-scripts/dbext.vim'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'flazz/vim-colorschemes'
" colo railscasts
"Plugin 'tpope/tpope-vim-abolish'
"}}}
syntax on
filetype on
call vundle#end()
filetype plugin indent on
" }}}
"New Command{{{

"Back filename. Open a file in a new vertical window but cursor not switch to
"new window.{{{
" TODO: <17-03-23, gc> Can not get arguments

function! s:Back(file)
    let file = a:file
    execute "vsplit ".file
    normal <c-w><c-w>
endfunction
command! -complete=file -nargs=+ Back call s:Back(<q-args>)
"}}}
"sudo write a file{{{
command! W w !sudo tee % > /dev/null
"}}}
"Shell cmd. A new shell runner ------ {{{
function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize ' . line('$')
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
"}}}

command! -nargs=+ Grep execute 'silent grep! <args>' | copen 42

"}}}
"Basic Setting ------{{{
let g:tex_flavor = "latex"
" Don't redraw while executing macros (good performance config)
set lazyredraw 
set background=dark
set number
let g:mapleader=get(g:, "mapleader", ";")
set expandtab ts=4 sw=4 ai
set softtabstop=4
set cursorline
set foldenable
set foldlevelstart=10
set wrap linebreak nolist
set colorcolumn=80
set autowrite
set noswapfile
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" Set to auto read when a file is changed from the outside
set autoread
" Turn on the Wild menu
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
set ignorecase
set smartcase

if empty($TMUX)
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
else
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
endif

" set foldmethod=indent
colorscheme molokai
filetype plugin on
"}}}
"Mapping ----{{{

" Netrw config
nnoremap <leader>n :Sexplore<cr>
let g:netrw_liststyle=1

"Open .vimrc, Source .vimrc, Open .vimrc.bundles.temp
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ez :e ~/.zshrc<cr>
let tempVimrc = "~/.vimrc.bundles.temp"
nnoremap <leader>et :execute "vsplit ".tempVimrc<cr>

" Home and End
nnoremap H 0
nnoremap L $
vnoremap H 0
vnoremap L $

" Get out of insert model
inoremap jk <esc>
" vnoremap jk <esc>

" Lines up and down based on visual lines
nnoremap j gj
nnoremap k gk

" Switch between windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Open previous buffer in a split window
nnoremap <leader>pb :execute "rightbelow vsplit ".bufname("#")<cr>

" Redraw the vim display.
nnoremap <leader>d :redraw!<cr>
""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Use ctrl-s to save file. Disable w to train finger.
noremap <silent> <C-S>          :<C-U>w<CR>
vnoremap <silent> <C-S>         :<C-U>w<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
cnoremap <silent> <C-S>         <C-U>w<CR>
"cnoremap w<cr> <nop>

" Force very magic mode when search or replace text
nnoremap / /\v
cnoremap %s/ %s/\v

" Disable uppercase and lowercase change in visual mode
vnoremap u <nop>
vnoremap U <nop>

" Convert variables to or from camel case
" Usage:
" http://vim.wikia.com/wiki/Converting_variables_to_or_from_camel_case
" Disable by default in case change the doc by accident, enable it when you need.
"nnoremap + /\$\w\+_<CR>
"nnoremap _ f_x~
"}}}
"Autocmds {{{
if has("autocmd") 
    augroup templates 
        autocmd!
        autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
        autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py
        autocmd BufNewFile *.R 0r ~/.vim/templates/skeleton.R
        autocmd BufNewFile *.html,*.htm 0r ~/.vim/templates/skeleton.html
    augroup END
endif"
"}}}
"Status Line{{{
" set statusline=%<%F%h%m%r%h%w%y\ %=\ col:%c%V\ ascii:%b\ pos:%o\ lin:%l/%L\ %P
set laststatus=2
"}}}
"FileType-specific settings ---------{{{

"}}}
"Other vimscripts{{{
if filereadable(expand(tempVimrc))
  execute "source ".expand(tempVimrc)
endif

if filereadable(expand("~/.vimrc.local"))
    execute "source ".expand("~/.vimrc.local")
endif

"}}}
"vimblog (vimpress) {{{
nnoremap <leader>b? :map <leader>b<cr>
nnoremap <leader>bn :BlogNew post<cr>
nnoremap <leader>bs :BlogSave<cr>
nnoremap <leader>bp :BlogSave publish<cr>
nnoremap <leader>bl :BlogList<cr>
"}}}
"tagbar {{{
let g:tagbar_autofocus = 1
nnoremap <F3> :TagbarToggle<cr>
"}}}
"Airline {{{
let g:airline_theme="cool" 
" let g:airline_left_sep='>'
" let g:airline_powerline_fonts = 1   
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprevious<CR>

let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
"}}}
"Vimtex {{{
let g:vimtex_enabled = 1
let b:vimtex_main = 'main.tex'
let g:vimtex_disable_recursive_main_file_detection = 1
"let g:vimtex_toc_refresh_always = 0
let g:vimtex_complete_enabled = 0
let g:vimtex_fold_enabled = 1
"}}}
" Snippets Configuration -------{{{
" Track the engine.
" UltiSnips setting
" make vim recognizing snippets dir
set runtimepath+=~/.vim/my-snippets/
" use different snippets dir
let g:UltiSnipsSnippetsDir="~/.vim/my-snippets"
" '~/.vim/bundle/vim-snippets/UltiSnips/'
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my-snippets"]

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-p>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEnableSnipMate = 0

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}
"Fugitive{{{
nnoremap <leader>ga :Git add %:p<cr><cr>
nnoremap <leader>ga. :Git add .<cr>
nnoremap <leader>gs :Git<cr>
nnoremap <leader>gh :Git hist<cr>
nnoremap <leader>gc :Git commit<cr>
nnoremap <leader>gl :silent! Gclog<cr>:bot copen<cr>
nnoremap <leader>gd :Gdiffsplit<cr>
nnoremap <leader>gb :Git branch<cr>
nnoremap <leader>gps :Git push<cr>
nnoremap <leader>g? :map <leader>g<cr>
autocmd QuickFixCmdPost *grep* cwindow
"}}}
"Syntastic{{{
"let g:syntastic_python_checkers = ["pylint"]
"let g:syntastic_python_pylint_exe = 'python3 -m pylint'
"let g:syntastic_python_python_exec = 'python3'

""let g:syntastic_python_checkers = ['python']
"}}}
"Languagetool{{{
let g:languagetool_jar='$HOME/Documents/project/LanguageTool-3.7/languagetool-commandline.jar'
"}}}
"LeaderF{{{
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
"}}}
" vim:foldmethod=marker:foldlevel=0
