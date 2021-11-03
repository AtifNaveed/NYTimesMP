//
//  UITableViewCell.swift
//  NYTimeMPSwift
//
//  Created by Atif on 03/11/2021.
//  Copyright © 2021 Atif. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static func registerCellXib(with tableview: UITableView){
        let nib = UINib(nibName: "\(self)", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "\(self)")
    }
}
