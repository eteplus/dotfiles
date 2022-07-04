" 自动切换输入法
if executable('im-select')
  autocmd InsertLeave * :call system("im-select com.apple.keylayout.ABC")
  autocmd CmdlineLeave * :call system("im-select com.apple.keylayout.ABC")
endif

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/autoload/')
  " 快速跳转
  Plug 'easymotion/vim-easymotion'
  " 包裹修改
  Plug 'tpope/vim-surround'
  " 语法高亮
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  " 文件列表
  Plug 'preservim/nerdtree'
  " 状态栏
  Plug 'vim-airline/vim-airline'
call plug#end()

" 设置前导键
let mapleader=","

" 使用系统剪切板
set clipboard+=unnamedplus

" 不创建备份文件
set nobackup

" 语法高亮
syntax enable

" 显示行号
set number
" 设置相对行号
set relativenumber
" 设置行宽
set textwidth=120
" 设置自动换行
set wrap
" 是否显示状态栏
set laststatus=2
" 语法高亮
syntax on
" 支持鼠标
set mouse=a
" 设置编码格式
set encoding=utf-8
" 启用256色
set t_Co=256
" 开启文件类型检查
filetype indent on
" 设置自动缩进
set autoindent
" 设置tab缩进数量
set tabstop=2
" 设置 >> 与 << 的缩进数量
set shiftwidth=2
" 设置显示命令
set showcmd
" 将缩进转换为空格
set expandtab
" 自动高亮匹配符号
set showmatch
" 自动高亮匹配搜索结果
set nohlsearch
" 开启逐行搜索，也就是说按下一次按键就继续一次搜索
set incsearch
" 开启类型检查
" set spell spelllang
" 开启命令补全
set wildmenu
" 不创建备份文件
set nobackup
" 不创建交换文件
set noswapfile
" 多窗口下光标移动到其他窗口时自动切换工作目录
set autochdir
" 设置不搜索的文件和文件夹
set wildignore+=*/node_modules/*

set cursorline

" Set cursor line color on visual mode
highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40

highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

" Esc 映射
imap <C-j> <Esc>
imap jj <Esc>
imap jk <Esc>

" 缩进快捷键映射
nnoremap < <<
nnoremap > >>

" 用H替换掉^
noremap H ^

" 用L替换掉$
noremap L $

" easymotion 配置
let g:EasyMotion_smartcase = 0

map <Leader> <Plug>(easymotion-prefix)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

" NERDTree 配置
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" Move Window
nmap <Space> <C-w>w

" Tabs
nmap <S-Tab> :tabprev<Return>
nmap <Tab> :tabnext<Return>
