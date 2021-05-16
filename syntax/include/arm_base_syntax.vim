
setlocal iskeyword  +=.,_,\$

syn keyword armTodo     contained todo fixme danger note notice bug author date

" FIXME: not sure why this often doesnt highlight, but nbd
" - it's also quite slow...consider reverting to original
"syn match armNumericOp  "+\|\-\|!\|\*\|=\|\^\|&"

" Assembler identifiers/labels
syn match armIdentifier "\<[.\$_A-Za-z]\+[_0-9A-Za-z]\+\>"
syn match armLabel      "<[_a-zA-Z]\+.*>"

" Leading addresses in dis-assembly
syn match disasAddress  "^\s\+\x\+:\s\+\x\+[ ]\?\x*"

" dec
syn match armNumber     "[#\$]\?\d\+\>"
" hex
syn match armNumber     "\([#\$]\?0x\x\+\>\)\|\(\<\x\+\>\)"
" bin
syn match armNumber     "[#\$]\?0b[01]\+\>"
" floats
syn match armNumber     "\%(\d\+\.\d*\|\d*\.\d\+\)\%([eE]\?[-+]\?\d\+\)\?\>"

" Comments
syn region armComment   start="//\|@\|;" end="$" contains=armTodo
syn region armComment   start="/\*"   end="\*/" contains=armTodo

" String literal
syn region armString    start=/"/ skip=/\\"/ end=/"/
" Ascii character literal
syn match armString     "'\\\?[\d32-~]'\?"

so <sfile>:p:h/gas_directives.vim
so <sfile>:p:h/arm_directives.vim

syn match armCPreProc   "^\s*#\s*\(include\|define\|undef\|if\|ifdef\|ifndef\|elif\|else\|endif\|error\|pragma\)\>"

" Registers
syn match armRegister "\<R\%(1[0-5]\|[0-9]\)\>"
syn match armRegister "\<C\%(1[0-5]\|[0-9]\)\>"
syn match armRegister "\<P\%(1[0-5]\|[0-9]\)\>"
syn keyword armRegister IP FP SP LR SL PC FPSCR SPSR CPSR CPSR_c CPSR_cxsf BP
syn match armRegister "\<A[1-3]\>"
syn match armRegister "\<V[1-8]\>"

" Conditional or Width suffix to avoid repetition
" - e.g., beq.n (covers variants emitted in dis-assembly)
let armCond = '\%(' .
   \ 'AL\|CC\|CS\|EQ\|\|DEQ\|GE\|GT\|HI\|HS\|LE\|LO\|LS\|LT\|MI\|' .
   \ 'NE\|PL\|VC\|VS' .
\ '\)\?' .
\ '\%(\.N\|\.W\)\?'

" ARMv4 and thumb instructions
exec 'syn match armv4Instr "\%(ADC\|ADD\|AND\|ASR\|BIC\|EOR\|LSL\|LSR\|MLA\|MOV\|MUL\|MVN\|NEG\|ORR\|ROR\|RRX\|RSB\|RSC\|SBC\|SMLAL\|SMULL\|SUB\|UMLAL\|UMULL\)' . armCond . 'S\?\>"'

exec 'syn match armv4InstrCond  "\%(B\|BL\|BX\|CDP\|CMN\|CMP\|LDC\|MCR\|MRC\|MRS\|MSR\|NOP\|POP\|PUSH\|STC\|SWI\|TEQ\|TST\)' . armCond . '\>"'

exec 'syn match armv4InstrCond  "ADR' . armCond . 'L\?\>"'

exec 'syn match armv4LDR    "\%(LDR\)' . armCond . '\%(B\?T\?\|H\|S[BH]\)\?\>"'
exec 'syn match armv4STR    "\%(STR\)' . armCond . '\%(B\?T\?\|H\)\?\>"'
exec 'syn match armv4Stack  "\%(LDM\|STM\)' . armCond . '\%([ID][BA]\)\?\|\%([EF][DA]\)\?\%(\.W\)\?\>"'
exec 'syn match armv4SWP    "SWP' . armCond . 'B\?\>"'

"syn match armRelative      "@R[0-7]\|@a\s*+\s*dptr\|@[ab]"

