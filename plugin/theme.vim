function! ShowBackground()
  let g:bg_flag = 1
  highlight LineNr ctermfg=237
  execute 'colorscheme '.tolower(g:colors_name)
  call mytabline#colors()
endfunction

function! HideBackground()
  let g:bg_flag = 0
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
  highlight LineNr ctermbg=none ctermfg=245
  highlight Visual ctermbg=232
endfunction

function! theme#ToggleBackground()
  if g:bg_flag == 0
    call ShowBackground()
  else
    call HideBackground()
  endif
endfunction

let g:bg_flag = 1
syntax on
set t_Co=256
set background=dark
colorscheme hybrid_material
highlight! link QuickFixLine Normal
