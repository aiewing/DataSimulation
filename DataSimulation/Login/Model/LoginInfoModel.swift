//
//  LoginInfoModel.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/29.
//

import Foundation
import SwiftyJSON

struct LoginInfoModel {
    var uid: String?
    var name: String?
    var session: String?
    
    init(jsonData: JSON) {
        uid = jsonData["uid"].stringValue
        name = jsonData["name"].stringValue
        session = jsonData["session"].stringValue
    }
}
