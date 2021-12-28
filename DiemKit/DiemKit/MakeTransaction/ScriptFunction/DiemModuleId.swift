//
//  DiemModuleId.swift
//  DiemKit
//
//  Created by Palliums on 2021/12/1.
//  Copyright © 2021 palliums. All rights reserved.
//

import UIKit

struct DiemModuleId {
    var address: String
        
    var name: String
        
    init(address: String, name: String) {
        self.address = address
                
        self.name = name
    }
    func serialize() -> Data {
        var result = Data()
        // 追加Address
        result += Data.init(Array<UInt8>(hex: self.address))
        // 追加Name
        let nameData = name.data(using: String.Encoding.utf8)!
        result += DiemUtils.uleb128Format(length: nameData.bytes.count)
        result += nameData
        return result
    }
}
