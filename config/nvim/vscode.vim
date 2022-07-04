set nobackup
let mapleader=","
set nohlsearch

" 使用系统剪切板
set clipboard=unnamed

" 自动切换输入法
if executable('im-select')
  autocmd InsertLeave * :call system("im-select com.apple.keylayout.ABC")
  autocmd CmdlineLeave * :call system("im-select com.apple.keylayout.ABC")
endif

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/vscode.vim
endif

call plug#begin('~/.config/nvim/autoload/')
  Plug 'asvetliakov/vim-easymotion', { 'dir': '~/.config/nvim/autoload/vscode-vim-easymotion' }
  Plug 'tpope/vim-surround'
call plug#end()

" 缩进快捷键映射
nnoremap < <<
nnoremap > >>

" 切换行注释
nnoremap gc <Cmd>call VSCodeNotify('editor.action.commentLine')<CR>
" 切换块注释
nnoremap gC <Cmd>call VSCodeNotify('editor.action.blockComment')<CR>
" 展开所有折叠
nnoremap zR <Cmd>call VSCodeNotify('editor.unfoldAll')<CR>
" 关闭所有折叠
nnoremap zM <Cmd>call VSCodeNotify('editor.foldAll')<CR>
" 展开当下折叠
nnoremap zo <Cmd>call VSCodeNotify('editor.unfold')<CR>
" 关闭当下折叠
nnoremap zc <Cmd>call VSCodeNotify('editor.fold')<CR>
" 切换当下折叠
nnoremap zz <Cmd>call VSCodeNotify('editor.toggleFold')<CR>
" 转到文件中上一个问题
nnoremap g[ <Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>
" 转到文件中下一个问题
nnoremap g] <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>
" 用H替换掉^
noremap H ^
" 用L替换掉$
noremap L $

" 使用 vscode 的 undo 替换 nvim 的 undo
nnoremap u <Cmd>call VSCodeNotify('undo')<CR>

" easymotion相关配置
let g:EasyMotion_smartcase = 0
map <Leader> <Plug>(easymotion-prefix)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
