//
//  SparkNetResponse.swift
//  SparkBase
//
//  Created by sfh on 2023/12/27.
//  Copyright © 2023 Spark. All rights reserved.
//

import UIKit
import HandyJSON

/// 返回数据结构体
public struct SparkNetResponse: HandyJSON {
    var code: Int = 0
    var results: ResponseResults?
    
    public init() {}
    
    public struct ResponseResults: HandyJSON {
        var ret: Int = 0
        var msg: String?
        var totalCount: String?
        var body: Any?
        var list: [Any]?
        
        public init() {}
    }
}
