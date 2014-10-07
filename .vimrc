"カーソルキーで行末／行頭の移動可能に設定
set whichwrap=b,s,[,],<,>
"バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
"□や○の文字があってもカーソル位置がずれないようにする
set ambiwidth=double
"カーソル行の背景色を変更する
set cursorline
"制限解除
set modifiable
"----------------------------------------
" 検索
"----------------------------------------
"検索の時に大文字小文字を区別しない
"ただし大文字小文字の両方が含まれている場合は大文字小文字を区別する
set ignorecase
set smartcase
"検索時にファイルの最後まで行ったら最初に戻る
set wrapscan
"インクリメンタルサーチ
set incsearch
"検索文字の強調表示
set hlsearch
"w,bの移動で認識する文字
"set iskeyword=a-z,A-Z,48-57,_,.,-,>
"vimgrep をデフォルトのgrepとする場合internal
"set grepprg=internal
"
"---------------------------------------
" 表示設定
"----------------------------------------
"スプラッシュ(起動時のメッセージ)を表示しない
"set shortmess+=I
"エラー時の音とビジュアルベルの抑制(gvimは.gvimrcで設定)
set noerrorbells
set novisualbell
set visualbell t_vb=
"マクロ実行中などの画面再描画を行わない
"set lazyredraw
"行番号表示
set number
"括弧の対応表示時間
set showmatch matchtime=1
"タブを設定
"set ts=4 sw=4 sts=4
"自動的にインデントする
set autoindent
"Cインデントの設定
set cinoptions+=:0
"タイトルを表示
set title
"コマンドラインの高さ (gvimはgvimrcで指定)
set cmdheight=2
set laststatus=2
"コマンドをステータス行に表示
set showcmd
"画面最後の行をできる限り表示する
set display=lastline
"Tab、行末の半角スペースを明示的に表示する
set list
set listchars=tab:^\ ,trail:~
"Tabを押すと半角スペースを４つ挿入する
set tabstop=4
set expandtab

"Tabでのカーソル移動を４文字分にする
set softtabstop=4
set shiftwidth=4

"grep検索を設定する
set grepformat=%f:%l:%m,%f:%l%m,%f  %l%m
set grepprg=grep\ -n

"md,mdwn,mkd,mkdn,markの拡張子を持つファイルはmarkdownファイルとして認識する
autocmd MyAutoGroup BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

" ハイライトを有効にする
if &t_Co > 2 || has('gui_running')
  syntax on
endif
"--------------------------------------
"キーバインド
"---------------------------------------
"¥と\を逆にする
noremap! ¥ \
noremap \ ¥
"一文単位の上下ではなく、視覚的な上下で移動する
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up> gk
"F2でNERDTreeを開閉する
nnoremap <f2> :NERDTreeToggle<CR>
"Ctrl + L でEscと同じ効果
noremap! <C-l>   <Esc>
"insert（挿入）モードの時にShift+移動で選択を開始する
noremap! <S-UP> <ESC>v<UP>
noremap! <S-DOWN> <ESC>v<DOWN>
noremap! <S-Left> <ESC>v
noremap! <S-Right> <ESC><Right>v
"ファイル内全てHTMLコメントアウトして下にコピーもする
noremap ,/ gg<S-v><S-g>yggi<!--<ESC><S-g>$a--><ESC>o<ESC>p
"行をHTMLコメントアウトして下にコピーする
noremap ,. <S-v>y0i<!--<ESC>$a--><ESC>o<ESC>p
"検索結果のハイライトをEsc連打でクリアする
nnoremap <ESC><ESC> :nohlsearch<CR>
"選択中のファイルをNERDTree で探して開く
nnoremap <f3> :NERDTreeFind<CR>
nnoremap <C-h> :NERDTreeFind<CR>
"最近使ったファイル一覧を表示する
nnoremap <f4> :Unite file_mru<CR>
nnoremap <C-j> :Unite file_mru<CR>
"現在開いているバッファ一覧
nnoremap <f5> :Unite buffer<CR>
nnoremap <C-k> :Unite buffer<CR>
"カンマ + o でアウトラインを表示
let g:unite_enable_split_vertically = 0
"アウトラインの幅指定
let g:unite_winwidth = 40
"表示位置は道
let g:unite_split_rule = "rightbelow"
nnoremap <silent> ,o :<C-u>Unite -vertical -winheight=0 -no-quit outline<CR>

"Jqコマンド
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "%! jq 95fe1a73-e2e2-4737-bea1-a44257c50fc8quot;" . l:arg . "95fe1a73-e2e2-4737-bea1-a44257c50fc8quot;"
endfunction

" 全角スペース・行末のスペース・タブの可視化
if has("syntax")
    syntax on

    " PODバグ対策
    syn sync fromstart

    function! ActivateInvisibleIndicator()
        " 下の行の"　"は全角スペース
        syntax match InvisibleJISX0208Space "　" display containedin=ALL
        highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=darkgray gui=underline
        "syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
        "highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=NONE gui=undercurl guisp=darkorange
        "syntax match InvisibleTab "\t" display containedin=ALL
        "highlight InvisibleTab term=underline ctermbg=white gui=undercurl guisp=darkslategray
    endfunction

    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif

" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

"自動的にコマンドを実行する
let g:neocomplcache_enable_at_startup = 1
let file_name = expand("%")
if has('vim_starting') &&  file_name == ""
    autocmd VimEnter * NERDTree ./
endif

"vimが起動したとき
if has('vim_starting')
  "新しい導入プラグインがあったらインストールを確認する
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

"GUIモードで起動したとき
"if has("gui_running")
"    "フルスクリーンで始める
"    set fuoptions=maxvert,maxhorz
"    au GUIEnter * set fullscreen
"endif

NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
call neobundle#rc(expand('~/.vim/bundle/'))

"neosnippet
" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
"自作のスニペットファイルも指定して適応する
let g:neosnippet#snippets_directory=$HOME.'/.vim/snippets'

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"--------------------------
"導入プラグイン
"--------------------------

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle "Shougo/vimproc"
NeoBundle "Shougo/vimfiler"
NeoBundle "Shougo/vimshell"
NeoBundle "Shougo/unite.vim"
NeoBundle "Shougo/neocomplcache"
NeoBundle "Shougo/neosnippet"
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle "pangloss/vim-javascript"
NeoBundle "scrooloose/nerdcommenter"
NeoBundle "tpope/vim-surround"
NeoBundle "scrooloose/syntastic"
NeoBundle "jiangmiao/simple-javascript-indenter"
NeoBundle "rcmdnk/vim-markdown"
NeoBundle "thinca/vim-quickrun"
NeoBundle "kien/ctrlp.vim"
NeoBundle "Shougo/unite-outline"
NeoBundle "tyru/restart.vim"
NeoBundle 'Shougo/neomru.vim'

" add plugins

filetype plugin indent on
syntax on

NeoBundleCheck
