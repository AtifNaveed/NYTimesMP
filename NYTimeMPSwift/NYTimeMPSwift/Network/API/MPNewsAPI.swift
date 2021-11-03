//
//  MPNewsAPI.swift
//  NYTimeMPSwift
//
//  Created by Atif on 03/11/2021.
//  Copyright © 2021 Atif. All rights reserved.
//

import Foundation

enum  NewsAPIResponse {
    case success(result: NewsArray)
    case failure
}
class MPNewsAPI: Service {
    func getNews(page:Int, period: Int, completion: @escaping (NewsAPIResponse) -> Void ) {
        super.callEndPoint(endPoint:.getPopular, period: period) { [weak self] (response) in
            guard let strongSelf = self else { return }
            switch response {
            case .success(let result):
                strongSelf.parseResult(result: result, completion: completion)
                break
            default:
                completion(.failure)
                break
            }
        }
    }
    private func parseResult(result: JsonDictionay, completion: @escaping (NewsAPIResponse) -> Void) {
        guard let data = NewsArray(json: result) else {
            completion(.failure)
            return
        }
        completion(.success(result: data))
    }
}
