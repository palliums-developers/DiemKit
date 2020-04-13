//
//  LibraKitTests.swift
//  LibraKitTests
//
//  Created by palliums on 2019/9/19.
//  Copyright © 2019 palliums. All rights reserved.
//

import XCTest
@testable import LibraKit

class LibraKitTests: XCTestCase {

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
    func testLibra() {
        //LibraTransactionArgument
        // u64
        let amount = LibraTransactionArgument.init(code: .U64, value: "9213671392124193148").serialize().toHexString().uppercased()
        XCTAssertEqual(amount, "007CC9BDA45089DD7F")
        // Address
        let address = LibraTransactionArgument.init(code: .Address, value: "bafc671e8a38c05706f83b5159bbd8a4").serialize().toHexString()
        XCTAssertEqual(address  , "01bafc671e8a38c05706f83b5159bbd8a4")
        // U8Vector
        let u8vector = LibraTransactionArgument.init(code: .U8Vector, value: "CAFED00D").serialize().toHexString().uppercased()
        XCTAssertEqual(u8vector, "0204CAFED00D")
        // Bool
        let bool1 = LibraTransactionArgument.init(code: .Bool, value: "00").serialize().toHexString().uppercased()
        XCTAssertEqual(bool1, "0300")
        // Bool
        let bool2 = LibraTransactionArgument.init(code: .Bool, value: "01").serialize().toHexString().uppercased()
        XCTAssertEqual(bool2, "0301")
        //LibraTransactionAccessPath
        let accessPath1 = LibraTransactionAccessPath.init(address: "a71d76faa2d2d5c3224ec3d41deb293973564a791e55c6782ba76c2bf0495f9a",
                                                          path: "01217da6c6b3e19f1825cfb2676daecce3bf3de03cf26647c78df00b371b25cc97",
                                                          writeType: LibraTransactionWriteType.Deletion)
        let accessPath2 = LibraTransactionAccessPath.init(address: "c4c63f80c74b11263e421ebf8486a4e398d0dbc09fa7d4f62ccdb309f3aea81f",
                                                          path: "01217da6c6b3e19f18",
                                                          writeType: LibraTransactionWriteType.Value,
                                                          value: Data.init(Array<UInt8>(hex: "CAFED00D")))
        let write = LibraTransactionWriteSet.init(accessPaths: [accessPath1, accessPath2]).serialize().toHexString().uppercased()
        XCTAssertEqual(write, "0102A71D76FAA2D2D5C3224EC3D41DEB293973564A791E55C6782BA76C2BF0495F9A2101217DA6C6B3E19F1825CFB2676DAECCE3BF3DE03CF26647C78DF00B371B25CC9700C4C63F80C74B11263E421EBF8486A4E398D0DBC09FA7D4F62CCDB309F3AEA81F0901217DA6C6B3E19F180104CAFED00D")
        let module = LibraTransactionModule.init(code: Data.init(Array<UInt8>(hex: "CAFED00D"))).serialize().toHexString().uppercased()
        XCTAssertEqual(module, "03CAFED00D")
        
//        let string1 = TransactionArgument.init(code: .String, value: "CAFE D00D")
//        let string2 = TransactionArgument.init(code: .String, value: "cafe d00d")
//        let program = TransactionProgram.init(code: "move".data(using: String.Encoding.utf8)!, argruments: [string1, string2], modules: [Data.init(hex: "CA"), Data.init(hex: "FED0"), Data.init(hex: "0D")]).serialize().toHexString().uppercased()
//        XCTAssertEqual(program, "00000000040000006D6F766502000000020000000900000043414645204430304402000000090000006361666520643030640300000001000000CA02000000FED0010000000D")

//        let string3 = TransactionArgument.init(code: .Address, value: "4fddcee027aa66e4e144d44dd218a345fb5af505284cb03368b7739e92dd6b3c")
//        let string4 = TransactionArgument.init(code: .U64, value: "\(9 * 1000000)")
//        let program2 = TransactionProgram.init(code: getProgramCode(), argruments: [string3, string4], modules: []).serialize()
//
//        let raw = RawTransaction.init(senderAddres: "65e39e2e6b90ac215ec79e2b84690421d7286e6684b0e8e08a0b25dec640d849",
//                                      sequenceNumber: 0,
//                                      maxGasAmount: 140000,
//                                      gasUnitPrice: 0,
//                                      expirationTime: 0,
//                                      programOrWrite: program2)
//        XCTAssertEqual(raw.serialize().toHexString(), "2000000065e39e2e6b90ac215ec79e2b84690421d7286e6684b0e8e08a0b25dec640d849000000000000000000000000b80000004c49425241564d0a010007014a00000004000000034e000000060000000d54000000060000000e5a0000000600000005600000002900000004890000002000000008a90000000f00000000000001000200010300020002040200030204020300063c53454c463e0c4c696272614163636f756e74046d61696e0f7061795f66726f6d5f73656e6465720000000000000000000000000000000000000000000000000000000000000000000100020004000c000c01130101020200000001000000200000004fddcee027aa66e4e144d44dd218a345fb5af505284cb03368b7739e92dd6b3c00000000405489000000000000000000e02202000000000000000000000000000000000000000000")
//
//        //有钱助词
//        let mnemonic = ["net", "dice", "divide", "amount", "stamp", "flock", "brave", "nuclear", "fox", "aim", "father", "apology"]
//        let seed = try! LibraMnemonic.seed(mnemonic: mnemonic)
//        let wallet = try! LibraWallet.init(seed: seed)
//        _ = try! wallet.privateKey.signTransaction(transaction: raw, wallet: wallet)

    }

