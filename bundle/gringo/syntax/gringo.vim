if version < 600
   syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn include @Lua syntax/lua.vim

syn case match

syn match  gringoKeyword	"\*%"
syn match  gringoComment	+%.*+
syn region gringoBlockComment start="%\*" end="\*%"

syn match  gringoError          "#.*"

syn region luaCode          matchgroup=gringoKeyword start="#begin_lua" keepend end="#end_lua" contains=@Lua
syn match  gringoKeyword	"#ishift"
syn match  gringoKeyword	"#base"
syn match  gringoKeyword	"#domain"
syn match  gringoKeyword	"#hide"
syn match  gringoKeyword	"#show"
syn match  gringoKeyword	"#cumulative"
syn match  gringoKeyword	"#volatile"
syn match  gringoKeyword	"#const"
syn match  gringoKeyword	"#include"
syn match  gringoKeyword	"#incremental"
syn match  gringoKeyword	"#supremum"
syn match  gringoKeyword	"#infimum"
syn match  gringoKeyword	"#undef"

syn match  gringoFunction	"#compute"
syn match  gringoFunction	"#min"
syn match  gringoFunction	"#max"
syn match  gringoFunction	"#minimise"
syn match  gringoFunction	"#maximise"
syn match  gringoFunction	"#minimize"
syn match  gringoFunction	"#maximize"
syn match  gringoFunction	"#external"
syn match  gringoFunction	"#count"
syn match  gringoFunction	"#sum"
syn match  gringoFunction	"#times"
syn match  gringoFunction	"#abs"
syn match  gringoFunction	"#avg"
syn match  gringoFunction	"#mod"
syn match  gringoFunction	"#odd"
syn match  gringoFunction	"#even"
syn match  gringoFunction	"#pow"

syn region  gringoString	start=+"+ skip=+\\"+ end=+"+
syn match   gringoAtom          "_*[a-z_]['a-zA-Z0-9_]*"
syn match   gringoVar           "_*[A-Z]['a-zA-Z0-9_]*"

syn match   gringoOperator "=\|<\|<=\|>\|>=\|=\|==\|-\|+\|*\|/\||\|!=\|?\|\^\|\~"

syn match   gringoNumber	    "\<[0123456789]*\>"
syn match   gringoSpecialCharacter  ";\|:\|(\|)\|,\|\.\|{\|}\|\[\|\]\|@\||"
syn match   gringoRule  ":-"

syn sync maxlines=500

command! -nargs=+ HiLink hi def link <args>

" The default highlighting.
HiLink gringoComment		Comment
HiLink gringoBlockComment	Comment

HiLink gringoKeyword            Type
HiLink gringoLuaFunc            PreProc
HiLink gringoFunction           PreProc
HiLink gringoSpecialCharacter   Special
HiLink gringoNumber		Number
HiLink gringoAtom		Statement
HiLink gringoString		String
HiLink gringoOperator           Special
HiLink gringoRule               Special
HiLink gringoVar                Identifier
HiLink gringoError              Error

delcommand HiLink

let b:current_syntax = "gringo"

