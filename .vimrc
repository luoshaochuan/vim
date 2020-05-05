let mapleader = "\<Space>"
inoremap jj <ESC>

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'altercation/vim-colors-solarized'
"Plug 'w0rp/ale'
Plug 'yggdroot/leaderf'
Plug 'vim-scripts/taglist.vim'
Plug 'itchyny/lightline.vim'
Plug 'ddollar/nerdcommenter'
Plug 'shougo/neocomplete.vim'
Plug 'shougo/neosnippet.vim'
Plug 'shougo/neosnippet-snippets'
Plug 'chiel92/vim-autoformat'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
Plug 'kshenoy/vim-signature'
Plug 'roxma/vim-paste-easy'
"Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-fugitive'
Plug 'thinca/vim-quickrun'
Plug 'derekwyatt/vim-fswitch'
call plug#end()

set nu
set tabstop=4
set expandtab
set shiftwidth=4
set autoindent
set hlsearch
set guifont=*
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
set laststatus=2
set statusline=%F
set statusline+=%=
set statusline+=%{getcwd()}
set tags=./.tags;,.tags
set ts=4

"vim-colors-solarized
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

filetype plugin on
set omnifunc=syntaxcomplete#Complete

"LeaderF
noremap <c-n> :LeaderfMru<cr>
noremap <c-p> :LeaderfFunction!<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
" search word under cursor, the pattern is treated as regex, and enter normal mode directly
noremap <C-m> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>

"neocomplete
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Enter>.
inoremap <expr><CR> pumvisible() ? "\<C-y>" : "\<CR>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

"autoformat
let g:formatdef_my_cpp = '"astyle --style=allman"'
let g:formatters_cpp = ['my_cpp']

"Taglist
map <silent> <leader>tl :Tlist<cr> 

"NERDTree
map <silent> <leader>nd :NERDTree<cr> 

set mouse=a

let g:AutoPairsFlyMode = 0
let g:AutoPairsMultilineClose = 0

" quickrun
let g:quickrun_config = {}
let g:quickrun_config.cpp = {
            \ 'type' : 'cpp/g++',
            \ 'command': 'g++',
            \ 'exec': ['%c %o %s -std=c++17 -o %s:p:r', '%s:p:r %a'],
            \ 'tempfile': '%{tempname()}.cpp',
            \ 'hook/sweep/files': '%S:p:r',
            \}

" file switch
let g:fsnonewfiles = 'off'
au! BufEnter *.cpp let b:fswitchdst = 'h,ipp' | let b:fswitchlocs = './,../include/,reg:/src/include/'
au! BufEnter *.h let b:fswitchdst = 'ipp,cpp' | let b:fswitchlocs = './,../src/,reg:/include/src/'
au! BufEnter *.ipp let b:fswitchdst = 'cpp,h' | let b:fswitchlocs = './,../src/,../include/,reg:/include/src/,reg:/src/include/'
nmap <F2> :silent! FSHere<Cr>

let g:lightline = {
            \ 'component' : {
            \ 'filename' : '%F',
            \ }
            \ }
