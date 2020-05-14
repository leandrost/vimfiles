function! mytabline#symbol(name)
  return WebDevIconsGetFileTypeSymbol(a:name)
endfunction

function! mytabline#execute()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' '

    let s .= tab .' '
    let s .= (bufname != '' ? fnamemodify(bufname, ':t') : '[No Name]')


    if bufmodified
      let s .= '+ '
    else
      let s .= '  '
    endif

    let s .= mytabline#symbol(bufname)
    let s .= '  '
  endfor

  let s .= '%#TabLineFill#'

  return s
endfunction

function! mytabline#colors()
  hi TabLineFill ctermfg=232
  hi TabLine ctermfg=248 ctermbg=232
endfunction

set tabline=%!mytabline#execute()
call mytabline#colors()
