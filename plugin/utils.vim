function! utils#WriteCreatingDir()
    execute ':silent !mkdir -p %:h'
    write
    redraw!
endfunction

function! CloseOtherBuffers()
  let curr = bufnr("%")
  let last = bufnr("$")

  if curr > 1    | silent! execute "1,".(curr-1)."bd"     | endif
  if curr < last | silent! execute (curr+1).",".last."bd" | endif
endfunction
