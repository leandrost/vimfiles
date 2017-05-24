function! MyFiletype(name)
  return WebDevIconsGetFileTypeSymbol(a:name)
endfunction

function! Tabline()
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

    let s .= MyFiletype(bufname)
  endfor

  let s .= '%#TabLineFill#'

  return s
endfunction

set tabline=%!Tabline()
