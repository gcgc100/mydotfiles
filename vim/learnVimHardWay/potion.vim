if exists("b:current_syntax")
    finish
endif

syntax keyword potionKeyword to times loop while
syntax keyword potionKeyword if elsif else
syntax keyword potionKeyword class return

syntax keyword potionFunction print join string

highlight link potionKeyword Keyword
highlight link potionFunction Function

syntax match potionCommet "\v#.*$"
highlight link potionCommet Comment

syntax match potionOperator "\v\+"
syntax match potionOperator "\v-"
syntax match potionOperator "\v\*"
syntax match potionOperator "\v/"
syntax match potionOperator "\v\?"
syntax match potionOperator "\v\="
syntax match potionOperator "\v\*\="
syntax match potionOperator "\v/\="
syntax match potionOperator "\v\+\="
syntax match potionOperator "\v-\="

highlight link potionOperator Operator

syntax match potionNumber "\v-?\d+"
syntax match potionNumber "\v-?\d+\.\d+"
syntax match potionNumber "\v0x[a-f0-9]+"
syntax match potionNumber "\v-?\d+e-?\d+"
syntax match potionNumber "\v-?\d+\.\d+e-?\d+"

highlight link potionNumber Number

syntax region potionString start=/\v"/ skip=/\v\\./ end=/\v"/
highlight link potionString String

let b:current_syntax = "potion"

