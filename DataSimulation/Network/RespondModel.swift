//
//  RespondModel.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/29.
//

import Foundation
import SwiftyJSON

struct RespondModel {
    var code: String?
    var msg: String?
    
    init(jsonData: JSON) {
        code = jsonData["code"].stringValue
        msg = jsonData["msg"].stringValue
    }
}
