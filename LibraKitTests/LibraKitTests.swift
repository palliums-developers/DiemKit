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
    func testMultiAddress() {
        let wallet = LibraMultiHDWallet.init(privateKeys: ["f3cdd2183629867d6cfa24fb11c58ad515d5a4af014e96c00bb6ba13d3e5f80e", "c973d737cb40bcaf63a45a9736d7d7735e78148a06be185327304d6825e666ea"], threshold: 1)
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
            let seedModel1 = SeedAndDepth.init(seed: seed1, depth: 0)
            let seedModel2 = SeedAndDepth.init(seed: seed2, depth: 0)
            let seedModel3 = SeedAndDepth.init(seed: seed3, depth: 0)
            let wallet = try LibraMultiHDWallet.init(models: [seedModel1, seedModel2, seedModel3], threshold: 2)
            print("Legacy = \(wallet.publicKey.toLegacy())")
            print("Authentionkey = \(wallet.publicKey.toActive())")
        } catch {
            print(error.localizedDescription)
        }
    }

}
