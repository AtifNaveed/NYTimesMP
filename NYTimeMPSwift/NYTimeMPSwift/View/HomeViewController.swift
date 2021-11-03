//
//  HomeViewController.swift
//  NYTimeMPSwift
//
//  Created by Atif on 03/11/2021.
//  Copyright © 2021 Atif. All rights reserved.
//

import UIKit
import SwiftyProgressHud

class HomeViewController: UIViewController, ViewModelDelegate {
    var hud: SwiftyProgressHud!
    @IBOutlet weak var tableView: UITableView!
    var viewModel = NYViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup() {
        NYTableCell.registerCellXib(with: tableView)
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
        hud = SwiftyProgressHud()
        hud.show(view: self.view)
        viewModel.getNews(period: 7)
    }
    func reloadTable() {
        DispatchQueue.main.sync {
            self.tableView.reloadData()
            hud.hide()
        }
    }
}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.item.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NYTableCell.stringFromClass) as! NYTableCell
        cell.configure(whitViewModel: viewModel.item[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = appDelegate().storyboard().instantiateViewController(withIdentifier: DetailViewController.stringFromClass) as? DetailViewController else { return }
        vc.item = viewModel.item[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
