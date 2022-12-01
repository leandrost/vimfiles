function! RunRspec(args)
  let args = ''
  if a:args != ''
    let args .= ':'.a:args
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

  if stridx(s, '_spec.rb') >= 0
    return s
  endif

  if stridx(s, 'app/') >= 0
    let s = substitute(s, 'app/', 'spec/', '')
    let s = substitute(s, '.rb', '_spec.rb', '')
  endif

  return s
endfunction


function! SmartAlternate()
  try
    execute 'A'
  catch
    execute 'call AlternateToSpecPath()'
  endtry
endfunction

function! Alternate()
  try
    execute 'A'
  catch
    execute 'edit '.rails#buffer().alternate(0)
  endtry
endfunction

function! AlternateToSpecPath()
  let s = expand('%')

  if stridx(s, '_spec.rb') >= 0
    let s = substitute(s, 'spec/', 'app/', '')
    let s = substitute(s, '_spec.rb', '.rb', '')
  else
    let s = substitute(s, 'app/', 'spec/', '')
    let s = substitute(s, '.rb', '_spec.rb', '')
  endif

  execute 'edit '.s
endfunction

function! GetJsSpecPath()
  let s = expand('%')
  return s
endfunction
