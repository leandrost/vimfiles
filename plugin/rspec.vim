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

  if stridx(s, 'app/') >= 0
    let s = substitute(s, 'src/', 'spec/', '')
    let s = substitute(s, 'app/', 'spec/', '')
    let s = substitute(s, '.rb', '_spec.rb', '')
  endif

  return s
endfunction

function! AlternateToSpec()
  let file_path = expand('%r')

  if stridx(file_path, 'app/') >= 0
    let file_path = substitute(file_path, '/app/', '/spec/', '')
    let file_path = substitute(file_path, '.rb', '_spec.rb', '')

  elseif stridx(file_path, 'lib/') >= 0
    let file_path = substitute(file_path, 'lib/', 'spec/', '')
    let file_path = substitute(file_path, '.rb', '_spec.rb', '')
    let file_path = substitute(file_path, '.rake', '_spec.rb', '')

  elseif stridx(file_path, 'src/') >= 0

    let file_path = substitute(file_path, 'src/', 'spec/', '')
    let file_path = substitute(file_path, '.rb', '_spec.rb', '')

  elseif stridx(file_path, 'spec/tasks') >= 0
    let file_path = substitute(file_path, 'spec/', 'lib/', '')
    let file_path = substitute(file_path, '_spec.rb','.rake',  '')

  elseif stridx(file_path, 'spec/') >= 0

    let file_path = substitute(file_path, 'spec/', 'src/', '')
    let file_path = substitute(file_path, '_spec.rb','.rb',  '')
  endif

  execute 'edit '.file_path
endfunction

function! GetJsSpecPath()
  let s = expand('%')
  return s
endfunction

