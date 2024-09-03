import subprocess
import os

def run_kevm(command):
    try:
        result = subprocess.run(command, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return result.stdout.decode('utf-8')
    except subprocess.CalledProcessError as e:
        print(f"Error executing command: {e.cmd}")
        print(f"Return code: {e.returncode}")
        print(f"Output: {e.output.decode('utf-8')}")
        print(f"Error: {e.stderr.decode('utf-8')}")
        return None

def verify_contract(contract_file, rule_file):
    kevm_command = f"kevm prove {contract_file} --spec {rule_file} --backend haskell"
    print(f"Running command: {kevm_command}")
    result = run_kevm(kevm_command)
    if result:
        print("Verification result:")
        print(result)
    else:
        print("Verification failed.")

if __name__ == "__main__":
    # Example usage
    contract_file = "./contract.sol"
    rule_file = "./deposit-contract-balance.k"
    
    if not os.path.exists(contract_file):
        print(f"Contract file does not exist: {contract_file}")
    elif not os.path.exists(rule_file):
        print(f"Rule file does not exist: {rule_file}")
    else:
        verify_contract(contract_file, rule_file)
