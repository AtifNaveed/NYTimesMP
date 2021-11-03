//
//  DetailViewController.swift
//  NYTimeMPSwift
//
//  Created by Atif on 03/11/2021.
//  Copyright © 2021 Atif. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var lblNewsTitle: UILabel!
    @IBOutlet weak var lblNewsBy: UILabel!
    @IBOutlet weak var lblNewsDate: UILabel!
    @IBOutlet weak var imagView: UIImageView!
    var item: NYModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup() {
        //TODO: get default values from requirement provider
        lblNewsTitle.text = item?.title ?? APIConstants.unkown_title
        lblNewsBy.text = item?.abstract ?? APIConstants.unkown_abst
        lblNewsDate.text = Utils.formateDate(date: item?.published_date ?? Utils.fakeDate())
        let media_array = item?.media ?? []
        if (media_array.count > 0) {
            let media = media_array[0]
            let metadata_array = media.media_metadata
            if (metadata_array.count > 0) {
                for image in metadata_array {
                    if image.format == APIConstants.image_format {
                        imagView?.image(url: image.url)
                    }
                }
            }
        }
    }
}