    func testMultiAddress() {
        let wallet = LibraMultiHDWallet.init(privateKeys: [LibraMultiPrivateKeyModel.init(raw: Data.init(Array<UInt8>(hex: "f3cdd2183629867d6cfa24fb11c58ad515d5a4af014e96c00bb6ba13d3e5f80e")),
                                                                                     sequence: 1),
                                                           LibraMultiPrivateKeyModel.init(raw: Data.init(Array<UInt8>(hex: "c973d737cb40bcaf63a45a9736d7d7735e78148a06be185327304d6825e666ea")),
                                                           sequence: 2)],
                                             threshold: 1)
        XCTAssertEqual(wallet.publicKey.toLegacy(), "cd35f1a78093554f5dc9c61301f204e4")
    }
    func testLibraKit() {
        let mnemonic1 = ["display", "paddle", "crush", "crowd", "often", "friend", "topple", "agent", "entry", "use", "begin", "host"]
        let mnemonic2 = ["grant", "security", "cluster", "pill", "visit", "wave", "skull", "chase", "vibrant", "embrace", "bronze", "tip"]
        let mnemonic3 = ["net", "dice", "divide", "amount", "stamp", "flock", "brave", "nuclear", "fox", "aim", "father", "apology"]
        do {
            let seed1 = try LibraMnemonic.seed(mnemonic: mnemonic1)
            let seed2 = try LibraMnemonic.seed(mnemonic: mnemonic2)
            let seed3 = try LibraMnemonic.seed(mnemonic: mnemonic3)
            let seedModel1 = LibraSeedAndDepth.init(seed: seed1, depth: 0, sequence: 0)
            let seedModel2 = LibraSeedAndDepth.init(seed: seed2, depth: 0, sequence: 1)
            let seedModel3 = LibraSeedAndDepth.init(seed: seed3, depth: 0, sequence: 2)
            let wallet = try LibraMultiHDWallet.init(models: [seedModel1, seedModel2, seedModel3], threshold: 2)
            print("Legacy = \(wallet.publicKey.toLegacy())")
            print("Authentionkey = \(wallet.publicKey.toActive())")
        } catch {
            print(error.localizedDescription)
        }
    }

}
