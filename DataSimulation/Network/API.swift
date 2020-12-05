//
//  API.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/28.
//

import Foundation
import Moya
import Result

enum API {
    case register(_ params: [String: Any]) // 注册
    case login(_ params: [String: Any]) // 登录
    case logout(_ params: [String: Any]) // 退出登录
    
    
    case getTableList(_ params: [String: Any]) // 获取列表
    case createNewTable(_ params: [String: Any]) // 创建新的表
    case deleteTable(_ params: [String: Any]) // 删除表
    case getTableDetail(_ params: [String: Any]) // 获取数据
    case createNewData(_ params: [String: Any]) // 添加新数据
    case deleteData(_ params: [String: Any]) // 删除数据
}

extension API: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://localhost")!
    }
    
    var path: String {
        switch self {
        case .register:
            return "login/register"
        case .login:
            return "login/login"
        case .logout:
            return "login/logout"
            
        case .getTableList:
            return "table/getTableList"
        case .createNewTable:
            return "table/createNewTable"
        case .deleteTable:
            return "table/deleteTable"
        case .getTableDetail:
            return "table/getTableDetail"
        case .createNewData:
            return "table/createNewData"
        case .deleteData:
            return "table/deleteData"
        default:
            return ""
        }
    }
    
    var task: Task {
        return .requestParameters(parameters: getParams, encoding: JSONEncoding.default)
    }
    
    // 正常接口需要加上session
    var getParams: [String: Any] {
        // 每个借口都喜欢加上session 除了登录和注册
        
        switch self {
        case let .register(dict):
            return dict
        case let .login(dict):
            return dict
        case let .logout(dict):
            return sessionParams(dict)
        case let .getTableList(dict):
            return sessionParams(dict)
        case let .createNewTable(dict):
            return sessionParams(dict)
        case let .deleteTable(dict):
            return sessionParams(dict)
        case let .getTableDetail(dict):
            return sessionParams(dict)
        case let .createNewData(dict):
            return sessionParams(dict)
        case let .deleteData(dict):
            return sessionParams(dict)
        default:
            return [:]
        }
    }
    
    // 加上固定的参数
    func sessionParams(_ params: [String: Any]) -> [String: Any] {
        let session = UserDefaults.LoginInfo.string(forKey: .session)
        return params.merging(["session": session]) {(_, new) in new}
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
