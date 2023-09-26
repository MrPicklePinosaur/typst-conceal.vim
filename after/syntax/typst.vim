if !has('conceal')
    finish
endif

" mathmode shorthands
syntax match typMathShorthand '\[|' conceal cchar=⟦
syntax match typMathShorthand '\.\.\.' conceal cchar=…
syntax match typMathShorthand '!=' conceal cchar=≠
