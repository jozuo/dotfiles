set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc


if has('nvim')
  if has("unix")
    let s:uname = system("uname -s")
    if s:uname == "Darwin\n"
      let g:python_host_prog  = '~/.pyenv/shims/python'
      let g:python3_host_prog = '~/.pyenv/shims/python3'
      let g:ruby_host_prog = '/usr/local/lib/ruby/gems/2.6.0/bin/neovim-ruby-host'
    endif
  endif
endif
