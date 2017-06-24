function! utils#WriteCreatingDir()
    execute ':silent !mkdir -p %:h'
    write
    redraw!
endfunction
