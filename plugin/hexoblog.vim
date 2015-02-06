" Vim global plugin for hexo 
" Last Change: 
" Maintainer: svtter <svtter@qq.com>
" License: 

if !exists("g:hexo_blogpath") 
    let g:hexo_blogpath = ""
endif


if !exists(":Newblog")
  command -nargs=?  Newblog call s:NewPost(<f-args>)
endif

if !exists(":Pushpost")
  command -nargs=?  Pushpost call s:Pushpost(<f-args>)
endif

" Transform string to functions
" We cannot use `:e filename` so make it a function
function! s:Trans()
    let s:filename = g:hexo_blogpath . "/source/_posts/" . s:title . ".md"
    return s:filename
endfunction

" Run command that build new blog
function! s:Runcmd()
    let s:cmd = "!bash -c 'cd " . g:hexo_blogpath . "; hexo n \'". s:title ."\' | cut -f3- -dt\'"
    execute s:cmd
endfunction

" Create a New post
function! s:NewPost(...)
    if g:hexo_blogpath != ""
        if a:0 ==""
            let s:title = input("Input the blog title: ")
        else
            let s:title = a:000[0]
        endif
        call s:Runcmd()
        edit `=s:Trans()`
    else
        echo "Not set hexo_blogpath, use `let g:hexo_blogpath=` to set"
    endif
endfunction

" Update blog command
function! s:Update()
    let s:cmd = "!bash -c 'cd " . g:hexo_blogpath . "; hexo g; hexo d;'"
    execute s:cmd
endfunction


" Pust post to website
function! s:Pushpost(...)
    call s:Update()
endfunction
    




" For test

" Future to add
" if !exists(":NewPost")
  " command -nargs=?  NewPost call s:show(<f-args>)
" endif

" let g:aa = ""

" function! s:show(...)
    " if g:aa != ""
        " if a:0 ==""
            " echo g:aa . " is NULL"
        " else
            " echo g:aa . " is ".a:000[0]
        " endif
    " else
        " echo "Not set aa"
    " endif
" endfunction
" call s:NewPost()
