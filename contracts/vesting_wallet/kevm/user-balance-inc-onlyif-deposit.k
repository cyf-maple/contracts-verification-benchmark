module USER_BALANCE_INC_ONLYIF_DEPOSIT
    imports "ethereum.k"
    imports "ERC20.k"

    syntax KItem ::= userBalanceIncOnlyIfDeposit(K)
    rule <k> userBalanceIncOnlyIfDeposit(E:Env, F:KFunction, ARGS:KList, A:Address) => . ... </k>
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

    syntax Bool ::= #balanceIncreasedOnlyIfDeposit(Int, Int, KFunction, Env, Address) [function]
    rule #balanceIncreasedOnlyIfDeposit(CURRB, NEWB, F, E, A) => (NEWB >Int CURRB => (F.selector ==Int SIG_DEPOSIT && E.msg.sender == A))

    syntax Int ::= SIG_DEPOSIT
    rule SIG_DEPOSIT => 0xd0e30db0 // "deposit()" 的选择器

    rule <k> assert #balanceIncreasedOnlyIfDeposit(CURRB, NEWB, F, E, A) => . ... </k>
         <account>
            <acctID> A </acctID>
            <balance> NEWB </balance>
         </account>
         <env> E </env>
         <method> F </method>
         <calldataarg> ARGS </calldataarg>

endmodule
