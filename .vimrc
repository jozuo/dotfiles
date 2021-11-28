" 一旦ファイルタイプ関連を無効化
filetype off

"--------------------------------------------------------------------------------
" dein.vim setting start
"--------------------------------------------------------------------------------
if &compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

let s:dein_dir = expand('~/.vim/bundles')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml_dir = expand('~/.config/vim')
  " 起動時に読み込むプラグイン群
  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
  " 遅延読み込みしたいプラグイン群
  call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})
  " dein.vimで管理して更新だけするファイル群(≒ NeoBundleFetch)
  call dein#load_toml(s:toml_dir . '/dein_rtp.toml', {'rtp': ''})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif
"--------------------------------------------------------------------------------
" dein.vim setting end
"--------------------------------------------------------------------------------

"--------------------------------------------------------------------------------
" environment setting start
"--------------------------------------------------------------------------------
" カラー設定:
if has('patch-7.4.1778')
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
" autocmd ColorScheme * highlight Visual term=reverse ctermbg=242 guibg=#434C5E
" autocmd ColorScheme * highlight Comment term=bold ctermfg=244 guifg=#616E88
" シンタックスハイライト
syntax on
" カラースキーム
set background=dark
colorscheme nord
" 透過設定
if has('nvim')
  highlight Normal ctermbg=none guibg=none
  highlight NonText ctermbg=none guibg=none
  highlight LineNr ctermbg=none guibg=none
  highlight Folded ctermbg=none guibg=none
  highlight EndOfBuffer ctermbg=none guibg=none
endif
" エンコード
set encoding=utf8
" GUI フォント
set guifont=Cica:h13

" ファイルエンコード
set fileencoding=utf-8
" スクロールする時に下が見えるようにする
set scrolloff=10
" .swapファイルを作らない
set noswapfile
" バックアップファイルを作らない
set nowritebackup
" バックアップをしない
set nobackup
" バックスペースで各種消せるようにする
set backspace=indent,eol,start
" ビープ音を消す
" set vb t_vb=
" set novisualbell
set visualbell t_vb=
" OSのクリップボードを使う
"set clipboard+=unnamed
set clipboard=unnamed
" 不可視文字を表示
" set list
" 行番号を表示
set number
" 右下に表示される行・列の番号を表示する
set ruler
" compatibleオプションをオフにする
set nocompatible
" 移動コマンドを使ったとき、行頭に移動しない
set nostartofline
" 対応括弧に<と>のペアを追加
set matchpairs& matchpairs+=<:>
" 対応括弧をハイライト表示する
set showmatch
" 対応括弧の表示秒数を3秒にする
set matchtime=3
" ウィンドウの幅より長い行は折り返さない
set nowrap
" 入力されているテキストの最大幅を無効にする
set textwidth=0
" 不可視文字を表示
" set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
" インデントをshiftwidthの倍数に丸める
set shiftround
" 補完の際の大文字小文字の区別しない
set infercase
" 文字がない場所にもカーソルを移動できるようにする
" set virtualedit=all
" 変更中のファイルでも、保存しないで他のファイルを表示
set hidden
" 新しく開く代わりにすでに開いてあるバッファを開く
set switchbuf=useopen
" 小文字の検索でも大文字も見つかるようにする
set ignorecase
" ただし大文字も含めた検索の場合はその通りに検索する
set smartcase
" インクリメンタルサーチを行う
set incsearch
" 検索結果をハイライト表示
set hlsearch
" ESCキー2度押しでハイライトの切り替え
nnoremap <Esc><Esc> :<C-u>set nohlsearch!<CR>
" コマンド、検索パターンを10000個まで履歴に残す
set history=10000
" Undoファイルを作らない
set noundofile
" 変な位置で改行しない
set formatoptions=
" タイトルを表示しない
set notitle
" コマンドモードの補完
set wildmenu
" カーソル行表示
set cursorline
" iTerm2でInsertモードの時にカーソル形状を変える
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" ctagsの設定
if has("path_extra")
  set tags+=tags;
endif
" 作業フォルダの設定
set autochdir
" タブの設定
set autoindent 		" 改行時に前の行のインデントを継続する
set smartindent		" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set smarttab			" 新しい行を作った時に高度な自動インデントを行う
set expandtab			" タブ入力を複数の空白入力に置き換える
set tabstop=2			" 画面上でタブ文字が占める幅
set shiftwidth=2 	" smartindentで増減する幅
set softtabstop=2	" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
if has("autocmd")
  filetype plugin on
  filetype indent on 

  "sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtab
  autocmd FileType text	setlocal sw=4 sts=4 ts=4 et
  autocmd FileType java	setlocal sw=4 sts=4 ts=4 et
  autocmd FileType markdown	setlocal sw=2 sts=2 ts=2 et 
  autocmd FileType groovy	setlocal sw=4 sts=4 ts=4 et
  autocmd FileType php	setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sh	setlocal sw=4 sts=4 ts=4 et
  autocmd FileType org	setlocal sw=2 sts=2 ts=2 et
  autocmd BufRead,BufNewFile *.json set filetype=jsonc
