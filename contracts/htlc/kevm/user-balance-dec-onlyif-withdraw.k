module USER_BALANCE_DEC_ONLYIF_WITHDRAW
    imports "ethereum.k"
    imports "ERC20.k"

    syntax KItem ::= userBalanceDecOnlyIfWithdraw(K)
    rule <k> userBalanceDecOnlyIfWithdraw(E:Env, F:KFunction, ARGS:KList, A:Address) => . ... </k>
         <env> E </env>
         <method> F </method>
         <calldataarg> ARGS </calldataarg>
         <account>
            <acctID> A </acctID>
            <balance> CURRB </balance>
         </account>

    syntax KItem ::= callFunction(KFunction, KList)
    rule <k> callFunction(F:KFunction, ARGS:KList) => F(E, ARGS) ... </k>
         <env> E </env>

    rule <k> F(E:Env, ARGS:KList) => . ... </k>
         <env> E </env>
         <account>
            <acctID> A </acctID>
            <balance> CURRB => NEWB
         </account>

    syntax Bool ::= #balanceDecreasedOnlyIfWithdraw(Int, Int, KFunction, Env, Address) [function]
    rule #balanceDecreasedOnlyIfWithdraw(CURRB, NEWB, F, E, A) => (NEWB <Int CURRB => (F.selector ==Int SIG_WITHDRAW && E.msg.sender == A))

    syntax Int ::= SIG_WITHDRAW
    rule SIG_WITHDRAW => 0x2e1a7d4d

    rule <k> assert #balanceDecreasedOnlyIfWithdraw(CURRB, NEWB, F, E, A) => . ... </k>
         <account>
            <acctID> A </acctID>
            <balance> NEWB </balance>
         </account>
         <env> E </env>
         <method> F </method>
         <calldataarg> ARGS </calldataarg>

endmodule
