" Source: https://neovim.io/doc/user/ft_rust.html

" This is used for automatically formatting Rust code on save
autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = false })

" Run cargo clippy on save and populate quickfix list
augroup RustClippyOnSave
  autocmd!
  autocmd BufWritePost *.rs call RunClippy()
augroup END

function! RunClippy()
  if !executable('cargo')
    echom "cargo not found in PATH"
    return
  endif

  " Run cargo clippy and capture output into quickfix list
  cexpr system('cargo clippy --message-format=short 2>&1')

  " Open quickfix window if there are errors/warnings
  " if len(getqflist()) > 0
  "   copen
  " else
  "   cclose
  " endif
endfunction

