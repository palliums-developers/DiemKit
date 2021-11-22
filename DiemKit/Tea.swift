//
//  Tea.swift
//  DiemKit
//
//  Created by wangyingdong on 2021/7/8.
//  Copyright © 2021 palliums. All rights reserved.
//

import UIKit

struct Tea {
    /// 茶叶编号
    var identity: String
    /// 茶叶类型
    var kind: UInt8
    /// 茶叶产地
    var manufacturer: String
    /// 
    var date: UInt64
    
    init(identity: String, kind: UInt8, manufacturer: String, date: UInt64) {
        self.identity = identity
        
        self.kind = kind
        
        self.manufacturer = manufacturer
        
        self.date = date
    }
    func serialize() -> Data {
        var result = Data()
        //
        let identityData = self.identity.data(using: String.Encoding.utf8)!
        result += DiemUtils.uleb128Format(length: identityData.bytes.count)
        result += identityData
        //
        result += DiemUtils.getLengthData(length: NSDecimalNumber.init(value: self.kind).uint64Value, appendBytesCount: 1)
        
        let manufacturerData = self.manufacturer.data(using: String.Encoding.utf8)!
        result += DiemUtils.uleb128Format(length: manufacturerData.bytes.count)
        result += manufacturerData
        
        result += DiemUtils.getLengthData(length: NSDecimalNumber.init(value: self.date).uint64Value, appendBytesCount: 8)
        
        return result
    }
}
