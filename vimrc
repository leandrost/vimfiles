"""  Pathogen Initialization
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

""" General Config
runtime macros/matchit.vim
syntax on
set number
set nowrap
set mouse=a
set encoding=utf-8

" only on WINDOWS
if has("win32")
  set runtimepath=~/.vim,$VIMRUNTIME
  set backspace=indent,eol,start whichwrap+=<,>,[,]
  imap <C-S-V> <ESC>"+gP
endif

""" Statusbar
set laststatus=2
set ruler
set showcmd

""" Indentation 
set autoindent
set expandtab
filetype plugin indent on

autocmd FileType * set tabstop=2 
autocmd FileType * set softtabstop=2
autocmd FileType * set shiftwidth=2

autocmd FileType python,java set tabstop=4 
autocmd FileType python,java set tabstop=4 
autocmd FileType python,java set softtabstop=4

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" ================ Completion =======================
"
" set wildmode=list:longest
" set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
" set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
" set wildignore+=*vim/backups*
" set wildignore+=*sass-cache*
" set wildignore+=*DS_Store*
" set wildignore+=vendor/rails/**
" set wildignore+=vendor/cache/**
" set wildignore+=*.gem
" set wildignore+=log/**
" set wildignore+=tmp/**
" set wildignore+=*.png,*.jpg,*.gif

"""" Session
let g:sessions_dir = $HOME."/.vim/sessions/"
let g:default_session = "default"
let g:myfinance_session = "myfinance"

function! MakeSession(session_name)
  execute "mksession! ".g:sessions_dir.a:session_name.".vim"
endfunction

function! RecoverSession(session_name)
  let session_file = g:sessions_dir.a:session_name.".vim"
  if filereadable(session_file)
    execute "source ".session_file
    call HideBackground()
  end
endfunction

function! SaveSession()
  if !isdirectory(g:sessions_dir)
    call mkdir(g:sessions_dir)
  endif
  if getcwd() == $HOME."/projects/myfinance/src"
    call MakeSession(g:myfinance_session)
  else
    call MakeSession(g:default_session)
  endif
endfunction

function! LoadSession()
  if argc() == 0 
    let myfinance_path = $HOME."/projects/myfinance/src"
    let session_name = getcwd() == myfinance_path ? g:myfinance_session : g:default_session
    call RecoverSession(session_name)
  endif
endfunction

autocmd VimLeave * nested call SaveSession()
autocmd VimEnter * nested call LoadSession()

""" Colors
set t_Co=256
set background=dark
colorscheme tomorrow-night
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight rubydefine ctermbg=none

let g:bg_flag = 0

function! ShowBackground()
  let g:bg_flag = 1
  execute 'colorscheme '.tolower(g:colors_name)
endfunction 

function! HideBackground()
  let g:bg_flag = 0
  execute 'colorscheme '.tolower(g:colors_name)
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
  highlight LineNr ctermbg=none
  highlight rubydefine ctermbg=none
endfunction

function! ToggleBackground()
  if g:bg_flag == 0
    call ShowBackground() 
  else
    call HideBackground()
  endif
endfunction

""" Search
set hlsearch
set incsearch

""" File types
"let javaScript_fold=1
"let ruby_fold=1
"let html_fold=1
"autocmd Syntax rb,javascript,vim,gitcommit,xml,html,xhtml set foldmethod=syntax
"autocmd Syntax rb,javascript,vim,gitcommit,xml,html,xhtml normal zR
autocmd BufRead,BufNewFile *spec.js  set filetype=javascript.javascript-test
autocmd BufRead,BufNewFile *Spec.js  set filetype=javascript.javascript-test
autocmd BufRead,BufNewFile *.erb  set filetype=eruby.html
autocmd BufRead,BufNewFile *.exbl  set filetype=ruby.html
autocmd BufRead,BufNewFile *.srt set filetype=srt
autocmd BufRead,BufNewFile *.vb set filetype=vb
autocmd BufRead,BufNewFile *.ofx set filetype=xml

""" Key Mapping
"CUSTOM MAPS
map <C-l> :let @/=""<CR>
map <F2> :NERDTreeToggle<CR>
map <F3> :%!xmllint --encode UTF-8 --format -<CR>
map <F5> :e<CR>
map <F6> obinding.pry<ESC>
map <F12> :call ToggleBackground()<CR>
map <S-F6> Obinding.pry<ESC>

"COPY, PASTE, DELETE
map \p "+p
vmap <C-x> "+d<CR>
vmap <C-c> "+y<CR>
imap <C-v> <ESC>"+p==<space>

map \y "+y
map \yy "+yy
map \yw "+yw
map \yb "+yb


"MOVE LINE
nmap <C-j> :m+<CR>==
nmap <C-k> :m-2<CR>==
vmap <C-j> :m'>+<CR>gv=gv
vmap <C-k> :m-2<CR>gv=gv

map v$$ vg_
map cu ct_
map cU F_lct_

map <S-Insert> <MiddleMouse>
cmap w!! %!sudo tee > /dev/null %
cmap qq tabclose

"EMMET
imap <c-j> <C-y>,

"RSPEC
function! RunRspec(args)
  let args = '' 
  if a:args != ''
    let args .= ' -l '.a:args 
  end
  if a:args == '-'
    let cmd = g:last_rspec
  else
    let cmd = "rspec ".expand("%").args
  end
  execute 'silent execute "!echo ".cmd." > /dev/pts/2" | redraw!'
  execute 'silent execute "!".cmd." > /dev/pts/2" | redraw!'
  let g:last_rspec = cmd
endfunction

function! GetSpecPath()
  let s = expand('%')

  if stridx(s, 'app/') >= 0
    let s = substitute(s, 'app/', 'spec/', '') 
    let s = substitute(s, '.rb', '_spec.rb', '') 
  endif

  return s
endfunction

map \r :let @+= "rspec ".GetSpecPath()<CR>
map \l :let @+= "rspec ".GetSpecPath(). " -l ".line('.')<CR>

""" Commands
command! FF FufFile
command! BG call ToggleBackground()
command! S w !sudo tee %
command! -nargs=1 MKS call MakeSession(<f-args>)
command! -nargs=1 RSE call RecoverSession(<f-args>)

