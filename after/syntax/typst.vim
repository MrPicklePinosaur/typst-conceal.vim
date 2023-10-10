if !has('conceal')
    finish
endif

" syntax thanks to https://github.com/kaarmu/typst.vim

" Common {{{1
syntax cluster typstCommon
    \ contains=@typstComment

" Common > Comment {{{2
syntax cluster typstComment
    \ contains=typstCommentBlock,typstCommentLine
syntax match typstCommentBlock
    \ #/\*\%(\_.\{-}\)\*/#
    \ contains=typstCommentTodo,@Spell
syntax match typstCommentLine
    \ #//.*#
    \ contains=typstCommentTodo,@Spell
syntax keyword typstCommentTodo
    \ contained
    \ TODO FIXME XXX TBD


" Code {{{1
syntax cluster typstCode
    \ contains=@typstCommon
            \ ,@typstCodeKeywords
            \ ,@typstCodeConstants
            \ ,@typstCodeIdentifiers
            \ ,@typstCodeFunctions
            \ ,@typstCodeParens

" Code > Keywords {{{2
syntax cluster typstCodeKeywords
    \ contains=typstCodeConditional
            \ ,typstCodeRepeat
            \ ,typstCodeKeyword
            \ ,typstCodeStatement
syntax keyword typstCodeConditional
    \ contained
    \ if else
syntax keyword typstCodeRepeat
    \ contained
    \ while for
syntax keyword typstCodeKeyword
    \ contained
    \ not in and or return
syntax region typstCodeStatement
    \ contained
    \ matchgroup=typstCodeStatementWord start=/\v(let|set|show|import|include)>-@!/ end=/\v%(;|$)/
    \ contains=@typstCode

" Code > Identifiers- {{{2
syntax cluster typstCodeIdentifiers
    \ contains=typstCodeIdentifier
            \ ,typstCodeFieldAccess
