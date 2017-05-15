function! ShowBackground()
  let g:bg_flag = 1
  highlight LineNr ctermfg=237
  execute 'colorscheme '.tolower(g:colors_name)
endfunction

function! HideBackground()
  let g:bg_flag = 0
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
  highlight LineNr ctermbg=none ctermfg=245
endfunction

function! background#ToggleBackground()
  if g:bg_flag == 0
    call ShowBackground()
  else
    call HideBackground()
  endif
endfunction

function! WriteCreatingDirs()
    execute ':silent !mkdir -p %:h'
    write
endfunction
