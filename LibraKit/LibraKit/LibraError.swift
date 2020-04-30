//
//  LibraError.swift
//  LibraWallet
//
//  Created by palliums on 2019/9/5.
//  Copyright © 2019 palliums. All rights reserved.
//

import UIKit
public enum LibraKitError: Error {
    case error(String)
}
extension LibraKitError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error(let string):
            return "\(string)"
        }
    }
}
struct LibraError {

}
