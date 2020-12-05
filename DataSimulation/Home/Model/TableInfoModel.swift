//
//  TableInfoModel.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/29.
//

import Foundation
import SwiftyJSON

struct TableInfoModel {
    var tid: String?
    var name: String?
    var titleList: [String]?
    
    init(jsonData: JSON) {
        tid = jsonData["tid"].stringValue
        name = jsonData["name"].stringValue
        titleList = jsonData["titleList"].arrayValue.map({(json) -> String in
            return json.stringValue
        })
    }
}

struct TableDetailModel {
    var tid: String?
    var did: String?
    var dataList: [String]?
    
    init(jsonData: JSON) {
        tid = jsonData["tid"].stringValue
        did = jsonData["did"].stringValue
        dataList = jsonData["dataList"].arrayValue.map({(json) -> String in
            return json.stringValue
        })
    }
}
