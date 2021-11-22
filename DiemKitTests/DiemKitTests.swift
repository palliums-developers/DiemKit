//
//  DiemSDKTests.swift
//  DiemWalletTests
//
//  Created by palliums on 2019/9/5.
//  Copyright © 2019 palliums. All rights reserved.
//

import XCTest
import CryptoSwift
import BigInt
import CryptoKit

@testable import DiemKit
class DiemSDKTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testLibraSDK() {
        let mnemonic = ["legal","winner","thank","year","wave","sausage","worth","useful","legal","winner","thank","year","wave","sausage","worth","useful","legal","will"]
        do {
            let seed = try DiemMnemonic.seed(mnemonic: mnemonic)
//            XCTAssertEqual(seed.toHexString(), "66ae6b767defe3ea0c646f10bf31ad3b36f822064d3923adada7676703a350c0")
            let testWallet = try DiemHDWallet.init(seed: seed, depth: 0, network: .testnet)
            XCTAssertEqual(testWallet.privateKey.raw.toHexString(), "732bc883893c716f320c01864709ca9f16f8f30342a1de42144bfcc2ddb7af10")
            let testWallet2 = try DiemHDWallet.init(seed: seed, depth: 1, network: .testnet)
            XCTAssertEqual(testWallet2.privateKey.raw.toHexString(), "f6b472bd0941e315d3c34c3ac679d610d2b9e1abe85128752d04bb0f042f3391")
        } catch {
            print(error.localizedDescription)
        }
    }
    func testLibraSDK2() {
        let mnemonic = ["trouble", "menu", "nephew", "group", "alert", "recipe", "hotel", "fatigue", "wet", "shadow", "say", "fold", "huge", "olive", "solution", "enjoy", "garden", "appear", "vague", "joy", "great", "keep", "cactus", "melt"]
        do {
            let seed = try DiemMnemonic.seed(mnemonic: mnemonic)
            let testWallet = try DiemHDWallet.init(seed: seed, depth: 0, network: .testnet)
            let walletAddress = testWallet.publicKey.toLegacy()
            XCTAssertEqual(walletAddress, "6c1dd50f35f120061babc2814cf9378b")
        } catch {
            print(error.localizedDescription)
        }
    }
    func testLibraKit() {
        //LibraTransactionArgument
        // u64
        let amount = DiemTransactionArgument.init(code: .U64(9213671392124193148)).serialize().toHexString().uppercased()
        XCTAssertEqual(amount, "017CC9BDA45089DD7F")
        // Address
        let address = DiemTransactionArgument.init(code: .Address("bafc671e8a38c05706f83b5159bbd8a4")).serialize().toHexString()
        XCTAssertEqual(address  , "03bafc671e8a38c05706f83b5159bbd8a4")
        // U8Vector
        let u8vector = DiemTransactionArgument.init(code: .U8Vector(Data.init(Array<UInt8>(hex: "CAFED00D")))).serialize().toHexString().uppercased()
        XCTAssertEqual(u8vector, "0404CAFED00D")
        // Bool
        let bool1 = DiemTransactionArgument.init(code: .Bool(false)).serialize().toHexString().uppercased()
        XCTAssertEqual(bool1, "0500")
        // Bool
        let bool2 = DiemTransactionArgument.init(code: .Bool(true)).serialize().toHexString().uppercased()
        XCTAssertEqual(bool2, "0501")
        //LibraTransactionAccessPath
        let accessPath1 = DiemAccessPath.init(address: "a71d76faa2d2d5c3224ec3d41deb2939",
                                               path: "01217da6c6b3e19f1825cfb2676daecce3bf3de03cf26647c78df00b371b25cc97",
                                               writeOp: .Deletion)
        let accessPath2 = DiemAccessPath.init(address: "c4c63f80c74b11263e421ebf8486a4e3",
                                               path: "01217da6c6b3e19f18",
                                               writeOp: .Value(Data.init(Array<UInt8>(hex: "CAFED00D"))))
        let writeSet = DiemWriteSet.init(accessPaths: [accessPath1, accessPath2])
        let writeSetCheckData: Array<UInt8> = [0x02, 0xA7, 0x1D, 0x76, 0xFA, 0xA2, 0xD2, 0xD5, 0xC3, 0x22, 0x4E, 0xC3, 0xD4, 0x1D, 0xEB,
                                               0x29, 0x39, 0x21, 0x01, 0x21, 0x7D, 0xA6, 0xC6, 0xB3, 0xE1, 0x9F, 0x18, 0x25, 0xCF, 0xB2,
                                               0x67, 0x6D, 0xAE, 0xCC, 0xE3, 0xBF, 0x3D, 0xE0, 0x3C, 0xF2, 0x66, 0x47, 0xC7, 0x8D, 0xF0,
                                               0x0B, 0x37, 0x1B, 0x25, 0xCC, 0x97, 0x00, 0xC4, 0xC6, 0x3F, 0x80, 0xC7, 0x4B, 0x11, 0x26,
                                               0x3E, 0x42, 0x1E, 0xBF, 0x84, 0x86, 0xA4, 0xE3, 0x09, 0x01, 0x21, 0x7D, 0xA6, 0xC6, 0xB3,
                                               0xE1, 0x9F, 0x18, 0x01, 0x04, 0xCA, 0xFE, 0xD0, 0x0D]
        XCTAssertEqual(writeSet.serialize().toHexString().lowercased(), Data.init(writeSetCheckData).toHexString())
        // LibraTransactionPayload_WriteSet
        let writeSetPayload = DiemTransactionWriteSetPayload.init(code: .direct(writeSet, [DiemContractEvent]()))
        let transactionWriteSetPayload = DiemTransactionPayload.init(payload: .writeSet(writeSetPayload))
        let writeSetPayloadData: Array<UInt8> = [0, 0, 2, 167, 29, 118, 250, 162, 210, 213, 195, 34, 78, 195, 212, 29, 235, 41, 57, 33, 1,
                                                 33, 125, 166, 198, 179, 225, 159, 24, 37, 207, 178, 103, 109, 174, 204, 227, 191, 61, 224,
                                                 60, 242, 102, 71, 199, 141, 240, 11, 55, 27, 37, 204, 151, 0, 196, 198, 63, 128, 199, 75,
                                                 17, 38, 62, 66, 30, 191, 132, 134, 164, 227, 9, 1, 33, 125, 166, 198, 179, 225, 159, 24, 1,
                                                 4, 202, 254, 208, 13, 0]
        
        XCTAssertEqual(transactionWriteSetPayload.serialize().toHexString().lowercased(), Data.init(writeSetPayloadData).toHexString())
        // LibraTransactionPayload_Module
        let module = DiemTransactionPayload.init(payload: .module(DiemTransactionModulePayload.init(code: Data.init(Array<UInt8>(hex: "CAFED00D")))))
        XCTAssertEqual(module.serialize().toHexString().uppercased(), "02CAFED00D")
        let writeSetRaw = DiemRawTransaction.init(senderAddres: "c3398a599a6f3b9f30b635af29f2ba04",
                                                   sequenceNumber: 32,
                                                   maxGasAmount: 0,
                                                   gasUnitPrice: 0,
                                                   expirationTime: UINT64_MAX,
                                                   payload: transactionWriteSetPayload,
                                                   module: "LBR",
                                                   chainID: 4)
        let rawTransactioinWriteSetCheckData: Array<UInt8> = [195, 57, 138, 89, 154, 111, 59, 159, 48, 182, 53, 175, 41, 242, 186, 4, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 167, 29, 118, 250, 162, 210, 213, 195, 34, 78, 195, 212, 29, 235, 41, 57, 33, 1, 33, 125, 166, 198, 179, 225, 159, 24, 37, 207, 178, 103, 109, 174, 204, 227, 191, 61, 224, 60, 242, 102, 71, 199, 141, 240, 11, 55, 27, 37, 204, 151, 0, 196, 198, 63, 128, 199, 75, 17, 38, 62, 66, 30, 191, 132, 134, 164, 227, 9, 1, 33, 125, 166, 198, 179, 225, 159, 24, 1, 4, 202, 254, 208, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 76, 66, 82, 255, 255, 255, 255, 255, 255, 255, 255, 4]
        XCTAssertEqual(writeSetRaw.serialize().toHexString().lowercased(), Data.init(rawTransactioinWriteSetCheckData).toHexString())
        // LibraTransactionPayload_Script
        let transactionScript = DiemTransactionScriptPayload.init(code: ("move".data(using: .utf8)!),
                                                                   typeTags: [DiemTypeTag](),//
                                                                   argruments: [DiemTransactionArgument.init(code: .U64(14627357397735030511))])
        let transactionScriptPayload = DiemTransactionPayload.init(payload: .script(transactionScript))
        let scriptRaw = DiemRawTransaction.init(senderAddres: "3a24a61e05d129cace9e0efc8bc9e338",
                                                 sequenceNumber: 32,
                                                 maxGasAmount: 10000,
                                                 gasUnitPrice: 20000,
                                                 expirationTime: 86400,
                                                 payload: transactionScriptPayload,
                                                 module: "Coin1",
                                                 chainID: 4)
        let rawTransactioinScriptCheckData: Array<UInt8> = [58, 36, 166, 30, 5, 209, 41, 202, 206, 158, 14, 252, 139, 201, 227, 56, 32, 0, 0, 0, 0, 0, 0, 0, 1, 4, 109, 111, 118, 101, 0, 1, 1, 239, 190, 173, 222, 13, 208, 254, 202, 16, 39, 0, 0, 0, 0, 0, 0, 32, 78, 0, 0, 0, 0, 0, 0, 5, 67, 111, 105, 110, 49, 128, 81, 1, 0, 0, 0, 0, 0, 4]
        XCTAssertEqual(scriptRaw.serialize().toHexString().lowercased(), Data.init(rawTransactioinScriptCheckData).toHexString())

    }
    func testED25519() {
        let mnemonic = ["net", "dice", "divide", "amount", "stamp", "flock", "brave", "nuclear", "fox", "aim", "father", "apology"]
        do {
            let salt: Array<UInt8> = Array("LIBRA WALLET: mnemonic salt prefix$LIBRA".utf8)
            let mnemonicTemp = mnemonic.joined(separator: " ")
            let dk = try PKCS5.PBKDF2(password: Array(mnemonicTemp.utf8), salt: salt, iterations: 2048, keyLength: 32, variant: .sha3(SHA3.Variant.sha256)).calculate()
            let keyPairManager = Ed25519.calcPublicKey(secretKey: dk)
            
            print(keyPairManager.sha3(SHA3.Variant.sha256).toHexString())
            
        } catch {
            print(error)
        }
    }
    func testKeychainReinstallGetPasswordAndMnemonic() {
        let mnemonic = ["legal","winner","thank","year","wave","sausage","worth","useful","legal","winner","thank","year","wave","sausage","worth","useful","legal","will"]
//        let mnemonic = ["display", "paddle", "crush", "crowd", "often", "friend", "topple", "agent", "entry", "use", "host", "begin"]
        do {
            let seed = try DiemMnemonic.seed(mnemonic: mnemonic)
            
            let testWallet = try DiemHDWallet.init(seed: seed, depth: 0, network: .testnet)
            let walletAddress = testWallet.publicKey.toLegacy()
            
            //            let menmonicString = try KeychainManager.KeyManager.getMnemonicStringFromKeychain(walletAddress: walletAddress)
            //            let mnemonicArray = menmonicString.split(separator: " ").compactMap { (item) -> String in
            //                return "\(item)"
            //            }
            //            XCTAssertEqual(mnemonic, mnemonicArray)
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    func testULEB128() {
        //        XCTAssertEqual(LibraUtils.uleb128Format(length: 128).toHexString(), "8001")
        XCTAssertEqual(DiemUtils.uleb128Format(length: 16384).toHexString(), "808001")
        //        XCTAssertEqual(LibraUtils.uleb128Format(length: 2097152).toHexString(), "80808001")
        //        XCTAssertEqual(LibraUtils.uleb128Format(length: 268435456).toHexString(), "8080808001")
        //        XCTAssertEqual(LibraUtils.uleb128Format(length: 9487).toHexString(), "8f4a")
        print(DiemUtils.uleb128FormatToInt(data: DiemUtils.uleb128Format(length: 16384)))
        
        XCTAssertEqual(DiemUtils.uleb128FormatToInt(data: DiemUtils.uleb128Format(length: 128)), 128)
        XCTAssertEqual(DiemUtils.uleb128FormatToInt(data: DiemUtils.uleb128Format(length: 16384)), 16384)
        XCTAssertEqual(DiemUtils.uleb128FormatToInt(data: DiemUtils.uleb128Format(length: 2097152)), 2097152)
        XCTAssertEqual(DiemUtils.uleb128FormatToInt(data: DiemUtils.uleb128Format(length: 268435456)), 268435456)
        XCTAssertEqual(DiemUtils.uleb128FormatToInt(data: DiemUtils.uleb128Format(length: 9487)), 9487)
    }
    func testBitmap() {
        var tempBitmap = "00000000000000000000000000000000"
        let range = tempBitmap.index(tempBitmap.startIndex, offsetBy: 0)...tempBitmap.index(tempBitmap.startIndex, offsetBy: 0)
        tempBitmap.replaceSubrange(range, with: "1")
        let range2 = tempBitmap.index(tempBitmap.startIndex, offsetBy: 2)...tempBitmap.index(tempBitmap.startIndex, offsetBy: 2)
        tempBitmap.replaceSubrange(range2, with: "1")
        print(tempBitmap)
        let convert = DiemUtils.binary2dec(num: tempBitmap)
        //  101000 00000000 00000000 00000000
        //1000000 00000000 00000000 00000000
        print(BigUInt(convert).serialize().toHexString())
        
        //        var tempData = Data.init(Array<UInt8>(hex: "00"))
        //        var tempData = 0000 | 1
        //        print(tempData)
    }
    func testMultiAddress() {
//        let wallet = DiemMultiHDWallet.init(privateKeys: [DiemMultiPrivateKeyModel.init(privateKey: Data.init(Array<UInt8>(hex: "f3cdd2183629867d6cfa24fb11c58ad515d5a4af014e96c00bb6ba13d3e5f80e")),
//                                                                                         sequence: 1),
//                                                          DiemMultiPrivateKeyModel.init(privateKey: Data.init(Array<UInt8>(hex: "c973d737cb40bcaf63a45a9736d7d7735e78148a06be185327304d6825e666ea")),
//                                                                                        sequence: 2)],
//                                            threshold: 1,
//                                            network: .testnet)
//        XCTAssertEqual(wallet.publicKey.toLegacy(), "cd35f1a78093554f5dc9c61301f204e4")
    }
    func testLibraKitMulti() {
        let mnemonic1 = ["display", "paddle", "crush", "crowd", "often", "friend", "topple", "agent", "entry", "use", "begin", "host"]
        let mnemonic2 = ["grant", "security", "cluster", "pill", "visit", "wave", "skull", "chase", "vibrant", "embrace", "bronze", "tip"]
        let mnemonic3 = ["net", "dice", "divide", "amount", "stamp", "flock", "brave", "nuclear", "fox", "aim", "father", "apology"]
        do {
            let seed1 = try DiemMnemonic.seed(mnemonic: mnemonic1)
            let seed2 = try DiemMnemonic.seed(mnemonic: mnemonic2)
            let seed3 = try DiemMnemonic.seed(mnemonic: mnemonic3)
            let seedModel1 = DiemSeedAndDepth.init(seed: seed1, depth: 0, sequence: 0)
            let seedModel2 = DiemSeedAndDepth.init(seed: seed2, depth: 0, sequence: 1)
            let seedModel3 = DiemSeedAndDepth.init(seed: seed3, depth: 0, sequence: 2)
            let multiPublicKey = DiemMultiPublicKey.init(data: [DiemMultiPublicKeyModel.init(raw: Data.init(Array<UInt8>(hex: "e12136fd95251348cd993b91e8fbf36bcebe9422842f3c505ca2893f5612ae53")), sequence: 0),
                                                                DiemMultiPublicKeyModel.init(raw: Data.init(Array<UInt8>(hex: "ee2586aaaeaaa39ae4eb601999e5c2aade701ac4262f79ac98d9413cce67b0db")), sequence: 1),
                                                                DiemMultiPublicKeyModel.init(raw: Data.init(Array<UInt8>(hex: "d0b27e06a1bf428c380bd10b7469d8b4f251e763724b2543c730abcaea18c8b0")), sequence: 2)],
                                                         threshold: 2,
                                                         network: .testnet)
            let wallet = try DiemMultiHDWallet.init(models: [seedModel1, seedModel3], threshold: 2, multiPublicKey: multiPublicKey, network: .testnet)
            //            let wallet = try LibraMultiHDWallet.init(models: [seedModel1, seedModel2, seedModel3], threshold: 2)
            print("Legacy = \(wallet.publicKey.toLegacy())")
            //bafc671e8a38c05706f83b5159bbd8a4
            print("Authentionkey = \(wallet.publicKey.toAuthKeyPrefix())")
            //bf2128295b7a57e6e42390d56293760cbafc671e8a38c05706f83b5159bbd8a4
            print("PublicKey = \(wallet.publicKey.toMultiPublicKey().toHexString())")
            //2bd7d9fe82120842daa860606060661b222824c65af7bfb2843eeb7792a3b96750b715879a727bbc561786b0dc9e6afcd5d8a443da6eb632952e692b83e8e7cbe7e1b22eeb0a9ce0c49e3bf6cf23ebbb4d93d24c2064c46f6ceb9daa6ca2e21702
            
            //            let sign = try LibraManager.getMultiTransactionHex(sendAddress: multiPublicKey.toLegacy(),
            //                                                               receiveAddress: "331321aefcce2ee794430d07d7a953a0",
            //                                                               amount: 0.5,
            //                                                               fee: 0,
            //                                                               sequenceNumber: 8,
            //                                                               wallet: wallet)
            //            print(sign)
        } catch {
            print(error.localizedDescription)
        }
    }
    func testLibraKitPublishModule() {
        print(BigUInt(86400).serialize().bytes)
        //        print("LBR".data(using: .utf8)?.bytes.toHexString())
        //        print("T".data(using: .utf8)?.bytes.toHexString())
        //        let data = Data.init(Array<UInt8>(hex: "76696f6c617301003000fa279f2615270daed6061313a48360f7000000005ea2b35be1be1ab8360a35a0259f1c93e3eac736"))
        //        let string = String.init(data: data, encoding: String.Encoding.utf8)
        //        print(string)
        //        print(LibraUtils.getLengthData(length: Int(20000), appendBytesCount: 8).bytes)
    }
    func testDe() {
        let model = DiemManager.derializeTransaction(tx: "793fdd2c245229230fd52aca841875b3080000000000000002f401a11ceb0b010007014600000002000000034800000011000000045900000004000000055d0000001c00000007790000004900000008c20000001000000009d200000022000000000000010001010100020203000003040101010006020602050a0200010501010405030a020a0205050a02030a020a020109000c4c696272614163636f756e74166372656174655f746573746e65745f6163636f756e74066578697374731d7061795f66726f6d5f73656e6465725f776974685f6d6574616461746100000000000000000000000000000000010105010e000a001101200305000508000a000b0138000a000a020b030b04380102010700000000000000000000000000000000034c42520154000503fa279f2615270daed6061313a48360f704000100e1f505000000000400040040420f00000000000000000000000000034c4252eb27cf5e0000000000200825e33e0e828cb8869cf5ca22bb5360cc5edeba621a1cde8f13ed179ce8135f402f957968ff0d3d2c780ee003dbd23ea38d8dee62a64f2de376eb969a0049fad35e24410031346ef0f22fce5dd50f98511a542ccb95e473ba864d1123ab35630c")
        print(model)
    }
    func testA() {
        let a: Array<UInt8> = [165, 87, 66, 216, 60, 179, 202, 135, 205,248,242,49,242,45,215,85,52,162,88,139,23,75,32,230,220,65,41,46,146,206,121,229]
        print(Data.init(a).toHexString())
    }
    func testDiemLargeTransfer() {
        let mnemonic = ["display", "paddle", "crush", "crowd", "often", "friend", "topple", "agent", "entry", "use", "host", "begin"]
        //2e797751e6ae643d129a854f8c739b72 783a439b523f2545d3a71622c9e74b38
//        let mnemonic = ["wrist", "post", "hover", "mixed", "like", "update", "salute", "access", "venture", "grant", "another", "team"]
        //b90148b7d177538c2f91c9a13d695506 f41799563e5381b693d0885b56ebf19b
//        let mnemonic = ["trouble", "menu", "nephew", "group", "alert", "recipe", "hotel", "fatigue", "wet", "shadow", "say", "fold", "huge", "olive", "solution", "enjoy", "garden", "appear", "vague", "joy", "great", "keep", "cactus", "melt"]

        do {
            let seed = try DiemMnemonic.seed(mnemonic: mnemonic)
            let wallet = try DiemHDWallet.init(seed: seed, depth: 0, network: .testnet)
            let walletAddress = wallet.publicKey.toLegacy()
            let active = wallet.publicKey.toAuthKeyPrefix()
            print(walletAddress, active)
            // 拼接交易
            let argument0 = DiemTransactionArgument.init(code: .Address("2da8e2146b015a5986138312baafbc61"))
            let argument1 = DiemTransactionArgument.init(code: .U64(9000_000_000))
//            // metadata
//            let argument2 = LibraTransactionArgument.init(code: .U8Vector("10".data(using: .utf8)!))
//            // metadata_signature
//            let argument3 = LibraTransactionArgument.init(code: .U8Vector(Data.init(hex: "40776041804bfb69ea8f03cdd8b065e51d47aab44e0169826d80ee232fd0fb96f1b9a7431f2e7d4e40270a235548f494568305614012d56302621cdf419bd305")))
            // metadata
            let argument2 = DiemTransactionArgument.init(code: .U8Vector(Data()))
            // metadata_signature
            let argument3 = DiemTransactionArgument.init(code: .U8Vector(Data()))
            let script = DiemTransactionScriptPayload.init(code: Data.init(hex: DiemUtils.getMoveCode(name: "peer_to_peer_with_metadata")),
                                                            typeTags: [DiemTypeTag.init(typeTag: .Struct(DiemStructTag.init(type: .Normal("Coin1"))))],
                                                            argruments: [argument0, argument1, argument2, argument3])
            let transactionPayload = DiemTransactionPayload.init(payload: .script(script))
            let rawTransaction = DiemRawTransaction.init(senderAddres: walletAddress,
                                                          sequenceNumber: 2,
                                                          maxGasAmount: 1000000,
                                                          gasUnitPrice: 10,
                                                          expirationTime: UInt64(Date().timeIntervalSince1970 + 600),
                                                          payload: transactionPayload,
                                                          module: "Coin1",
                                                          chainID: 2)
            let signature = try wallet.buildTransaction(transaction: rawTransaction)
            print(signature.toHexString())
        } catch {
            print(error.localizedDescription)
        }
    }
    func testDiemLargeTransferSign() {
//        let mnemonic = ["display", "paddle", "crush", "crowd", "often", "friend", "topple", "agent", "entry", "use", "host", "begin"]
        //2e797751e6ae643d129a854f8c739b72 783a439b523f2545d3a71622c9e74b38
        let mnemonic = ["wrist", "post", "hover", "mixed", "like", "update", "salute", "access", "venture", "grant", "another", "team"]
        //b90148b7d177538c2f91c9a13d695506 f41799563e5381b693d0885b56ebf19b
        do {
            let seed = try DiemMnemonic.seed(mnemonic: mnemonic)
            let wallet = try DiemHDWallet.init(seed: seed, depth: 0, network: .testnet)
            var result = Data()
            result += "10".data(using: .utf8)!
            
            result += Data.init(Array<UInt8>(hex: "2e9829f376318154bff603ebc8e0b743"))
            
            result += DiemUtils.getLengthData(length: NSDecimalNumber.init(string: "10000000000").uint64Value, appendBytesCount: 8)
            
            result += Array("@@$$LIBRA_ATTEST$$@@".utf8)

            print(result.toHexString())
            // 4.3签名数据
            let sign = Ed25519.sign(message: result.bytes, secretKey: wallet.privateKey.raw.bytes)
            let testResult = Ed25519.verify(signature: sign, message: result.bytes, publicKey: wallet.publicKey.raw.bytes)
            print(testResult)
            print(sign.toHexString())
        } catch {
            print(error.localizedDescription)
        }
        //3130 2e9829f376318154bff603ebc8e0b743 00e40b5402000000 404024244c494252415f41545445535424244040
        //0a783a439b523f2545d3a71622c9e74b3800e40b540200000014404024244c494252415f4154544553542424404000206865d4cb3f7f71986f60ff3ecc7653c7408844f7ef30c9f9711c89a46df6cf60404a873e9cc638e55e69d09094476b965dda1fc6cb5c382aa183855dff4a3e95d8d571da1d53067456b99c658761f8ca2b4230ef994610836c7cabff32e0438204
    }
    func testDiemLargeTransferSetDualA() {
//        let mnemonic = ["display", "paddle", "crush", "crowd", "often", "friend", "topple", "agent", "entry", "use", "host", "begin"]
        //2e797751e6ae643d129a854f8c739b72 783a439b523f2545d3a71622c9e74b38
        let mnemonic = ["wrist", "post", "hover", "mixed", "like", "update", "salute", "access", "venture", "grant", "another", "team"]
        //b90148b7d177538c2f91c9a13d695506 f41799563e5381b693d0885b56ebf19b
//        let mnemonic = ["trouble", "menu", "nephew", "group", "alert", "recipe", "hotel", "fatigue", "wet", "shadow", "say", "fold", "huge", "olive", "solution", "enjoy", "garden", "appear", "vague", "joy", "great", "keep", "cactus", "melt"]

        do {
            let seed = try DiemMnemonic.seed(mnemonic: mnemonic)
            let wallet = try DiemHDWallet.init(seed: seed, depth: 0, network: .testnet)
            let walletAddress = wallet.publicKey.toLegacy()
            let active = wallet.publicKey.toAuthKeyPrefix()
            print(walletAddress, active)
            let argument0 = DiemTransactionArgument.init(code: .U8Vector("www.google.com".data(using: .utf8)!))
            let argument1 = DiemTransactionArgument.init(code: .U8Vector(wallet.publicKey.raw))
            let script = DiemTransactionScriptPayload.init(code: Data.init(hex: DiemUtils.getMoveCode(name: "rotate_dual_attestation_info")),
                                                             typeTags: [DiemTypeTag](),
                                                             argruments: [argument0, argument1])
            let transactionPayload = DiemTransactionPayload.init(payload: .script(script))
            
            let rawTransaction = DiemRawTransaction.init(senderAddres: wallet.publicKey.toLegacy(),
                                                           sequenceNumber: 1,
                                                           maxGasAmount: 1000000,
                                                           gasUnitPrice: 0,
                                                           expirationTime: NSDecimalNumber.init(value: Date().timeIntervalSince1970 + 600).uint64Value,
                                                           payload: transactionPayload,
                                                           module: "Coin1",
                                                           chainID: 2)
            let signature = wallet.buildTransaction(transaction: rawTransaction)
            print(signature.toHexString())
        } catch {
            print(error.localizedDescription)
        }
    }
    func testLibraBech32() {
        let payload = Data.init(Array<UInt8>(hex: "f72589b71ff4f8d139674a3f7369c69b")) + Data.init(Array<UInt8>(hex: "cf64428bdeb62af2"))
        let cashaddr: String = DiemBech32.encode(payload: payload,
                                                  prefix: "lbr",
                                                  version: 1,
                                                  separator: "1")
        print(cashaddr)
        XCTAssertEqual(cashaddr, "lbr1p7ujcndcl7nudzwt8fglhx6wxn08kgs5tm6mz4usw5p72t")
        do {
            let (prifix, hahah) = try DiemBech32.decode("lbr1p7ujcndcl7nudzwt8fglhx6wxn08kgs5tm6mz4usw5p72t",
                                                         version: 1,
                                                         separator: "1")
            XCTAssertEqual(prifix, "lbr")
            XCTAssertEqual(hahah.dropLast(8).toHexString(), "f72589b71ff4f8d139674a3f7369c69b")
        } catch {
            print(error)
            XCTFail()
        }
    }
    func testLibraKitBech32Address() {
//        let mnemonic = ["wrist", "post", "hover", "mixed", "like", "update", "salute", "access", "venture", "grant", "another", "team"]
//        do {
//            let seed = try DiemMnemonic.seed(mnemonic: mnemonic)
//            let wallet = try DiemHDWallet.init(seed: seed, depth: 0, network: .testnet)
//            let (prifix, hahah) = try DiemBech32.decode(wallet.publicKey.toQRAddress(),
//                                                          version: 1,
//                                                          separator: "1")
//            XCTAssertEqual(prifix, "lbr")
//            XCTAssertEqual(hahah.dropLast(8).toHexString(), "f41799563e5381b693d0885b56ebf19b")
//        } catch {
//            XCTFail()
//        }
    }
    func testDecode() {
        do {
            let (prifix, hahah) = try DiemBech32.decode("tlb1pgc28wuxspzzmvghzen74dczc87uepu64p2md5eqvg6tux",
                                                          version: 1,
                                                          separator: "1")
//            XCTAssertEqual(prifix, "tlb")
            print(hahah.toHexString())
            XCTAssertEqual(hahah.dropLast(8).toHexString(), "46147770d00885b622e2ccfd56e0583f")
            //46147770d00885b622e2ccfd56e0583f
            //fbcb5fa38090e834
        } catch {
            XCTFail()
        }
    }
    func testMetaDataToSubAddress() {
        let fromSubAddress = ""
        let toSubAddress = "8f8b82153010a1bd"
        let referencedEvent = ""
        let metadataV0 = DiemGeneralMetadataV0.init(to_subaddress: toSubAddress,
                                                     from_subaddress: fromSubAddress,
                                                     referenced_event: referencedEvent)
        let metadata = DiemMetadata.init(code: DiemMetadataTypes.GeneralMetadata(DiemGeneralMetadata.init(code: .GeneralMetadataVersion0(metadataV0))))
        let tempMetadata = metadata.serialize().toHexString()
        print(tempMetadata)
        
        XCTAssertEqual(tempMetadata, "010001088f8b82153010a1bd0000")
    }
    func testMetaDataFromSubAddress() {
        let fromSubAddress = "8f8b82153010a1bd"
        let toSubAddress = ""
        let referencedEvent = ""
        let metadataV0 = DiemGeneralMetadataV0.init(to_subaddress: toSubAddress,
                                                     from_subaddress: fromSubAddress,
                                                     referenced_event: referencedEvent)
        let metadata = DiemMetadata.init(code: DiemMetadataTypes.GeneralMetadata(DiemGeneralMetadata.init(code: .GeneralMetadataVersion0(metadataV0))))
        let tempMetadata = metadata.serialize().toHexString()
        print(tempMetadata)
        
        XCTAssertEqual(tempMetadata, "01000001088f8b82153010a1bd00")
    }
    func testUnstructuredBytesMetadata() {
        let unstruct = DiemUnstructuredBytesMetadata.init(code: "abcd".data(using: .utf8)!)
        let metadata = DiemMetadata.init(code: DiemMetadataTypes.UnstructuredBytesMetadata(unstruct))
        
        print(metadata.serialize().toHexString())
        XCTAssertEqual(metadata.serialize().toHexString(), "03010461626364")
    }
    func testRefundMetadata() {
        let refund = DiemRefundMetadata.init(code: .RefundMetadataV0(DiemRefundMetadataV0.init(transaction_version: 12343,
                                                                                               reason: .UserInitiatedFullRefund)))
        let metadata = DiemMetadata.init(code: DiemMetadataTypes.RefundMetadata(refund))
        
        print(metadata.serialize().toHexString())
        XCTAssertEqual(metadata.serialize().toHexString(), "0400373000000000000003")
    }
    func testCoinTradeMetadata() {
        let coinTrade = DiemCoinTradeMetadata.init(code: DiemCoinTradeMetadataTypes.CoinTradeMetadataV0(DiemCoinTradeMetadataV0.init(trade_ids: ["abc", "efg"])))
        let metadata = DiemMetadata.init(code: DiemMetadataTypes.CoinTradeMetadata(coinTrade))
        
        print(metadata.serialize().toHexString())
        XCTAssertEqual(metadata.serialize().toHexString(), "0500020361626303656667")
    }
    func testMetaDataFromToSubAddress() {
        let fromSubAddress = "8f8b82153010a1bd"
        let toSubAddress = "111111153010a111"
        let referencedEvent = ""
        let metadataV0 = DiemGeneralMetadataV0.init(to_subaddress: toSubAddress,
                                                     from_subaddress: fromSubAddress,
                                                     referenced_event: referencedEvent)
        let metadata = DiemMetadata.init(code: DiemMetadataTypes.GeneralMetadata(DiemGeneralMetadata.init(code: .GeneralMetadataVersion0(metadataV0))))
        let tempMetadata = metadata.serialize().toHexString()
        print(tempMetadata)
        //010001088f8b82153010a1bd0108111111153010a11100
        //01000108111111153010a11101088f8b82153010a1bd00
        XCTAssertEqual(tempMetadata, "01000108111111153010a11101088f8b82153010a1bd00")
    }
    func testMetaDataReferencedEvent() {
        // 测试退款
        let fromSubAddress = "8f8b82153010a1bd"
        let toSubAddress = "111111153010a111"
        let referencedEvent = "324"
        let metadataV0 = DiemGeneralMetadataV0.init(to_subaddress: fromSubAddress,
                                                     from_subaddress: toSubAddress,
                                                     referenced_event: referencedEvent)
        let metadata = DiemMetadata.init(code: DiemMetadataTypes.GeneralMetadata(DiemGeneralMetadata.init(code: .GeneralMetadataVersion0(metadataV0))))
        let tempMetadata = metadata.serialize().toHexString()
        print(tempMetadata)
        
        //010001088f8b82153010a1bd0108111111153010a111014401000000000000
        //010001088f8b82153010a1bd0108111111153010a111014401000000000000
        XCTAssertEqual(tempMetadata, "010001088f8b82153010a1bd0108111111153010a111014401000000000000")
    }
    func testMetaTravelRuleMetadata() {
        let address = "f72589b71ff4f8d139674a3f7369c69b"
        let referenceID = "off chain reference id"
        let amount: UInt64 = 1000
        let TravelRuleMetadataV0 = DiemTravelRuleMetadataV0.init(off_chain_reference_id: referenceID)
        let metadata = DiemMetadata.init(code: DiemMetadataTypes.TravelRuleMetadata(DiemTravelRuleMetadata.init(code: .TravelRuleMetadataVersion0(TravelRuleMetadataV0))))
        let tempMetadata = metadata.serialize()
        print(tempMetadata.toHexString())
        XCTAssertEqual(tempMetadata.toHexString(), "020001166f666620636861696e207265666572656e6365206964")
        let amountData = DiemUtils.getLengthData(length: NSDecimalNumber.init(value: amount).uint64Value, appendBytesCount: 8)
        let sigMessage = tempMetadata + Data.init(Array<UInt8>(hex: address)) + amountData + "@@$$LIBRA_ATTEST$$@@".data(using: .utf8)!
        print(sigMessage.toHexString())
        XCTAssertEqual(sigMessage.toHexString(), "020001166f666620636861696e207265666572656e6365206964f72589b71ff4f8d139674a3f7369c69be803000000000000404024244c494252415f41545445535424244040")
    }
    func testLibraNCToCTransaction() {
        let mnemonic = ["wrist", "post", "hover", "mixed", "like", "update", "salute", "access", "venture", "grant", "another", "team"]
        do {
            let seed = try DiemMnemonic.seed(mnemonic: mnemonic)
            let wallet = try DiemHDWallet.init(seed: seed, depth: 0, network: .testnet)
            let walletAddress = wallet.publicKey.toLegacy()
            // 拼接交易
            let argument0 = DiemTransactionArgument.init(code: .Address("46147770d00885b622e2ccfd56e0583f"))
            let argument1 = DiemTransactionArgument.init(code: .U64(11000000))
            
            let fromSubAddress = ""
            let toSubAddress = "b990f3550ab6da64"
            let referencedEvent = ""
            let metadataV0 = DiemGeneralMetadataV0.init(to_subaddress: toSubAddress,
                                                         from_subaddress: fromSubAddress,
                                                         referenced_event: referencedEvent)
            let metadata = DiemMetadata.init(code: DiemMetadataTypes.GeneralMetadata(DiemGeneralMetadata.init(code: .GeneralMetadataVersion0(metadataV0))))
            // metadata
            let argument2 = DiemTransactionArgument.init(code: .U8Vector(metadata.serialize()))
            // metadata_signature
            let argument3 = DiemTransactionArgument.init(code: .U8Vector(Data()))
            let script = DiemTransactionScriptPayload.init(code: Data.init(hex: DiemUtils.getMoveCode(name: "peer_to_peer_with_metadata")),
                                                            typeTags: [DiemTypeTag.init(typeTag: .Struct(DiemStructTag.init(type: .Normal("Coin1"))))],
                                                            argruments: [argument0, argument1, argument2, argument3])
            let transactionPayload = DiemTransactionPayload.init(payload: .script(script))
            let rawTransaction = DiemRawTransaction.init(senderAddres: walletAddress,
                                                          sequenceNumber: 7,
                                                          maxGasAmount: 1000000,
                                                          gasUnitPrice: 10,
                                                          expirationTime: UInt64(Date().timeIntervalSince1970 + 600),
                                                          payload: transactionPayload,
                                                          module: "Coin1",
                                                          chainID: 2)
            let signature = wallet.buildTransaction(transaction: rawTransaction)
            print(signature.toHexString())
        } catch {
            
        }
    }
    
    func testCropty() {
//        let time = UInt64(Date().timeIntervalSince1970 + 600)
//        do {
//            let a = try getNumberDataV2(number: BigUInt(time), length: 8)
//            print(a.toHexString())
//        } catch {
//            print(error.localizedDescription)
//        }
//        let aaa = Date().timeIntervalSince1970
//        let b = DiemUtils.getLengthData(length: time, appendBytesCount: 8)
//        let bbb = Date().timeIntervalSince1970
//        print("老版\(bbb - aaa)")
//        print(b.toHexString())
        let tea = Tea.init(identity: "123456wf",
                           kind: 0,
                           manufacturer: "MountWuyi",
                           date: 0).serialize()
        print(tea.toHexString())
        let cryptoData = tea.sha3(SHA3.Variant.sha256)
        print(cryptoData.toHexString())
        XCTAssertEqual(cryptoData.toHexString(), "f63c301d559ccf8fd63fedd98516c96b57d465ca901c2b714f19071e5afc5d03")
    }
    func getNumberDataV2(number: BigUInt, length: Int) throws -> Data {
        let numberData = number.serialize()
        guard numberData.count <= length else {
            throw DiemKitError.error("data too big")
        }
        var newData = Data.init(count: length - numberData.count)
        // 追加原始数据
        newData.append(numberData)
        // 倒序输出
        return Data.init(bytes: newData.bytes.reversed(), count: newData.bytes.count)
    }
    func testOrigin() {
        let a = Data.init(hex: "b4150d1f010000000000000000000000000000000105526f6c657306526f6c654964000806000000000000002101000000000000000000000000000000010456415350094368696c64564153500010585c6aa31dfb19c4af20e8e14112cb3f2201000000000000000000000000000000010845786368616e676506546f6b656e73001101010000000000000080969800000000002401000000000000000000000000000000010a56696f6c617342616e6b06546f6b656e7300850e20000000000000000000000000000000000100000000000000000000000000000002000000000000000000000000000000030000000000000000000000000000000400000000000000000000000000000005000000000000000000000000000000060000000000000000000000000000000700000000000000000000000000000008000000000000000000000000000000090000000000000000000000000000000a0000000000000000000000000000000b0000000000000000000000000000000c0000000000000000000000000000000d0000000000000000000000000000000e0000000000000000000000000000000f000000000000000000000000000000100000000000000000000000000000001100000000000000000000000000000012000000000000000000000000000000130000000000000000000000000000001400000000000000000000000000000015000000000000000000000000000000160000000000000000000000000000001700000000000000000000000000000018000000000000000000000000000000190000000000000000000000000000001a0000000000000000000000000000001b0000000000000000000000000000001c0000000000000000000000000000001d0000000000000000000000000000001e0000000000000000000000000000001f00000000000000000000000000000020000000000000000000000000010000000000000000000000000000000100000000000000000000000000000001000000000000000000000000000000010000000000000000000000000000000100000000000000000000000000000001000000000000000000000000000000010000000000000000000000000000000100000000000000000000000000000001000000000000000000000000000000010000000000000000000000000000000100000000000000000000000000000001000000000000000000000000000000010000000000000000000000000000000100000000000000000000000000000001000000000000000000000000000000010000000000000000000000000000000100000000000000000000000000000001000000000000000000000000000000010000000000000000000000000000000100000000000000000000000000000001000000000000000000000000000000010000000000000000000000000000000100000000000000000000000000000001000000000000000000000000000000010000000000000000000000000000000100000000000000000000000000000001000000000000000000000000000000010000000000000000000000000000000100000000000000000000000000000001000000000000000000000000000000010000000000000000000000000000000100000020285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f0200000000285c8f020000000020000000000100000000000000010000000bbbc404a3000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000002000000000010000000000000001000000aa5aa186449e0000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000000000000001000000000000000100000000000000010000002601000000000000000000000000000000010a56696f6c617342616e6b0855736572496e666f002602000000000000001802000000000000006c1dd50f35f120061babc2814cf9378b01000000002901000000000000000000000000000000010845786368616e67650d506f6f6c55736572496e666f730019010100000000000000809698000000000000000000000000002a01000000000000000000000000000000010b4469656d4163636f756e740b4469656d4163636f756e74008d0120bcb750f64f7ed8292e5fc284debfa1996c1dd50f35f120061babc2814cf9378b016c1dd50f35f120061babc2814cf9378b016c1dd50f35f120061babc2814cf9378b06000000000000001800000000000000006c1dd50f35f120061babc2814cf9378b09000000000000001801000000000000006c1dd50f35f120061babc2814cf9378b0c000000000000002d0100000000000000000000000000000001054576656e74144576656e7448616e646c6547656e657261746f72001803000000000000006c1dd50f35f120061babc2814cf9378b2e01000000000000000000000000000000010f4163636f756e74467265657a696e670b467265657a696e674269740001004001000000000000000000000000000000010b4469656d4163636f756e740742616c616e636501070000000000000000000000000000000103564c5303564c530008fd5f0100000000004201000000000000000000000000000000010b4469656d4163636f756e740742616c616e6365010700000000000000000000000000000001045642544304564254430008c07af204000000004401000000000000000000000000000000010b4469656d4163636f756e740742616c616e63650107000000000000000000000000000000010556555344540556555344540008ea6a7a05000000004401000000000000000000000000000000010b4469656d4163636f756e740742616c616e6365010700000000000000000000000000000001055657425443055657425443000800e1f50500000000")
        let loadedObject = Data.init(hex: "b4150d1f010")
        print(String.init(data: a, encoding: .utf8))
        let bb = DiemUtils.uleb128FormatToInt(data: Data.init(hex: "b415"))
        print(bb)
    }
}
