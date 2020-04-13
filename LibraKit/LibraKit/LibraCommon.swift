//
//  LibraCommon.swift
//  LibraWallet
//
//  Created by palliums on 2019/12/18.
//  Copyright © 2019 palliums. All rights reserved.
//

import UIKit

/// Violas签名盐
let LibraSignSalt  = "RawTransaction::libra_types::transaction@@$$LIBRA$$@@"
//let violasSignSalt  = "RawTransaction@@$$LIBRA$$@@"

/// Violas计算助记词盐
let LibraMnemonicSalt = "LIBRA WALLET: mnemonic salt prefix$LIBRA"
//Libra交易盐(libra_peer_to_peer_transfer.mv)
//let libraProgramCode = "{\"code\":[161,28,235,11,1,0,7,1,70,0,0,0,4,0,0,0,3,74,0,0,0,6,0,0,0,12,80,0,0,0,6,0,0,0,13,86,0,0,0,6,0,0,0,5,92,0,0,0,41,0,0,0,4,133,0,0,0,32,0,0,0,7,165,0,0,0,15,0,0,0,0,0,0,1,0,2,0,1,3,0,2,0,2,5,3,0,3,2,5,3,3,0,6,60,83,69,76,70,62,12,76,105,98,114,97,65,99,99,111,117,110,116,4,109,97,105,110,15,112,97,121,95,102,114,111,109,95,115,101,110,100,101,114,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,2,0,4,0,11,0,11,1,18,1,1,2],\"args\":[]}"
let libraProgramCode = "a11ceb0b010007014600000004000000034a0000000c000000045600000002000000055800000009000000076100000029000000068a00000010000000099a0000001200000000000001010200010101000300010101000203050a020300010900063c53454c463e0c4c696272614163636f756e740f7061795f66726f6d5f73656e646572046d61696e00000000000000000000000000000000010000ffff030005000a000b010a023e0002"
// Libra合约交易（libra_peer_to_peer_transfer_with_metadata.mv）
//let LibraTransferWithData = "{\"code\":[161,28,235,11,1,0,7,1,70,0,0,0,4,0,0,0,3,74,0,0,0,6,0,0,0,12,80,0,0,0,7,0,0,0,13,87,0,0,0,7,0,0,0,5,94,0,0,0,55,0,0,0,4,149,0,0,0,32,0,0,0,7,181,0,0,0,17,0,0,0,0,0,0,1,0,2,0,1,3,0,2,0,3,5,3,9,0,3,3,5,3,9,3,0,6,60,83,69,76,70,62,12,76,105,98,114,97,65,99,99,111,117,110,116,4,109,97,105,110,29,112,97,121,95,102,114,111,109,95,115,101,110,100,101,114,95,119,105,116,104,95,109,101,116,97,100,97,116,97,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,3,0,5,0,11,0,11,1,11,2,18,1,1,2],\"args\":[]}"

let LibraTransferWithData = "a11ceb0b010007014600000004000000034a000000060000000c50000000080000000d580000000800000005600000003700000004970000002000000007b7000000110000000000000200010001030002000305030b0200030305030b020300063c53454c463e046d61696e0c4c696272614163636f756e741d7061795f66726f6d5f73656e6465725f776974685f6d657461646174610000000000000000000000000000000000000000000000000000000000000000000000030005000b000b010b0212010102"
