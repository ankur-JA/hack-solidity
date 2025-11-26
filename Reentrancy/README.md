## Reentrancy

Contract A       ------------>       Contract B
    |                                     |
    |_____________________________________|

### Contract - A(3 Ether)
### Contract - B(0 Ether)
### EOA - (1 Ether)

##### frame-0: EOA -----> B.attack()
- msg.sender = EOA
- msg.Value = 1 Ether
- Check msg.value > 0
- Call A.deposit()
- Call A.withdraw(1 ether)
- completed
- popped

#### frame-1: B.attack() -----> A.deposit()     // This is completed and removed from the call stack 
- msg.sender = address(B)
- msg.value = 1 ether
- update's the state variable balanace[msg.sender] = 1 ether;
- address(A).balance = 4 ether it get updated
- popped out

#### frame-1: B.attack() -----> A.Withdraw()
- msg.sender = B
- msg.value = 1 ether
- check balance[msg.sender] >= 1 ether
- send ETH to B.fallback
- pending 
- success = true
- balance[msg.sender] -= 1 ==> 2**256 - 3
- completed
- popped

#### frame-2: A.withdraw() ------> B.fallback()
- msg.sender = A
- msg.value = 1 ether
- address(A).balance = 3 ether
- address(B).balance = 1 ether
- check address(A).balance >= 1 ether = true
- call --- A.withdraw 
- pending
- completed
- popped

#### frame-3: B.fallback() ----> A.withdraw()
- msg.sender = B
- msg.value = 1 ether
- check balance[msg.sender] >= 1 ether  = true
- send ETH to B.fallback()
- pending
- success = true
- balance[msg.sender] -= 1 (2**256 - 2)
- completed
- popped

#### frame-4: A.withdraw() -----> B.fallback()
- msg.sender = A
- msg.value = 1 ether
- address(A).balance = 2 ether
- address(B).balance = 2 ether
- check address(A).balance >= 1 ether = true
- call A.Withdraw()
- pending
- completed
- popped

#### frame-5: B.fallback() ---------> A.withdraw()
- msg.sender  = B
- msg.value = 1 ether
- check balance[msg.sender] >= 1 ether = true
- send ETH to B.fallback()
- pending
- succes = true
- balance[msg.sender] -= 1 >>> 0 - 1 (Uint underflow)  ----> if it unchecked it will wraped around be +ve interger(2**256 - 1)
- completed
- popped


#### frame-6: A.withdraw() --------> B.fallback()
- msg.sender = A
- msg.value = 1 ether
- address(A).balance = 1 ether
- address(B).balance = 3 ether
- check addresss(A).balance >= 1 ether = true
- call A.withdraw()
- pending
- completed
- popped


#### frame-7:  B.fallback() ------> A.withdraw()
- msg.sender = B
- msg.value = 1 ether
- check balance[msg.sender] >= 1 ether = true
- send ETH B.fallback()
- pending
- success = true
- balance[msg.sender] -= 1 -------> balance[msg.sender] = 0
- completed
- popped


#### frame-8: A.withdraw()  ------> B.fallbakc()
- msg.sender = A
- msg.value = 1 ether
- address(A).balance = 0
- address(B).balance = 4
- check address(A).balance >= 1 ether = false
- completed the funciton with no return value (it is void funtion)
- popped
    

### Preentive Techniques- 
- Ensure all state change happen before calling exteranl contracts
- use function modifiers that prevent re-entrancy