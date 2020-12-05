//
//  NetManager.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/28.
//

import Foundation
import Moya
import SwiftyJSON

// 超时时长
private var requestTimeout = 30.0

struct Network {
    static let provider = MoyaProvider<API>()
    
    static func request(_ target: API, success: @escaping (JSON) -> Void, failure: @escaping (String) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case let .success(res):
                if let json = try? JSON(data: res.data) {
                    let resModel = RespondModel(jsonData: json)
                    guard let code = resModel.code, let msg = resModel.msg else {
                        failure("数据解析错误")
                        return
                    }
                    // 代表成功
                    if code == "0" {
                        success(json["data"])
                    } else {
                        failure(msg)
                    }
                } else {
                    failure("数据解析错误")
                }
            case let .failure(error):
                failure(error.errorDescription!)
            }
        }
    }
    
    static func cancelAllRequest() {
        provider.manager.session.getAllTasks { (tasks) in
            tasks.forEach {
                print("取消网络请求")
                $0.cancel()
            }
        }
    }
}