"CUSTOM TABS
function! MyTabLine()
  let s = ''
  let wn = ''
  let t = tabpagenr()
  let i = 1
  while i <= tabpagenr('$')
    let buflist = tabpagebuflist(i)
    let winnr = tabpagewinnr(i)
    let s .= '%' . i . 'T'
    let s .= (i == t ? '%1*' : '%2*')
    let wn = tabpagewinnr(i,'$')

    let s .= (i== t ? '%#TabNumSel#' : '%#TabNum#')
    let s .= ' '
    let s .= i
    if tabpagewinnr(i,'$') > 1
      let s .= '/'
      let s .= (i== t ? '%#TabWinNumSel#' : '%#TabWinNum#')
      let s .= (tabpagewinnr(i,'$') > 1 ? wn : '')
    end

    let s .= ' %*'
    let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
    let bufnr = buflist[winnr - 1]
    let file = bufname(bufnr)
    let buftype = getbufvar(bufnr, 'buftype')
    if buftype == 'nofile'
      if file =~ '\/.'
        let file = substitute(file, '.*\/\ze.', '', '')
      endif
    else
      let file = fnamemodify(file, ':p:t')
    endif
    if file == ''
      let file = '[No Name]'
    endif
    if getbufvar(bufnr, "&modified")
      let s.= (i == t ? '%#TabModFlagSel#' : '%#TabModFlag#')
    endif
    let s .= file
    let s .= ' '
    let i = i + 1
  endwhile
  let s .= '%T%#TabLineFill#%='
  let s .= '%=%#TabClose#%999X X'

  highlight TabLineSel term=bold cterm=bold ctermfg=252 ctermbg=none
  highlight TabWinNumSel term=bold cterm=bold ctermfg=11 ctermbg=none
  highlight TabNumSel term=bold cterm=bold ctermfg=226 ctermbg=none
  highlight TabModFlagSel term=bold cterm=bold ctermfg=208 ctermbg=none

  highlight TabLineFill cterm=none 
  highlight TabLine cterm=none 

  highlight TabClose term=bold cterm=none ctermfg=255 ctermbg=none

  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return bufname(buflist[winnr - 1])

endfunction

"set tabline=%!MyTabLine()

set tabpagemax=15
"good tab completion - press <tab> to autocomplete if there's a character
"previously
function! InsertTabWrapper()
      let col = col('.') - 1
      if !col || getline('.')[col - 1] !~ '\k'
          return "\<tab>"
      else
          return "\<c-p>"
      endif
endfunction

""" Folding
set nofoldenable
vmap <space> zf

function! ToggleFold()
   if foldlevel('.') == 0
      " No fold exists at the current line,
      " so create a fold based on indentation

      let l_min = line('.')   " the current line number
      let l_max = line('$')   " the last line number
      let i_min = indent('.') " the indentation of the current line
      let l = l_min + 1

      " Search downward for the last line whose indentation > i_min
      while l <= l_max
         " if this line is not blank ...
         if strlen(getline(l)) > 0 && getline(l) !~ '^\s*$'
            if indent(l) <= i_min

               " we've gone too far
               let l = l - 1    " backtrack one line
               break
            endif
         endif
         let l = l + 1
      endwhile

      " Clamp l to the last line
      if l > l_max
         let l = l_max
      endif

      " Backtrack to the last non-blank line
      while l > l_min
         if strlen(getline(l)) > 0 && getline(l) !~ '^\s*$'
            break
         endif
         let l = l - 1
      endwhile

      "execute "normal i" . l_min . "," . l . " fold"   " print debug info

      if l > l_min
"         " Create the fold from l_min to l
         execute l_min . "," . l . " fold"
      endif
   else
      " Delete the fold on the current line
      normal zd
   endif
endfunction

nmap <space> :call ToggleFold()<CR>

function! WriteCreatingDirs()
    execute ':silent !mkdir -p %:h'
    write
endfunction
command W call WriteCreatingDirs()

"CTRLP
let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("h")': ['<c-x>', '<c-s>'],
      \ 'AcceptSelection("e")': ['<c-r>', '<c-space>'],
      \ 'AcceptSelection("t")': ['<cr>', '<c-t>', '<2-LeftMouse>'],
      \ }

"Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_theme = 'powerlineish'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#fnamemod = ':p:t'