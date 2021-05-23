//
//  APiClass.swift
//  TestApp
//
//  Created by ICS on 21/05/21.
//

import Foundation
import Alamofire

class APiClass {
    static func apiGetTaskList(mainUrl : String, callback:@escaping ((_ data: [UserList]?,_ error: Error?) -> Void)){
        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        AF.request(mainUrl)
            .responseDecodable(of: [UserList].self, decoder: decoder) { response in
                switch response.result {
                case let .success(result):
                    callback(result,nil)
                case let .failure(error):
                    debugPrint(error.localizedDescription)
                    callback(nil,error)
                }
            }
    }
}
