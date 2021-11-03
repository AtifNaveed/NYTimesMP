//
//  NYViewModel.swift
//  NYTimeMPSwift
//
//  Created by Atif on 03/11/2021.
//  Copyright © 2021 Atif. All rights reserved.
//

import Foundation

protocol ViewModelDelegate {
    func reloadTable()
}
class NYViewModel {
    var item = [NYModel]()
    var mpNewsAPI: MPNewsAPI?
    var delegate: ViewModelDelegate?
    init() {
        mpNewsAPI = MPNewsAPI()
    }
    func getNews(period: Int) {
        guard let api = mpNewsAPI else { return }
        api.getNews(page: 0, period: period) { [weak self](response) in
            guard let strongSelf = self else { return }
            switch response {
            case .success(let result):
                strongSelf.item = result.results
                strongSelf.delegate?.reloadTable()
            case.failure:
                break
            }
        }
    }
}

