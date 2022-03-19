//
//  Result.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/19.
//

import Foundation

class TraceError: Error {
    public let message: String
    public let code: String
    
    public init(message: String = "", code: String = "") {
        self.message = message
        self.code = code
    }
}
