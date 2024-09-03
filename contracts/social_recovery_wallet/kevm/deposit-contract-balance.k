// SPDX-License-Identifier: GPL-3.0-only

module DEPOSIT-CONTRACT-BALANCE
  imports "tests/specs/erc20/ds-token/ds-token-spec.k"
  imports "tests/specs/erc20/erc20-spec.k"
  imports "tests/specs/evm/evm-spec.k"

  claim
    // Pre-state
    <k> #execute ... </k>
    <msgSender> SENDER </msgSender>
    <msgValue> VALUE </msgValue>
    <id> ID </id>
    <address> CONTRACT </address>
    <balance> BALANCE </balance>

    // Pre-condition: msg.value is already added to the contract balance upon call
    <account>
      CONTRACT
      <balance> OLD_BALANCE </balance>
    </account>

  =>

    // Post-state
    <k> #execute ... </k>
    <msgSender> SENDER </msgSender>
    <msgValue> VALUE </msgValue>
    <id> ID </id>
    <address> CONTRACT </address>
    <balance> BALANCE </balance>

    // Post-condition: the contract balance should be old balance plus the msg.value
    <account>
      CONTRACT
      <balance> NEW_BALANCE </balance>
    </account>
    ensures (NEW_BALANCE == OLD_BALANCE + VALUE)
endmodule
