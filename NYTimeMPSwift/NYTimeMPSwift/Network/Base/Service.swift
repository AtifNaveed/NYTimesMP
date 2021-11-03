//
//  Service.swift
//  NYTimeMPSwift
//
//  Created by Atif on 03/11/2021.
//  Copyright © 2021 Atif. All rights reserved.
//

import UIKit
import Alamofire

enum ServiceResponse {
    case success(response: JsonDictionay)
    case failure
    case notConnectedToInternet
}
enum ResponseStatusCode: Int {
    case success = 200
}
class Service {
    var dataRequestArray: [DataRequest] = []
    var sessionManager: [String : Alamofire.Session] = [:]
    func callEndPoint(endPoint: APIEndPoint, period: Int, method: Alamofire.HTTPMethod = .get, headers: HTTPHeaders? = [:], params: JsonDictionay? = [:], completion: @escaping (ServiceResponse) -> Void){
        let url = APIConstants.baseUrl + endPoint.rawValue + APIConstants.apiVersion + APIConstants.subDomain + APIConstants.section + "/\(period)" + APIConstants.urlExtension + APIConstants.keyPath + APIConstants.apiKey
        switch method {
        case .post:
                _ = AF.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).responseString { (response) in
                self.serializeResponse(response: response, completion: completion)
                self.sessionManager.removeValue(forKey: url)
            }
        default:
                _ = AF.request(url, method: method, parameters: params, headers: headers).responseString { (response) in
                self.serializeResponse(response: response, completion: completion)
                self.sessionManager.removeValue(forKey: url)
            }
        }
    }
    func serializeResponse(response: Alamofire.DataResponse<String, AFError>,  completion: @escaping (ServiceResponse) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let strongSelf = self else { return }
            var json: Any?
            guard let urlResponse = response.response else {
                if let error = response.error as NSError?, error.code == NSURLErrorNotConnectedToInternet {
                    strongSelf.notConnectedToInternet(completion: completion)
                } else {
                    strongSelf.failure(completion: completion)
                }
                return
            }
            if let data = (response.value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                do {
                    json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:AnyObject]
                } catch {
                    strongSelf.failure(completion: completion)
                    return
                }
            }
            guard let jsonResponse = json as? JsonDictionay else {
                strongSelf.failure(completion: completion)
                return
            }
            if jsonResponse["success"] as? Bool == false {
                strongSelf.failure(completion: completion)
                return
            }
            strongSelf.success(result:jsonResponse , headers: urlResponse.allHeaderFields, completion: completion)
        }
    }
    func cancelAllRequests () {
        for dataRequest in self.dataRequestArray {
            dataRequest.cancel()
        }
        self.dataRequestArray.removeAll()
    }
    func notConnectedToInternet (completion:@escaping (ServiceResponse) -> Void) {
        completion(.notConnectedToInternet)
    }
    func failure (completion:@escaping (ServiceResponse) -> Void) {
        completion(.failure)
    }
    func success (result: JsonDictionay?, headers: [AnyHashable: Any], completion:@escaping (ServiceResponse) -> Void) {
        completion(.success(response: result ?? [:]))
    }
}