endif
" ステータスラインを表示する
set laststatus=2      
set t_Co=256
" leader設定
"map ¥ <leader>
map , <leader>
" map <space> <leader>
" ターミナルタイトル設定
set title
if ! has("patch-8.1.0253")
  let &t_ti .= "\e[22;0t"
  let &t_te .= "\e[23;0t"
endif


"--------------------------------------------------------------------------------
" environment setting end
"--------------------------------------------------------------------------------


"--------------------------------------------------------------------------------
" coc setting start
"--------------------------------------------------------------------------------
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
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
    call CocActionAsync('doHover')
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

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ca  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"
" 補完設定
" 補完表示時のEnterで改行をしない
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

" ショートカット
nnoremap <leader>q :q!<CR>
nnoremap <leader>m %
nmap NN ]m
"nmap PP [m
autocmd QuickFixCmdPost *grep* cwindow
nnoremap <silent><nowait> ss :TagbarToggle<cr>
inoremap <silent> jj <ESC>

set completeopt=menuone,noinsert
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"

" Extensions
let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-emmet',
  \ 'coc-eslint',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-markdownlint',
  \ 'coc-prettier',
  \ 'coc-phpls',
  \ 'coc-pyright',
  \ 'coc-pydocstring',
  \ 'coc-snippets',
  \ 'coc-tailwindcss',
  \ 'coc-tsserver',
  \ 'coc-vetur',
  \ ]

"--------------------------------------------------------------------------------
" coc setting end
"--------------------------------------------------------------------------------


"--------------------------------------------------------------------------------
" nvim terminal setting start
"--------------------------------------------------------------------------------
tnoremap <Esc> <C-\><C-n>
command! -nargs=* T split | wincmd j | resize 20 | terminal <args>
if has('nvim')
  autocmd TermOpen * startinsert
endif
"--------------------------------------------------------------------------------
" nvim terminal setting start
"--------------------------------------------------------------------------------


"--------------------------------------------------------------------------------
" jq format start
"--------------------------------------------------------------------------------
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "%! jq \"" . l:arg . "\""
endfunction
"--------------------------------------------------------------------------------
" jq format end
"--------------------------------------------------------------------------------

" "--------------------------------------------------------------------------------
" " vimdiff setting start
" "--------------------------------------------------------------------------------
set diffopt=iwhite
" highlight DiffAdd    ctermfg=black ctermbg=2
" highlight DiffChange ctermfg=black ctermbg=3
" highlight DiffDelete ctermfg=black ctermbg=6
" highlight DiffText   ctermfg=black ctermbg=7
" "--------------------------------------------------------------------------------
" " vimdiff setting end
" "--------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Tabs
"-------------------------------------------------------------------------------
" Open current directory
nmap te :tabedit<CR>
nmap <silent><S-Tab> :tabprev<CR>
nmap <silent><Tab> :tabnext<CR>

" ファイルタイプ関連を有効にする
filetype plugin indent on

"--------------------------------------------------------------------------------
" nord-theme
"--------------------------------------------------------------------------------
augroup nord-theme-overrides
  autocmd!
  " Use 'nord7' as foreground color for Vim comment titles.
  autocmd ColorScheme nord highlight vimCommentTitle ctermfg=14 guifg=#8FBCBB
augroup END

"--------------------------------------------------------------------------------
" vdebug
"--------------------------------------------------------------------------------
highlight DbgBreakptSign cterm=reverse ctermfg=2 gui=reverse guifg=#A3BE8C guibg=#2E3440
highlight DbgBreakptLine cterm=NONE
highlight DbgCurrentSign cterm=reverse ctermfg=1 gui=reverse guifg=#BF616A guibg=#2E3440
highlight DbgCurrentLine cterm=underline ctermfg=1 gui=undercurl guifg=#BF616A guibg=#2E3440 guisp=#BF616A
" highlight DbgCurrentLine cterm=reverse ctermfg=1 gui=reverse guifg=#BF616A guibg=#2E3440

"--------------------------------------------------------------------------------
" other
"--------------------------------------------------------------------------------
" 貼り付けたテキストの末尾へ自動的に移動する
" vnoremap <silent> y y`]
" vnoremap <silent> p p`]
" nnoremap <silent> p p`]

" 貼り付け時にペーストバッファが上書きされないようにする
" xnoremap p "_dP

" カーソル下のhighlight情報を表示する
function! s:get_syn_id(transparent)
  let synid = synID(line('.'), col('.'), 1)
  return a:transparent ? synIDtrans(synid) : synid
endfunction
function! s:get_syn_name(synid)
  return synIDattr(a:synid, 'name')
endfunction
function! s:get_highlight_info()
  execute "highlight " . s:get_syn_name(s:get_syn_id(0))
  execute "highlight " . s:get_syn_name(s:get_syn_id(1))
endfunction
command! HighlightInfo call s:get_highlight_info()