syntax match typstCodeIdentifier
    \ contained
    \ /\v\K\k*%(-+\k+)*>-@!(<%(let|set|show|import|include))@<![\.\[\(]@!/
syntax match typstCodeFieldAccess
    \ contained
    \ /\v\K\k*%(-+\k+)*>-@!(<%(let|set|show|import|include))@<!\.[\[\(]@!/
    \ nextgroup=typstCodeFieldAccess,typstCodeFunction

" Code > Functions {{{2
syntax cluster typstCodeFunctions
    \ contains=typstCodeFunction
syntax match typstCodeFunction
    \ contained
    \ /\v\K\k*%(-+\k+)*[\(\[]@=/
    \ nextgroup=typstCodeFunctionArgument
syntax match typstCodeFunctionArgument
    \ contained
    \ /\v%(%(\(.{-}\)|\[.{-}\]|\{.{-}\}))*/ transparent
    \ contains=@typstCode

" Code > Constants {{{2
syntax cluster typstCodeConstants
    \ contains=typstCodeConstant
            \ ,typstCodeNumberInteger
            \ ,typstCodeNumberFloat
            \ ,typstCodeNumberLength
            \ ,typstCodeNumberAngle
            \ ,typstCodeNumberRatio
            \ ,typstCodeNumberFraction
            \ ,typstCodeString
syntax match typstCodeConstant
    \ contained
    \ /\v<%(none|auto|true|false)-@!>/ 
syntax match typstCodeNumberInteger
    \ contained
    \ /\v<\d+>/

syntax match typstCodeNumberFloat
    \ contained
    \ /\v<\d+\.\d*>/
syntax match typstCodeNumberLength
    \ contained
    \ /\v<\d+(\.\d*)?(pt|mm|cm|in|em)>/
syntax match typstCodeNumberAngle
    \ contained
    \ /\v<\d+(\.\d*)?(deg|rad)>/
syntax match typstCodeNumberRatio
    \ contained
    \ /\v<\d+(\.\d*)?\%/
syntax match typstCodeNumberFraction
    \ contained
    \ /\v<\d+(\.\d*)?fr>/
syntax region typstCodeString
    \ contained
    \ start=/"/ skip=/\v\\\\|\\"/ end=/"/
    \ contains=@Spell

" Code > Parens {{{2
syntax cluster typstCodeParens
    \ contains=typstCodeParen
            \ ,typstCodeBrace
            \ ,typstCodeBracket
            \ ,typstCodeDollar
            \ ,typstMarkupRawInline
            \ ,typstMarkupRawBlock
syntax region typstCodeParen
    \ contained
    \ matchgroup=Noise start=/\v\(/ end=/\v\)/
    \ contains=@typstCode
syntax region typstCodeBrace
    \ contained
    \ matchgroup=Noise start=/\v\{/ end=/\v\}/
    \ contains=@typstCode
syntax region typstCodeBracket
    \ contained
    \ matchgroup=Noise start=/\v\[/ end=/\v\]/
    \ contains=@typstMarkup
syntax region typstCodeDollar
    \ contained
    \ matchgroup=Number start=/\v\$/ end=/\v\$/
    \ contains=@typstMath


" Hashtag {{{1
syntax cluster typstHashtag
    \ contains=@typstHashtagKeywords
            \ ,@typstHashtagConstants
            \ ,@typstHashtagIdentifiers
            \ ,@typstHashtagFunctions
            \ ,@typstHashtagParens

" Hashtag > Keywords {{{2
syntax cluster typstHashtagKeywords
    \ contains=typstHashtagConditional
            \ ,typstHashtagRepeat
            \ ,typstHashtagKeywords
            \ ,typstHashtagStatement

syntax match typstHashtagControlFlowError
    \ /\v#%(if|while|for)>-@!.{-}$\_.{-}%(\{|\[)/
syntax match typstHashtagControlFlow
    \ /\v#%(if|while|for)>-@!.{-}\ze%(\{|\[)/
    \ contains=typstHashtagConditional,typstHashtagRepeat 
    \ nextgroup=@typstCode
syntax region typstHashtagConditional
    \ contained
    \ start=/\v#if>-@!/ end=/\v\ze(\{|\[)/
    \ contains=@typstCode
syntax region typstHashtagRepeat
    \ contained
    \ start=/\v#(while|for)>-@!/ end=/\v\ze(\{|\[)/
    \ contains=@typstCode
syntax match typstHashtagKeyword
    \ /\v#(return)>-@!/
    \ skipwhite nextgroup=@typstCode
syntax region typstHashtagStatement
    \ matchgroup=typstHashtagStatementWord start=/\v#(let|set|show|import|include)>-@!/ end=/\v%(;|$)/
    \ contains=@typstCode

" Hashtag > Constants {{{2
syntax cluster typstHashtagConstants
    \ contains=typstHashtagConstant
syntax match typstHashtagConstant
    \ /\v#(none|auto|true|false)>-@!/

" Hashtag > Identifiers {{{2
syntax cluster typstHashtagIdentifiers
    \ contains=typstHashtagIdentifier
            \ ,typstHashtagFieldAccess
syntax match typstHashtagIdentifier
    \ /\v#\K\k*%(-+\k+)*>-@!(<%(let|set|show|import|include|if|while|for|return))@<![\.\[\(]@!/
syntax match typstHashtagFieldAccess
    \ /\v#\K\k*%(-+\k+)*>-@!(<%(let|set|show|import|include|if|while|for|return))@<!\.[\[\(]@!/
    \ nextgroup=typstCodeFieldAccess,typstCodeFunction

" Hashtag > Functions {{{2
syntax cluster typstHashtagFunctions
    \ contains=typstHashtagFunction
syntax match typstHashtagFunction
    \ /\v#\K\k*%(-+\k+)*[\(\[]@=/
    \ nextgroup=typstCodeFunctionArgument

" Hashtag > Parens {{{2
syntax cluster typstHashtagParens
    \ contains=typstHashtagParen
            \ ,typstHashtagBrace
            \ ,typstHashtagBracket
            \ ,typstHashtagDollar
syntax region typstHashtagParen
    \ matchgroup=Noise start=/\v\#\(/ end=/\v\)/
    \ contains=@typstCode
syntax region typstHashtagBrace
    \ matchgroup=Noise start=/\v\#\{/ end=/\v\}/
    \ contains=@typstCode
syntax region typstHashtagBracket
    \ matchgroup=Noise start=/\v\#\[/ end=/\v\]/
    \ contains=@typstMarkup
syntax region typstHashtagDollar
    \ matchgroup=Noise start=/\v\#\$/ end=/\v\$/
    \ contains=@typstMath


" Markup {{{1
syntax cluster typstMarkup
    \ contains=@typstCommon
            \ ,@Spell
            \ ,@typstHashtag
            \ ,@typstMarkupText
            \ ,@typstMarkupParens

" Markup > Text {{{2
syntax cluster typstMarkupText
    \ contains=typstMarkupRawInline
            \ ,typstMarkupRawBlock
            \ ,typstMarkupLabel
            \ ,typstMarkupReference
            \ ,typstMarkupUrl
            \ ,typstMarkupHeading
            \ ,typstMarkupBulletList
            \ ,typstMarkupEnumList
            \ ,typstMarkupBold
            \ ,typstMarkupItalic
            \ ,typstMarkupLinebreak
            \ ,typstMarkupNonbreakingSpace
            \ ,typstMarkupShy
            \ ,typstMarkupDash
            \ ,typstMarkupEllipsis
            \ ,typstMarkupTermList

syntax match typstMarkupRawInline
    \ /`.\{-}`/

syntax region typstMarkupRawBlock 
    \ matchgroup=Macro start=/```\w*/ 
    \ matchgroup=Macro end=/```/ keepend
syntax region typstCodeBlock
    \ matchgroup=Macro start=/```typst/
    \ matchgroup=Macro end=/```/ contains=@typstCode keepend
syntax include @C syntax/c.vim
syntax region typstMarkupCCodeBlock
    \ matchgroup=Macro start=/```c\>/
    \ matchgroup=Macro end=/```/ contains=@C keepend
syntax include @CPP syntax/cpp.vim
syntax region typstMarkupCPPCodeBlock 
    \ matchgroup=Macro start=/```cpp/
    \ matchgroup=Macro end=/```/ contains=@CPP keepend
syntax include @Python syntax/python.vim
syntax region typstMarkupPythonCodeBlock 
    \ matchgroup=Macro start=/```python/
    \ matchgroup=Macro end=/```/ contains=@Python keepend

syntax match typstMarkupLabel
    \ /\v\<\K%(\k*-*)*\>/
syntax match typstMarkupReference
    \ /\v\@\K%(\k*-*)*/
syntax match typstMarkupUrl
    \ /http[s]\?:\/\/[[:alnum:]%\/_#.-]*/
syntax match typstMarkupHeading
    \ /^\s*\zs=\{1,6}\s.*$/
    \ contains=typstMarkupLabel,@Spell
syntax match typstMarkupBulletList
    \ /\v^\s*-\s+/
syntax match typstMarkupEnumList
    \ /\v^\s*(\+|\d+\.)\s+/
syntax match typstMarkupItalicError
    \ /\v(\w|\\)@<!_\S@=.*/
syntax match typstMarkupItalic
    \ /\v(\w|\\)@<!_\S@=.*(\n.+)*\S@<=\\@<!_/
    \ contains=typstMarkupItalicRegion
syntax region typstMarkupItalicRegion
    \ contained
    \ matchgroup=typstMarkupItalicDelimiter start=/_/ skip=/\\\@<=_/ end=/_/
    \ concealends contains=typstMarkupLabel,typstMarkupBold,@Spell
syntax region typstMarkupBold
    \ matchgroup=typstMarkupBoldDelimiter start=/\*\S\@=/ skip=/\\\*/ end=/\S\@<=\*\|^$/
    \ concealends contains=typstMarkupLabel,typstMarkupItalic,@Spell
syntax match typstMarkupLinebreak
    \ /\\\\/
syntax match typstMarkupNonbreakingSpace
    \ /\~/
syntax match typstMarkupShy
    \ /-?/
syntax match typstMarkupDash
    \ /-\{2,3}/
syntax match typstMarkupEllipsis
    \ /\.\.\./
syntax match typstMarkupTermList
    \ #\v^\s*\/\s+[^:]*:#

" Markup > Parens {{{2
syntax cluster typstMarkupParens
    \ contains=typstMarkupDollar
syntax region typstMarkupDollar
    \ matchgroup=Special start=/\$/ skip=/\\\$/ end=/\$/
    \ contains=@typstMath


" Math {{{1
syntax cluster typstMath
    \ contains=@typstCommon
            \ ,@typstHashtag
            \ ,typstMathFunction
            \ ,typstMathNumber
            \ ,typstMathSymbol

syntax match typstMathFunction
    \ /\<\v\zs\a\w+\ze\(/
    \ contained
syntax match typstMathNumber
    \ /\<\d\+\>/
    \ contained


" mathmode shorthands
syntax match typMathShorthand '\[|' conceal cchar=⟦
syntax match typMathShorthand '\.\.\.' conceal cchar=…
syntax match typMathShorthand '!=' conceal cchar=≠

fun! s:ConcealFn(pat, cchar)
    exe "syntax match typstMathSymbol '".a:pat."' contained conceal cchar=".a:cchar
endfun

call s:ConcealFn('paren\.l', '(')
call s:ConcealFn('paren\.r', ')')
call s:ConcealFn('paren\.t', '⏜')
call s:ConcealFn('paren\.b', '⏝')
call s:ConcealFn('brace\.l', '{')
call s:ConcealFn('brace\.r', '}')
call s:ConcealFn('brace\.t', '⏞')
call s:ConcealFn('brace\.b', '⏟')
call s:ConcealFn('bracket\.l', '{')
call s:ConcealFn('bracket\.l\.double', '⟦')
call s:ConcealFn('bracket\.r', '}')
call s:ConcealFn('bracket\.r\.double', '⟧')
call s:ConcealFn('bracket\.t', '⎴')
call s:ConcealFn('bracket\.b', '⎵')
call s:ConcealFn('turtle\.l', '〔')
call s:ConcealFn('turtle\.r', '〕')
call s:ConcealFn('turtle\.t', '⏠')
call s:ConcealFn('turtle\.b', '⏡')
call s:ConcealFn('bar\.v', '|')
call s:ConcealFn('bar\.v\.double', '‖')
call s:ConcealFn('bar\.v\.triple', '⦀')
call s:ConcealFn('bar\.v\.broken', '¦')
call s:ConcealFn('bar\.v\.circle', '⦶')
call s:ConcealFn('bar\.h', '―')
call s:ConcealFn('fence\.l', '⧘')
call s:ConcealFn('fence\.l\.double', '⧚')
call s:ConcealFn('fence\.r', '⧙')
call s:ConcealFn('fence\.r\.double', '⧛')
call s:ConcealFn('fence\.dotted', '⦙')
call s:ConcealFn('angle', '∠')
call s:ConcealFn('angle\.l', '⟨')
call s:ConcealFn('angle\.r', '⟩')
call s:ConcealFn('angle\.l\.double', '《')
call s:ConcealFn('angle\.r\.double', '》')
call s:ConcealFn('angle\.acute', '⦟')
call s:ConcealFn('angle\.arc', '∡')
call s:ConcealFn('angle\.arc\.rev', '⦛')
call s:ConcealFn('angle\.rev', '⦣')
call s:ConcealFn('angle\.right', '∟')
call s:ConcealFn('angle\.right\.rev', '⯾')
call s:ConcealFn('angle\.right\.arc', '⊾')
call s:ConcealFn('angle\.right\.dot', '⦝')
call s:ConcealFn('angle\.right\.sq', '⦜')
call s:ConcealFn('angle\.spatial', '⟀')
call s:ConcealFn('angle\.spheric', '∢')
call s:ConcealFn('angle\.spheric\.rev', '⦠')
call s:ConcealFn('angle\.spheric\.top', '⦡')
call s:ConcealFn('amp', '&')
call s:ConcealFn('amp\.inv', '⅋')
call s:ConcealFn('ast\.op', '∗')
call s:ConcealFn('ast\.basic', '*')
call s:ConcealFn('ast\.low', '⁎')
call s:ConcealFn('ast\.double', '⁑')
call s:ConcealFn('ast\.triple', '⁂')
call s:ConcealFn('ast\.small', '﹡')
call s:ConcealFn('ast\.circle', '⊛')
call s:ConcealFn('ast\.square', '⧆')
call s:ConcealFn('at', '@')
call s:ConcealFn('backslash', '\')
call s:ConcealFn('backslash\.circle', '⦸')
call s:ConcealFn('backslash\.not', '⧷')
call s:ConcealFn('co', '℅')
call s:ConcealFn('colon', ':')
call s:ConcealFn('colon\.eq', '≔')
call s:ConcealFn('colon\.double\.eq', '⩴')
call s:ConcealFn('comma', ',')
call s:ConcealFn('dagger', '†')
call s:ConcealFn('dagger\.double', '‡')
call s:ConcealFn('dash\.en', '–')
call s:ConcealFn('dash\.em', '—')
call s:ConcealFn('dash\.fig', '‒')
call s:ConcealFn('dash\.wave', '〜')
call s:ConcealFn('dash\.colon', '∹')
call s:ConcealFn('dash\.circle', '⊝')
call s:ConcealFn('dash\.wave\.double', '〰')
call s:ConcealFn('dot\.op', '⋅')
call s:ConcealFn('dot\.basic', '.')
call s:ConcealFn('dot\.c', '·')
call s:ConcealFn('dot\.circle', '⊙')
call s:ConcealFn('dot\.circle\.big', '⨀')
call s:ConcealFn('dot\.square', '⊡')
call s:ConcealFn('dot\.double', '¨')
" syntax match typstMathSymbol 'dot\.triple' ⃛contained conceal cchar= ⃛
" syntax match typstMathSymbol 'dot\.quad' contained conceal cchar= ⃛
call s:ConcealFn('excl', '!')
call s:ConcealFn('excl\.double', '‼')
call s:ConcealFn('excl\.inv', '¡')
call s:ConcealFn('excl\.quest', '⁉')
call s:ConcealFn('quest', '?')
call s:ConcealFn('quest\.double', '⁇')
call s:ConcealFn('quest\.excl', '⁈')
call s:ConcealFn('quest\.inv', '¿')
call s:ConcealFn('interrobang', '‽')
call s:ConcealFn('hash', '#')
call s:ConcealFn('hyph', '‐')
call s:ConcealFn('hyph\.minus', '-')
call s:ConcealFn('hyph\.nobreak', '‑')
call s:ConcealFn('hyph\.point', '‧')
call s:ConcealFn('hyph\.soft', '­')
call s:ConcealFn('percent', '%')
call s:ConcealFn('copyright', '©')
call s:ConcealFn('copyright\.sound', '℗')
call s:ConcealFn('permille', '‰')
call s:ConcealFn('pilcrow', '¶')
call s:ConcealFn('pilcrow\.rev', '⁋')
call s:ConcealFn('section', '§')
call s:ConcealFn('semi', ';')
call s:ConcealFn('semi\.rev', '⁏')
call s:ConcealFn('slash', '/')
call s:ConcealFn('slash\.double', '⫽')
call s:ConcealFn('slash\.triple', '⫻')
call s:ConcealFn('slash\.big', '⧸')
call s:ConcealFn('dots\.h\.c', '⋯')
call s:ConcealFn('dots\.h', '…')
call s:ConcealFn('dots\.v', '⋮')
call s:ConcealFn('dots\.down', '⋱')
call s:ConcealFn('dots\.up', '⋰')
call s:ConcealFn('tilde\.op', '∼')
call s:ConcealFn('tilde\.basic', '~')
call s:ConcealFn('tilde\.eq', '≃')
call s:ConcealFn('tilde\.eq\.not', '≄')
call s:ConcealFn('tilde\.eq\.rev', '⋍')
call s:ConcealFn('tilde\.equiv', '≅')
call s:ConcealFn('tilde\.equiv\.not', '≇')
call s:ConcealFn('tilde\.nequiv', '≆')
call s:ConcealFn('tilde\.not', '≁')
call s:ConcealFn('tilde\.rev', '∽')
call s:ConcealFn('tilde\.rev\.equiv', '≌')
call s:ConcealFn('tilde\.triple', '≋')
call s:ConcealFn('acute', '´')
call s:ConcealFn('acute\.double', '˝')
call s:ConcealFn('breve', '˘')
call s:ConcealFn('caret', '‸')
call s:ConcealFn('caron', 'ˇ')
call s:ConcealFn('hat', '^')
call s:ConcealFn('diaer', '¨')
call s:ConcealFn('grave', '`')
call s:ConcealFn('macron', '¯')
call s:ConcealFn('quote\.double', '"')
call s:ConcealFn('quote\.single', "'")
call s:ConcealFn('quote\.l\.double', '“')
call s:ConcealFn('quote\.l\.single', '‘')
call s:ConcealFn('quote\.r\.double', '”')
call s:ConcealFn('quote\.r\.single', '’')
call s:ConcealFn('quote\.angle\.l\.double', '«')
call s:ConcealFn('quote\.angle\.l\.single', '‹')
call s:ConcealFn('quote\.angle\.r\.double', '»')
call s:ConcealFn('quote\.angle\.r\.single', '›')
call s:ConcealFn('quote\.high\.double', '‟')
call s:ConcealFn('quote\.high\.single', '‛')
call s:ConcealFn('quote\.low\.double', '„')
call s:ConcealFn('quote\.low\.single', '‚')
call s:ConcealFn('prime', '′')
call s:ConcealFn('prime\.rev', '‵')
call s:ConcealFn('prime\.double', '″')
call s:ConcealFn('prime\.double\.rev', '‶')
call s:ConcealFn('prime\.triple', '‴')
call s:ConcealFn('prime\.triple\.rev', '‷')
call s:ConcealFn('prime\.quad', '⁗')
call s:ConcealFn('plus', '+')
call s:ConcealFn('plus\.circle', '⊕')
call s:ConcealFn('plus\.circle\.arrow', '⟴')
call s:ConcealFn('plus\.circle\.big', '⨁')
call s:ConcealFn('plus\.dot', '∔')
call s:ConcealFn('plus\.minus', '±')
call s:ConcealFn('plus\.small', '﹢')
call s:ConcealFn('plus\.square', '⊞')
call s:ConcealFn('plus\.triangle', '⨹')
call s:ConcealFn('minus', '−')
call s:ConcealFn('minus\.circle', '⊖')
call s:ConcealFn('minus\.dot', '∸')
call s:ConcealFn('minus\.plus', '∓')
call s:ConcealFn('minus\.square', '⊟')
call s:ConcealFn('minus\.tilde', '≂')
call s:ConcealFn('minus\.triangle', '⨺')
call s:ConcealFn('div', '÷')
call s:ConcealFn('div\.circle', '⨸')
call s:ConcealFn('times', '×')
call s:ConcealFn('times\.big', '⨉')
call s:ConcealFn('times\.circle', '⊗')
call s:ConcealFn('times\.circle\.big', '⨂')
call s:ConcealFn('times\.div', '⋇')
call s:ConcealFn('times\.three\.l', '⋋')
call s:ConcealFn('times\.three\.r', '⋌')
call s:ConcealFn('times\.l', '⋉')
call s:ConcealFn('times\.r', '⋊')
call s:ConcealFn('times\.square', '⊠')
call s:ConcealFn('times\.triangle', '⨻')
call s:ConcealFn('ratio', '∶')
call s:ConcealFn('eq', '=')
call s:ConcealFn('eq\.star', '≛')
call s:ConcealFn('eq\.circle', '⊜')
call s:ConcealFn('eq\.colon', '≕')
call s:ConcealFn('eq\.def', '≝')
call s:ConcealFn('eq\.delta', '≜')
call s:ConcealFn('eq\.equi', '≚')
call s:ConcealFn('eq\.est', '≙')
call s:ConcealFn('eq\.gt', '⋝')
call s:ConcealFn('eq\.lt', '⋜')
call s:ConcealFn('eq\.m', '≞')
call s:ConcealFn('eq\.not', '≠')
call s:ConcealFn('eq\.prec', '⋞')
call s:ConcealFn('eq\.quest', '≟')
call s:ConcealFn('eq\.small', '﹦')
call s:ConcealFn('eq\.succ', '⋟')
call s:ConcealFn('eq\.triple', '≡')
call s:ConcealFn('eq\.quad', '≣')
call s:ConcealFn('gt', '>')
call s:ConcealFn('gt\.circle', '⧁')
call s:ConcealFn('gt\.curly', '≻')
call s:ConcealFn('gt\.curly\.approx', '⪸')
call s:ConcealFn('gt\.curly\.double', '⪼')
call s:ConcealFn('gt\.curly\.eq', '≽')
call s:ConcealFn('gt\.curly\.eq\.not', '⋡')
call s:ConcealFn('gt\.curly\.equiv', '⪴')
call s:ConcealFn('gt\.curly\.napprox', '⪺')
call s:ConcealFn('gt\.curly\.nequiv', '⪶')
call s:ConcealFn('gt\.curly\.not', '⊁')
call s:ConcealFn('gt\.curly\.ntilde', '⋩')
call s:ConcealFn('gt\.curly\.tilde', '≿')
call s:ConcealFn('gt\.dot', '⋗')
call s:ConcealFn('gt\.double', '≫')
call s:ConcealFn('gt\.eq', '≥')
call s:ConcealFn('gt\.eq\.slant', '⩾')
call s:ConcealFn('gt\.eq\.lt', '⋛')
call s:ConcealFn('gt\.eq\.not', '≱')
call s:ConcealFn('gt\.equiv', '≧')
call s:ConcealFn('gt\.lt', '≷')
call s:ConcealFn('gt\.lt\.not', '≹')
call s:ConcealFn('gt\.nequiv', '≩')
call s:ConcealFn('gt\.not', '≯')
call s:ConcealFn('gt\.ntilde', '⋧')
call s:ConcealFn('gt\.small', '﹥')
call s:ConcealFn('gt\.tilde', '≳')
call s:ConcealFn('gt\.tilde\.not', '≵')
call s:ConcealFn('gt\.tri', '⊳')
call s:ConcealFn('gt\.tri\.eq', '⊵')
call s:ConcealFn('gt\.tri\.eq\.not', '⋭')
call s:ConcealFn('gt\.tri\.not', '⋫')
call s:ConcealFn('gt\.triple', '⋙')
call s:ConcealFn('gt\.triple\.nested', '⫸')
call s:ConcealFn('lt', '<')
call s:ConcealFn('lt\.circle', '⧀')
call s:ConcealFn('lt\.curly', '≺')
call s:ConcealFn('lt\.curly\.approx', '⪷')
call s:ConcealFn('lt\.curly\.double', '⪻')
call s:ConcealFn('lt\.curly\.eq', '≼')
call s:ConcealFn('lt\.curly\.eq\.not', '⋠')
call s:ConcealFn('lt\.curly\.equiv', '⪳')
call s:ConcealFn('lt\.curly\.napprox', '⪹')
call s:ConcealFn('lt\.curly\.nequiv', '⪵')
call s:ConcealFn('lt\.curly\.not', '⊀')
call s:ConcealFn('lt\.curly\.ntilde', '⋨')
call s:ConcealFn('lt\.curly\.tilde', '≾')
call s:ConcealFn('lt\.dot', '⋖')
call s:ConcealFn('lt\.double', '≪')
call s:ConcealFn('lt\.eq', '≤')
call s:ConcealFn('lt\.eq\.slant', '⩽')
call s:ConcealFn('lt\.eq\.gt', '⋚')
call s:ConcealFn('lt\.eq\.not', '≰')
call s:ConcealFn('lt\.equiv', '≦')
call s:ConcealFn('lt\.gt', '≶')
call s:ConcealFn('lt\.gt\.not', '≸')
call s:ConcealFn('lt\.nequiv', '≨')
call s:ConcealFn('lt\.not', '≮')
call s:ConcealFn('lt\.ntilde', '⋦')
call s:ConcealFn('lt\.small', '﹤')
call s:ConcealFn('lt\.tilde', '≲')
call s:ConcealFn('lt\.tilde\.not', '≴')
call s:ConcealFn('lt\.tri', '⊲')
call s:ConcealFn('lt\.tri\.eq', '⊴')
call s:ConcealFn('lt\.tri\.eq\.not', '⋬')
call s:ConcealFn('lt\.tri\.not', '⋪')
call s:ConcealFn('lt\.triple', '⋘')
call s:ConcealFn('lt\.triple\.nested', '⫷')
call s:ConcealFn('approx', '≈')
call s:ConcealFn('approx\.eq', '≊')
call s:ConcealFn('approx\.not', '≉')
call s:ConcealFn('prec', '≺')
call s:ConcealFn('prec\.approx', '⪷')
call s:ConcealFn('prec\.double', '⪻')
call s:ConcealFn('prec\.eq', '≼')
call s:ConcealFn('prec\.eq\.not', '⋠')
call s:ConcealFn('prec\.equiv', '⪳')
call s:ConcealFn('prec\.napprox', '⪹')
call s:ConcealFn('prec\.nequiv', '⪵')
call s:ConcealFn('prec\.not', '⊀')
call s:ConcealFn('prec\.ntilde', '⋨')
call s:ConcealFn('prec\.tilde', '≾')
call s:ConcealFn('succ', '≻')
call s:ConcealFn('succ\.approx', '⪸')
call s:ConcealFn('succ\.double', '⪼')
call s:ConcealFn('succ\.eq', '≽')
call s:ConcealFn('succ\.eq\.not', '⋡')
call s:ConcealFn('succ\.equiv', '⪴')
call s:ConcealFn('succ\.napprox', '⪺')
call s:ConcealFn('succ\.nequiv', '⪶')
call s:ConcealFn('succ\.not', '⊁')
call s:ConcealFn('succ\.ntilde', '⋩')
call s:ConcealFn('succ\.tilde', '≿')
call s:ConcealFn('equiv', '≡')
call s:ConcealFn('equiv\.not', '≢')
call s:ConcealFn('prop', '∝')
call s:ConcealFn('emptyset', '∅')
call s:ConcealFn('emptyset\.rev', '⦰')
call s:ConcealFn('nothing', '∅')
call s:ConcealFn('nothing\.rev', '⦰')
call s:ConcealFn('without', '∖')
call s:ConcealFn('complement', '∁')
call s:ConcealFn('in', '∈')
call s:ConcealFn('in\.not', '∉')
call s:ConcealFn('in\.rev', '∋')
call s:ConcealFn('in\.rev\.not', '∌')
call s:ConcealFn('in\.rev\.small', '∍')
call s:ConcealFn('in\.small', '∊')
call s:ConcealFn('subset', '⊂')
call s:ConcealFn('subset\.dot', '⪽')
call s:ConcealFn('subset\.double', '⋐')
call s:ConcealFn('subset\.eq', '⊆')
call s:ConcealFn('subset\.eq\.not', '⊈')
call s:ConcealFn('subset\.eq\.sq', '⊑')
call s:ConcealFn('subset\.eq\.sq\.not', '⋢')
call s:ConcealFn('subset\.neq', '⊊')
call s:ConcealFn('subset\.not', '⊄')
call s:ConcealFn('subset\.sq', '⊏')
call s:ConcealFn('subset\.sq\.neq', '⋤')
call s:ConcealFn('supset', '⊃')
call s:ConcealFn('supset\.dot', '⪾')
call s:ConcealFn('supset\.double', '⋑')
call s:ConcealFn('supset\.eq', '⊇')
call s:ConcealFn('supset\.eq\.not', '⊉')
call s:ConcealFn('supset\.eq\.sq', '⊒')
call s:ConcealFn('supset\.eq\.sq\.not', '⋣')
call s:ConcealFn('supset\.neq', '⊋')
call s:ConcealFn('supset\.not', '⊅')
call s:ConcealFn('supset\.sq', '⊐')
call s:ConcealFn('supset\.sq\.neq', '⋥')
call s:ConcealFn('union', '∪')
call s:ConcealFn('union\.arrow', '⊌')
call s:ConcealFn('union\.big', '⋃')
call s:ConcealFn('union\.dot', '⊍')
call s:ConcealFn('union\.dot\.big', '⨃')
call s:ConcealFn('union\.double', '⋓')
call s:ConcealFn('union\.minus', '⩁')
call s:ConcealFn('union\.or', '⩅')
call s:ConcealFn('union\.plus', '⊎')
call s:ConcealFn('union\.plus\.big', '⨄')
call s:ConcealFn('union\.sq', '⊔')
call s:ConcealFn('union\.sq\.big', '⨆')
call s:ConcealFn('union\.sq\.double', '⩏')
call s:ConcealFn('sect', '∩')
call s:ConcealFn('sect\.and', '⩄')
call s:ConcealFn('sect\.big', '⋂')
call s:ConcealFn('sect\.dot', '⩀')
call s:ConcealFn('sect\.double', '⋒')
call s:ConcealFn('sect\.sq', '⊓')
call s:ConcealFn('sect\.sq\.big', '⨅')
call s:ConcealFn('sect\.sq\.double', '⩎')
call s:ConcealFn('infinity', '∞')
call s:ConcealFn('oo', '∞')
call s:ConcealFn('diff', '∂')
call s:ConcealFn('nabla', '∇')
call s:ConcealFn('sum', '∑')
call s:ConcealFn('sum\.integral', '⨋')
call s:ConcealFn('product', '∏')
call s:ConcealFn('product\.co', '∐')
call s:ConcealFn('integral', '∫')
call s:ConcealFn('integral\.arrow\.hook', '⨗')
call s:ConcealFn('integral\.ccw', '⨑')
call s:ConcealFn('integral\.cont', '∮')
call s:ConcealFn('integral\.cont\.ccw', '∳')
call s:ConcealFn('integral\.cont\.cw', '∲')
call s:ConcealFn('integral\.cw', '∱')
call s:ConcealFn('integral\.double', '∬')
call s:ConcealFn('integral\.quad', '⨌')
call s:ConcealFn('integral\.sect', '⨙')
call s:ConcealFn('integral\.square', '⨖')
call s:ConcealFn('integral\.surf', '∯')
call s:ConcealFn('integral\.times', '⨘')
call s:ConcealFn('integral\.triple', '∭')
call s:ConcealFn('integral\.union', '⨚')
call s:ConcealFn('integral\.vol', '∰')
call s:ConcealFn('laplace', '∆')
call s:ConcealFn('forall', '∀')
call s:ConcealFn('exists', '∃')
call s:ConcealFn('exists\.not', '∄')
call s:ConcealFn('top', '⊤')
call s:ConcealFn('bot', '⊥')
call s:ConcealFn('not', '¬')
call s:ConcealFn('and', '∧')
call s:ConcealFn('and\.big', '⋀')
call s:ConcealFn('and\.curly', '⋏')
call s:ConcealFn('and\.dot', '⟑')
call s:ConcealFn('and\.double', '⩓')
call s:ConcealFn('or', '∨')
call s:ConcealFn('or\.big', '⋁')
call s:ConcealFn('or\.curly', '⋎')
call s:ConcealFn('or\.dot', '⟇')
call s:ConcealFn('or\.double', '⩔')
call s:ConcealFn('xor', '⊕')
call s:ConcealFn('xor\.big', '⨁')
call s:ConcealFn('models', '⊧')
call s:ConcealFn('therefore', '∴')
call s:ConcealFn('because', '∵')
call s:ConcealFn('qed', '∎')
call s:ConcealFn('compose', '∘')
call s:ConcealFn('convolve', '∗')
call s:ConcealFn('multimap', '⊸')
call s:ConcealFn('divides', '∣')
call s:ConcealFn('divides\.not', '∤')
call s:ConcealFn('wreath', '≀')
call s:ConcealFn('parallel', '∥')
call s:ConcealFn('parallel\.circle', '⦷')
call s:ConcealFn('parallel\.not', '∦')
call s:ConcealFn('perp', '⟂')
call s:ConcealFn('perp\.circle', '⦹')
call s:ConcealFn('diameter', '⌀')
call s:ConcealFn('join', '⨝')
call s:ConcealFn('join\.r', '⟖')
call s:ConcealFn('join\.l', '⟕')
call s:ConcealFn('join\.l\.r', '⟗')
call s:ConcealFn('degree', '°')
call s:ConcealFn('degree\.c', '℃')
call s:ConcealFn('degree\.f', '℉')
call s:ConcealFn('smash', '⨳')
call s:ConcealFn('bitcoin', '₿')
call s:ConcealFn('dollar', '$')
call s:ConcealFn('euro', '€')
call s:ConcealFn('franc', '₣')
call s:ConcealFn('lira', '₺')
call s:ConcealFn('peso', '₱')
call s:ConcealFn('pound', '£')
call s:ConcealFn('ruble', '₽')
call s:ConcealFn('rupee', '₹')
call s:ConcealFn('won', '₩')
call s:ConcealFn('yen', '¥')
call s:ConcealFn('ballot', '☐')
call s:ConcealFn('ballot\.x', '☒')
call s:ConcealFn('checkmark', '✓')
call s:ConcealFn('checkmark\.light', '🗸')
call s:ConcealFn('floral', '❦')
call s:ConcealFn('floral\.l', '☙')
call s:ConcealFn('floral\.r', '❧')
call s:ConcealFn('notes\.up', '🎜')
call s:ConcealFn('notes\.down', '🎝')
call s:ConcealFn('refmark', '※')
call s:ConcealFn('servicemark', '℠')
call s:ConcealFn('maltese', '✠')
call s:ConcealFn('suit\.club', '♣')
call s:ConcealFn('suit\.diamond', '♦')
call s:ConcealFn('suit\.heart', '♥')
call s:ConcealFn('suit\.spade', '♠')
call s:ConcealFn('bullet', '•')
call s:ConcealFn('circle\.stroked', '○')
call s:ConcealFn('circle\.stroked\.tiny', '∘')
call s:ConcealFn('circle\.stroked\.small', '⚬')
call s:ConcealFn('circle\.stroked\.big', '◯')
call s:ConcealFn('circle\.filled', '●')
call s:ConcealFn('circle\.filled\.tiny', '⦁')
call s:ConcealFn('circle\.filled\.small', '∙')
call s:ConcealFn('circle\.filled\.big', '⬤')
call s:ConcealFn('circle\.dotted', '◌')
call s:ConcealFn('circle\.nested', '⊚')
call s:ConcealFn('ellipse\.stroked\.h', '⬭')
call s:ConcealFn('ellipse\.stroked\.v', '⬯')
call s:ConcealFn('ellipse\.filled\.h', '⬬')
call s:ConcealFn('ellipse\.filled\.v', '⬮')
call s:ConcealFn('triangle\.stroked\.r', '▷')
call s:ConcealFn('triangle\.stroked\.l', '◁')
call s:ConcealFn('triangle\.stroked\.t', '△')
call s:ConcealFn('triangle\.stroked\.b', '▽')
call s:ConcealFn('triangle\.stroked\.bl', '◺')
call s:ConcealFn('triangle\.stroked\.br', '◿')
call s:ConcealFn('triangle\.stroked\.tl', '◸')
call s:ConcealFn('triangle\.stroked\.tr', '◹')
call s:ConcealFn('triangle\.stroked\.small\.r', '▹')
call s:ConcealFn('triangle\.stroked\.small\.b', '▿')
call s:ConcealFn('triangle\.stroked\.small\.l', '◃')
call s:ConcealFn('triangle\.stroked\.small\.t', '▵')
call s:ConcealFn('triangle\.stroked\.rounded', '🛆')
call s:ConcealFn('triangle\.stroked\.nested', '⟁')
call s:ConcealFn('triangle\.stroked\.dot', '◬')
call s:ConcealFn('triangle\.filled\.r', '▶')
call s:ConcealFn('triangle\.filled\.l', '◀')
call s:ConcealFn('triangle\.filled\.t', '▲')
call s:ConcealFn('triangle\.filled\.b', '▼')
call s:ConcealFn('triangle\.filled\.bl', '◣')
call s:ConcealFn('triangle\.filled\.br', '◢')
call s:ConcealFn('triangle\.filled\.tl', '◤')
call s:ConcealFn('triangle\.filled\.tr', '◥')
call s:ConcealFn('triangle\.filled\.small\.r', '▸')
call s:ConcealFn('triangle\.filled\.small\.b', '▾')
call s:ConcealFn('triangle\.filled\.small\.l', '◂')
call s:ConcealFn('triangle\.filled\.small\.t', '▴')
call s:ConcealFn('square\.stroked', '□')
call s:ConcealFn('square\.stroked\.tiny', '▫')
call s:ConcealFn('square\.stroked\.small', '◽')
call s:ConcealFn('square\.stroked\.medium', '◻')
call s:ConcealFn('square\.stroked\.big', '⬜')
call s:ConcealFn('square\.stroked\.dotted', '⬚')
call s:ConcealFn('square\.stroked\.rounded', '▢')
call s:ConcealFn('square\.filled', '■')
call s:ConcealFn('square\.filled\.tiny', '▪')
call s:ConcealFn('square\.filled\.small', '◾')
call s:ConcealFn('square\.filled\.medium', '◼')
call s:ConcealFn('square\.filled\.big', '⬛')
call s:ConcealFn('rect\.stroked\.h', '▭')
call s:ConcealFn('rect\.stroked\.v', '▯')
call s:ConcealFn('rect\.filled\.h', '▬')
call s:ConcealFn('rect\.filled\.v', '▮')
call s:ConcealFn('penta\.stroked', '⬠')
call s:ConcealFn('penta\.filled', '⬟')
call s:ConcealFn('hexa\.stroked', '⬡')
call s:ConcealFn('hexa\.filled', '⬢')
call s:ConcealFn('diamond\.stroked', '◇')
call s:ConcealFn('diamond\.stroked\.small', '⋄')
call s:ConcealFn('diamond\.stroked\.medium', '⬦')
call s:ConcealFn('diamond\.stroked\.dot', '⟐')
call s:ConcealFn('diamond\.filled', '◆')
call s:ConcealFn('diamond\.filled\.medium', '⬥')
call s:ConcealFn('diamond\.filled\.small', '⬩')
call s:ConcealFn('lozenge\.stroked', '◊')
call s:ConcealFn('lozenge\.stroked\.small', '⬫')
call s:ConcealFn('lozenge\.stroked\.medium', '⬨')
call s:ConcealFn('lozenge\.filled', '⧫')
call s:ConcealFn('lozenge\.filled\.small', '⬪')
call s:ConcealFn('lozenge\.filled\.medium', '⬧')
call s:ConcealFn('star\.op', '⋆')
call s:ConcealFn('star\.stroked', '★')
call s:ConcealFn('star\.filled', '★')
call s:ConcealFn('arrow\.r', '→')
call s:ConcealFn('arrow\.r\.long\.bar', '⟼')
call s:ConcealFn('arrow\.r\.bar', '↦')
call s:ConcealFn('arrow\.r\.curve', '⤷')
call s:ConcealFn('arrow\.r\.dashed', '⇢')
call s:ConcealFn('arrow\.r\.dotted', '⤑')
call s:ConcealFn('arrow\.r\.double', '⇒')
call s:ConcealFn('arrow\.r\.double\.bar', '⤇')
call s:ConcealFn('arrow\.r\.double\.long', '⟹')
call s:ConcealFn('arrow\.r\.double\.long\.bar', '⟾')
call s:ConcealFn('arrow\.r\.double\.not', '⇏')
call s:ConcealFn('arrow\.r\.filled', '➡')
call s:ConcealFn('arrow\.r\.hook', '↪')
call s:ConcealFn('arrow\.r\.long', '⟶')
call s:ConcealFn('arrow\.r\.long\.squiggly', '⟿')
call s:ConcealFn('arrow\.r\.loop', '↬')
call s:ConcealFn('arrow\.r\.not', '↛')
call s:ConcealFn('arrow\.r\.quad', '⭆')
call s:ConcealFn('arrow\.r\.squiggly', '⇝')
call s:ConcealFn('arrow\.r\.stop', '⇥')
call s:ConcealFn('arrow\.r\.stroked', '⇨')
call s:ConcealFn('arrow\.r\.tail', '↣')
call s:ConcealFn('arrow\.r\.triple', '⇛')
call s:ConcealFn('arrow\.r\.twohead\.bar', '⤅')
call s:ConcealFn('arrow\.r\.twohead', '↠')
call s:ConcealFn('arrow\.r\.wave', '↝')
call s:ConcealFn('arrow\.l', '←')
call s:ConcealFn('arrow\.l\.bar', '↤')
call s:ConcealFn('arrow\.l\.curve', '⤶')
call s:ConcealFn('arrow\.l\.dashed', '⇠')
call s:ConcealFn('arrow\.l\.dotted', '⬸')
call s:ConcealFn('arrow\.l\.double', '⇐')
call s:ConcealFn('arrow\.l\.double\.bar', '⤆')
call s:ConcealFn('arrow\.l\.double\.long', '⟸')
call s:ConcealFn('arrow\.l\.double\.long\.bar', '⟽')
call s:ConcealFn('arrow\.l\.double\.not', '⇍')
call s:ConcealFn('arrow\.l\.filled', '⬅')
call s:ConcealFn('arrow\.l\.hook', '↩')
call s:ConcealFn('arrow\.l\.long', '⟵')
call s:ConcealFn('arrow\.l\.long\.bar', '⟻')
call s:ConcealFn('arrow\.l\.long\.squiggly', '⬳')
call s:ConcealFn('arrow\.l\.loop', '↫')
call s:ConcealFn('arrow\.l\.not', '↚')
call s:ConcealFn('arrow\.l\.quad', '⭅')
call s:ConcealFn('arrow\.l\.squiggly', '⇜')
call s:ConcealFn('arrow\.l\.stop', '⇤')
call s:ConcealFn('arrow\.l\.stroked', '⇦')
call s:ConcealFn('arrow\.l\.tail', '↢')
call s:ConcealFn('arrow\.l\.triple', '⇚')
call s:ConcealFn('arrow\.l\.twohead\.bar', '⬶')
call s:ConcealFn('arrow\.l\.twohead', '↞')
call s:ConcealFn('arrow\.l\.wave', '↜')
call s:ConcealFn('arrow\.t', '↑')
call s:ConcealFn('arrow\.t\.bar', '↥')
call s:ConcealFn('arrow\.t\.curve', '⤴')
call s:ConcealFn('arrow\.t\.dashed', '⇡')
call s:ConcealFn('arrow\.t\.double', '⇑')
call s:ConcealFn('arrow\.t\.filled', '⬆')
call s:ConcealFn('arrow\.t\.quad', '⟰')
call s:ConcealFn('arrow\.t\.stop', '⤒')
call s:ConcealFn('arrow\.t\.stroked', '⇧')
call s:ConcealFn('arrow\.t\.triple', '⤊')
call s:ConcealFn('arrow\.t\.twohead', '↟')
call s:ConcealFn('arrow\.b', '↓')
call s:ConcealFn('arrow\.b\.bar', '↧')
call s:ConcealFn('arrow\.b\.curve', '⤵')
call s:ConcealFn('arrow\.b\.dashed', '⇣')
call s:ConcealFn('arrow\.b\.double', '⇓')
call s:ConcealFn('arrow\.b\.filled', '⬇')
call s:ConcealFn('arrow\.b\.quad', '⟱')
call s:ConcealFn('arrow\.b\.stop', '⤓')
call s:ConcealFn('arrow\.b\.stroked', '⇩')
call s:ConcealFn('arrow\.b\.triple', '⤋')
call s:ConcealFn('arrow\.b\.twohead', '↡')
call s:ConcealFn('arrow\.l\.r', '↔')
call s:ConcealFn('arrow\.l\.r\.double', '⇔')
call s:ConcealFn('arrow\.l\.r\.double\.long', '⟺')
call s:ConcealFn('arrow\.l\.r\.double\.not', '⇎')
call s:ConcealFn('arrow\.l\.r\.filled', '⬌')
call s:ConcealFn('arrow\.l\.r\.long', '⟷')
call s:ConcealFn('arrow\.l\.r\.not', '↮')
call s:ConcealFn('arrow\.l\.r\.stroked', '⬄')
call s:ConcealFn('arrow\.l\.r\.wave', '↭')
call s:ConcealFn('arrow\.t\.b', '↕')
call s:ConcealFn('arrow\.t\.b\.double', '⇕')
call s:ConcealFn('arrow\.t\.b\.filled', '⬍')
call s:ConcealFn('arrow\.t\.b\.stroked', '⇳')
call s:ConcealFn('arrow\.tr', '↗')
call s:ConcealFn('arrow\.tr\.double', '⇗')
call s:ConcealFn('arrow\.tr\.filled', '⬈')
call s:ConcealFn('arrow\.tr\.hook', '⤤')
call s:ConcealFn('arrow\.tr\.stroked', '⬀')
call s:ConcealFn('arrow\.br', '↘')
call s:ConcealFn('arrow\.br\.double', '⇘')
call s:ConcealFn('arrow\.br\.filled', '⬊')
call s:ConcealFn('arrow\.br\.hook', '⤥')
call s:ConcealFn('arrow\.br\.stroked', '⬂')
call s:ConcealFn('arrow\.tl', '↖')
call s:ConcealFn('arrow\.tl\.double', '⇖')
call s:ConcealFn('arrow\.tl\.filled', '⬉')
call s:ConcealFn('arrow\.tl\.hook', '⤣')
call s:ConcealFn('arrow\.tl\.stroked', '⬁')
call s:ConcealFn('arrow\.bl', '↙')
call s:ConcealFn('arrow\.bl\.double', '⇙')
call s:ConcealFn('arrow\.bl\.filled', '⬋')
call s:ConcealFn('arrow\.bl\.hook', '⤦')
call s:ConcealFn('arrow\.bl\.stroked', '⬃')
call s:ConcealFn('arrow\.tl\.br', '⤡')
call s:ConcealFn('arrow\.tr\.bl', '⤢')
call s:ConcealFn('arrow\.ccw', '↺')
call s:ConcealFn('arrow\.ccw\.half', '↶')
call s:ConcealFn('arrow\.cw', '↻')
call s:ConcealFn('arrow\.cw\.half', '↷')
call s:ConcealFn('arrow\.zigzag', '↯')
call s:ConcealFn('arrows\.rr', '⇉')
call s:ConcealFn('arrows\.ll', '⇇')
call s:ConcealFn('arrows\.tt', '⇈')
call s:ConcealFn('arrows\.bb', '⇊')
call s:ConcealFn('arrows\.lr', '⇆')
call s:ConcealFn('arrows\.lr\.stop', '↹')
call s:ConcealFn('arrows\.rl', '⇄')
call s:ConcealFn('arrows\.tb', '⇅')
call s:ConcealFn('arrows\.bt', '⇵')
call s:ConcealFn('arrows\.rrr', '⇶')
call s:ConcealFn('arrows\.lll', '⬱')
call s:ConcealFn('arrowhead\.t', '⌃')
call s:ConcealFn('arrowhead\.b', '⌄')
call s:ConcealFn('harpoon\.rt', '⇀')
call s:ConcealFn('harpoon\.rt\.bar', '⥛')
call s:ConcealFn('harpoon\.rt\.stop', '⥓')
call s:ConcealFn('harpoon\.rb', '⇁')
call s:ConcealFn('harpoon\.rb\.bar', '⥟')
call s:ConcealFn('harpoon\.rb\.stop', '⥗')
call s:ConcealFn('harpoon\.lt', '↼')
call s:ConcealFn('harpoon\.lt\.bar', '⥚')
call s:ConcealFn('harpoon\.lt\.stop', '⥒')
call s:ConcealFn('harpoon\.lb', '↽')
call s:ConcealFn('harpoon\.lb\.bar', '⥞')
call s:ConcealFn('harpoon\.lb\.stop', '⥖')
call s:ConcealFn('harpoon\.tl', '↿')
call s:ConcealFn('harpoon\.tl\.bar', '⥠')
call s:ConcealFn('harpoon\.tl\.stop', '⥘')
call s:ConcealFn('harpoon\.tr', '↾')
call s:ConcealFn('harpoon\.tr\.bar', '⥜')
call s:ConcealFn('harpoon\.tr\.stop', '⥔')
call s:ConcealFn('harpoon\.bl', '⇃')
call s:ConcealFn('harpoon\.bl\.bar', '⥡')
call s:ConcealFn('harpoon\.bl\.stop', '⥙')
call s:ConcealFn('harpoon\.br', '⇂')
call s:ConcealFn('harpoon\.br\.bar', '⥝')
call s:ConcealFn('harpoon\.br\.stop', '⥕')
call s:ConcealFn('harpoon\.lt\.rt', '⥎')
call s:ConcealFn('harpoon\.lb\.rb', '⥐')
call s:ConcealFn('harpoon\.lb\.rt', '⥋')
call s:ConcealFn('harpoon\.lt\.rb', '⥊')
call s:ConcealFn('harpoon\.tl\.bl', '⥑')
call s:ConcealFn('harpoon\.tr\.br', '⥏')
call s:ConcealFn('harpoon\.tl\.br', '⥍')
call s:ConcealFn('harpoon\.tr\.bl', '⥌')
call s:ConcealFn('harpoons\.rtrb', '⥤')
call s:ConcealFn('harpoons\.blbr', '⥥')
call s:ConcealFn('harpoons\.bltr', '⥯')
call s:ConcealFn('harpoons\.lbrb', '⥧')
call s:ConcealFn('harpoons\.ltlb', '⥢')
call s:ConcealFn('harpoons\.ltrb', '⇋')
call s:ConcealFn('harpoons\.ltrt', '⥦')
call s:ConcealFn('harpoons\.rblb', '⥩')
call s:ConcealFn('harpoons\.rtlb', '⇌')
call s:ConcealFn('harpoons\.rtlt', '⥨')
call s:ConcealFn('harpoons\.tlbr', '⥮')
call s:ConcealFn('harpoons\.tltr', '⥣')
call s:ConcealFn('tack\.r', '⊢')
call s:ConcealFn('tack\.r\.not', '⊬')
call s:ConcealFn('tack\.r\.long', '⟝')
call s:ConcealFn('tack\.r\.short', '⊦')
call s:ConcealFn('tack\.r\.double', '⊨')
call s:ConcealFn('tack\.r\.double\.not', '⊭')
call s:ConcealFn('tack\.l', '⊣')
call s:ConcealFn('tack\.l\.long', '⟞')
call s:ConcealFn('tack\.l\.short', '⫞')
call s:ConcealFn('tack\.l\.double', '⫤')
call s:ConcealFn('tack\.t', '⊥')
call s:ConcealFn('tack\.t\.big', '⟘')
call s:ConcealFn('tack\.t\.double', '⫫')
call s:ConcealFn('tack\.t\.short', '⫠')
call s:ConcealFn('tack\.b', '⊤')
call s:ConcealFn('tack\.b\.big', '⟙')
call s:ConcealFn('tack\.b\.double', '⫪')
call s:ConcealFn('tack\.b\.short', '⫟')
call s:ConcealFn('tack\.l\.r', '⟛')
call s:ConcealFn('alpha', 'α')
call s:ConcealFn('beta', 'β')
call s:ConcealFn('beta\.alt', 'ϐ')
call s:ConcealFn('chi', 'χ')
call s:ConcealFn('delta', 'δ')
call s:ConcealFn('epsilon', 'ε')
call s:ConcealFn('epsilon\.alt', 'ϵ')
call s:ConcealFn('eta', 'η')
call s:ConcealFn('gamma', 'γ')
call s:ConcealFn('iota', 'ι')
call s:ConcealFn('kai', 'ϗ')
call s:ConcealFn('kappa', 'κ')
call s:ConcealFn('kappa\.alt', 'ϰ')
call s:ConcealFn('lambda', 'λ')
call s:ConcealFn('mu', 'μ')
call s:ConcealFn('nu', 'ν')
call s:ConcealFn('ohm', 'Ω')
call s:ConcealFn('ohm\.inv', '℧')
call s:ConcealFn('omega', 'ω')
call s:ConcealFn('omicron', 'ο')
call s:ConcealFn('phi', 'φ')
call s:ConcealFn('phi\.alt', 'ϕ')
call s:ConcealFn('pi', 'π')
call s:ConcealFn('pi\.alt', 'ϖ')
call s:ConcealFn('psi', 'ψ')
call s:ConcealFn('rho', 'ρ')
call s:ConcealFn('rho\.alt', 'ϱ')
call s:ConcealFn('sigma', 'σ')
call s:ConcealFn('sigma\.alt', 'ς')
call s:ConcealFn('tau', 'τ')
call s:ConcealFn('theta', 'θ')
call s:ConcealFn('theta\.alt', 'ϑ')
call s:ConcealFn('upsilon', 'υ')
call s:ConcealFn('xi', 'ξ')
call s:ConcealFn('zeta', 'ζ')
call s:ConcealFn('Alpha', 'Α')
call s:ConcealFn('Beta', 'Β')
call s:ConcealFn('Chi', 'Χ')
call s:ConcealFn('Delta', 'Δ')
call s:ConcealFn('Epsilon', 'Ε')
call s:ConcealFn('Eta', 'Η')
call s:ConcealFn('Gamma', 'Γ')
call s:ConcealFn('Iota', 'Ι')
call s:ConcealFn('Kai', 'Ϗ')
call s:ConcealFn('Kappa', 'Κ')
call s:ConcealFn('Lambda', 'Λ')
call s:ConcealFn('Mu', 'Μ')
call s:ConcealFn('Nu', 'Ν')
call s:ConcealFn('Omega', 'Ω')
call s:ConcealFn('Omicron', 'Ο')
call s:ConcealFn('Phi', 'Φ')
call s:ConcealFn('Pi', 'Π')
call s:ConcealFn('Psi', 'Ψ')
call s:ConcealFn('Rho', 'Ρ')
call s:ConcealFn('Sigma', 'Σ')
call s:ConcealFn('Tau', 'Τ')
call s:ConcealFn('Theta', 'Θ')
call s:ConcealFn('Upsilon', 'Υ')
call s:ConcealFn('Xi', 'Ξ')
call s:ConcealFn('Zeta', 'Ζ')
call s:ConcealFn('aleph', 'א')
call s:ConcealFn('alef', 'א')
call s:ConcealFn('beth', 'ב')
call s:ConcealFn('bet', 'ב')
call s:ConcealFn('gimmel', 'ג')
call s:ConcealFn('gimel', 'ג')
call s:ConcealFn('shin', 'ש')
call s:ConcealFn('AA', '𝔸')
call s:ConcealFn('BB', '𝔹')
call s:ConcealFn('CC', 'ℂ')
call s:ConcealFn('DD', '𝔻')
call s:ConcealFn('EE', '𝔼')
call s:ConcealFn('FF', '𝔽')
call s:ConcealFn('GG', '𝔾')
call s:ConcealFn('HH', 'ℍ')
call s:ConcealFn('II', '𝕀')
call s:ConcealFn('JJ', '𝕁')
call s:ConcealFn('KK', '𝕂')
call s:ConcealFn('LL', '𝕃')
call s:ConcealFn('MM', '𝕄')
call s:ConcealFn('NN', 'ℕ')
call s:ConcealFn('OO', '𝕆')
call s:ConcealFn('PP', 'ℙ')
call s:ConcealFn('QQ', 'ℚ')
call s:ConcealFn('RR', 'ℝ')
call s:ConcealFn('SS', '𝕊')
call s:ConcealFn('TT', '𝕋')
call s:ConcealFn('UU', '𝕌')
call s:ConcealFn('VV', '𝕍')
call s:ConcealFn('WW', '𝕎')
call s:ConcealFn('XX', '𝕏')
call s:ConcealFn('YY', '𝕐')
call s:ConcealFn('ZZ', 'ℤ')
call s:ConcealFn('ell', 'ℓ')
call s:ConcealFn('planck', 'ℎ')
call s:ConcealFn('planck\.reduce', 'ℏ')
call s:ConcealFn('angstrom', 'Å')
call s:ConcealFn('kelvin', 'K')
call s:ConcealFn('Re', 'ℜ')
call s:ConcealFn('Im', 'ℑ')
call s:ConcealFn('dotless\.i', '𝚤')
call s:ConcealFn('dotless\.j', '𝚥')
