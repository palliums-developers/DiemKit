//
//  DiemTransactionScriptFunctionPayload.swift
//  DiemKit
//
//  Created by Palliums on 2021/11/30.
//  Copyright © 2021 palliums. All rights reserved.
//

import UIKit

struct DiemTransactionScriptFunctionPayload {
    fileprivate let module: DiemModuleId
    
    fileprivate let function: String
        
    fileprivate let typeTags: [DiemTypeTag]
    
    fileprivate let argruments: [Data]

    init(module: DiemModuleId, function: String, typeTags: [DiemTypeTag], argruments: [Data]) {
        self.module = module
        self.function = function
        self.typeTags = typeTags
        self.argruments = argruments
    }
    func serialize() -> Data {
        var result = Data()
        // module
        result.append(self.module.serialize())
        // function
        let functionData = function.data(using: String.Encoding.utf8)!
        result += DiemUtils.uleb128Format(length: functionData.bytes.count)
        result += functionData
        // typeTags
        result += DiemUtils.uleb128Format(length: typeTags.count)
        for typeTag in typeTags {
            result.append(typeTag.serialize())
        }
        // argruments
        result += DiemUtils.uleb128Format(length: argruments.count)
        for argrument in argruments {
            result += DiemUtils.uleb128Format(length: argrument.bytes.count)
            result.append(argrument)
        }
        return result
    }
}
