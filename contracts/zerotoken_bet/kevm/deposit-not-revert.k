module DEPOSIT_NOT_REVERT
    imports "ethereum.k"
    imports "ERC20.k"

    rule <k>
          DEPOSIT_NOT_REVERT => .
         ...
         </k>
         <env> E:Env </env>
         <msg> <msgData> . </msgData> <sender> SENDER </sender> <value> VALUE </value> </msg>
         <account>
            <acctID> SENDER </acctID>
            <balance> BALANCE </balance>
         </account>
         requires VALUE <=Int BALANCE

    syntax KItem ::= depositWithRevert(K)
    rule <k> depositWithRevert(E:Env) => call depositWithRevert() ... </k>
         <env> E </env>

    rule <k> call depositWithRevert() => . ... </k>
         <revert> false </revert>
         <lastReverted> false </lastReverted>

    syntax Bool ::= "#balanceInvariant"(Int, Int) [function]
    rule #balanceInvariant(OLD_BAL, NEW_BAL) => (NEW_BAL ==Int OLD_BAL +Int VALUE)

endmodule

module DEPOSIT
    imports "ethereum.k"

    syntax Int ::= #getUserBalance (Account) [function]
    rule <k> #getUserBalance(SENDER) => BALANCE ... </k>
         <account>
            <acctID> SENDER </acctID>
            <balance> BALANCE </balance>
         </account>

    rule <k> DEPOSIT => . ... </k>
         <msg> <sender> SENDER </sender> <value> VALUE </value> </msg>
         <account>
            <acctID> SENDER </acctID>
            <balance> OLD_BAL </balance>
         </account>
         <ghostvar> <ghostUserBalance> OLD_BAL </ghostUserBalance> </ghostvar>
         <account>
            <acctID> SENDER </acctID>
            <balance> NEW_BAL </balance>
         </account>
         <ghostvar> <ghostNewUserBalance> NEW_BAL </ghostNewUserBalance> </ghostvar>
         requires #balanceInvariant(OLD_BAL, NEW_BAL)
endmodule
