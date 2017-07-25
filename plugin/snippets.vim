function! snippets#interaction_spec_name()
  let namespace = substitute(expand('%:p:h:t'), '\(_\|^\)\(.\)', '\u\2', 'g')
  let spec_file_name = substitute(vim_snippets#Filename(), '\(_\|^\)\(.\)', '\u\2', 'g')
  let interaction_name = substitute(spec_file_name, 'Spec$', '', 'g')
  let spec_name = namespace.'::'.interaction_name
  return spec_name
endfunction
