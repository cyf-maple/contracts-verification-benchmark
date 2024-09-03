module DEPOSIT_REVERT_IF_LOW_ETH
    imports "ethereum.k"
    imports "ERC20.k"

    rule <k>
          DEPOSIT_REVERT_IF_LOW_ETH => .
         ...
         </k>
         <env> E:Env </env>
         <msg> <msgData> . </msgData> <sender> SENDER </sender> <value> VALUE </value> </msg>
         <account>
            <acctID> SENDER </acctID>
            <balance> BALANCE </balance>
         </account>
         requires VALUE >Int BALANCE

    syntax KItem ::= depositWithRevert(K)
    rule <k> depositWithRevert(E:Env) => call depositWithRevert() ... </k>
         <env> E </env>

    rule <k> call depositWithRevert() => . ... </k>
         <revert> true </revert>
         <lastReverted> true </lastReverted>

endmodule
