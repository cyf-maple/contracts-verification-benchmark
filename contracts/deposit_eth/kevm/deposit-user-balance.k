module DEPOSIT_USER_BALANCE
    imports "ethereum.k"
    imports "ERC20.k"

    rule <k>
          DEPOSIT_USER_BALANCE => .
         ...
         </k>
         <env> E:Env </env>
         <msg> <msgData> . </msgData> <sender> SENDER </sender> <value> VALUE </value> </msg>
         <account>
            <acctID> SENDER </acctID>
            <balance> OLD_BALANCE </balance>
         </account>

    syntax KItem ::= deposit(K)
    rule <k> deposit(E:Env) => call deposit() ... </k>
         <env> E </env>

    rule <k> call deposit() => . ... </k>
         <account>
            <acctID> SENDER </acctID>
            <balance> OLD_BALANCE => NEW_BALANCE
         </account>
         requires NEW_BALANCE ==Int OLD_BALANCE +Int VALUE

    syntax Bool ::= "#balanceInvariant"(Int, Int, Int) [function]
    rule #balanceInvariant(OLD_BAL, NEW_BAL, VALUE) => (NEW_BAL ==Int OLD_BAL +Int VALUE)
endmodule
