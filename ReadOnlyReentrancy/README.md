## This is an example of a read-only reentrancy attack exploit.

#### Contracts:
- ICurve(stETH pool) x*y = k ===> x = ETH, Y = stETH (Staked ETH From lido)
- IERC20(LP Token)
- Target
- Hack

#### Stack Frame from 0 to n(Hard limit of 1024 frame):

##### Stack Frame for the EOA calling Hack.setup

0.  EOA -> Hack.setup
    - msg.sender = EOA
    - msg.value = 100 ether

1.  Hack.setup -> pool.add_liquidity
    - msg.sender = Hack
    - msg.value = 100 ether
    - amount = [100 ether, 0]
    - min_mint_lp = 0
    - returns lp token
    - completed after the lp token is return to the caller address

2.  Hack.setup -> token.approve
    - msg.sender = Hack
    - msg.value = 0
    - amount = lp
    - address = address(target) approving target contract for spending lp token from my account
    - return true

3.  Hack.setup -> target.stake
    - msg.sender = Hack
    - msg.value = 0
    - amount = lp

***If no call frame reverts, the EVM commits all storage updates at the end of the transaction. These updates are then finalized through the consensus process and become part of the global world state.***



##### Stack Frame for EOA calling Hack.pwn

0.  EOA -> Hack.pwn
    - msg.sender = EOA
    - msg.value = 1000 ether

1.  Hack.pwn -> pool.add_liquidity(**This will complete and get poped out from the stack frame**)
    - msg.sender = Hack
    - msg.value = 1000 ether
    - amount = [msg.value, 0]
    - min_mint_lp = 0
    - returns lp tokens

2.  Hack.pwn -> pool.get_virtual_price(**This will complete and get poped out from the stack frame**)
    - msg.sender = Hack
    - msg.value = 0
    - return value of 1 lp token in the uint of ether

3.  Hack.pwn -> pool.remove_liquidity
    - msg.sender = Hack
    - msg.value = 0
    - lp = x
    - min_amount = [uint(0), uint(0)]

4.  pool.remove_liquidity -> Hack.fallback
    - msg.sender = pool
    - msg.value = y ether
    - **External call + unfinished state = reentrancy risk**

5.  Hack.fallback -> pool.get_virtual_price
    - msg.sender = Hack
    - msg.value = 0
    - return value of 1 lp token

6.  Hack.fallback -> target.getReward
    - msg.sender = Hack
    - msg.value = 0
    - return reward **Here it will give more reward because the get_virtual price will more**

7.  target.getReward -> pool.get_virtual_price
    - msg.sender = target
    - msg.value = 0
    - return value of 1 lp token

8.  Hack.pwn -> target.getReward
    - msg.sender = Hack
    - msg.value = 0
    - return reward

9.  target.getReward -> pool.get_virtual_price
    - msg.sender = target
    - msg.value = 0
    - return value of 1 lp token


### Note
- This demonstrates a read-only reentrancy attack, where the target contract reads the LP token price while pool.remove_liquidity is still executing, causing the LP token value to temporarily increase.