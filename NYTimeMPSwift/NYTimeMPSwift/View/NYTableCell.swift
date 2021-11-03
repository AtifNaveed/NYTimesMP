//
//  NYTableCell.swift
//  NYTimeMPSwift
//
//  Created by Atif on 03/11/2021.
//  Copyright © 2021 Atif. All rights reserved.
//

import UIKit

class NYTableCell: UITableViewCell {
    @IBOutlet weak var lblNewsTitle: UILabel!
    @IBOutlet weak var lblNewsBy: UILabel!
    @IBOutlet weak var lblNewsDate: UILabel!
    @IBOutlet weak var imagView: UIImageView!
    func configure(whitViewModel item:NYModel?) {
        //TODO: get default values from requirement provider
        lblNewsTitle.text = item?.title ?? APIConstants.unkown_title
        lblNewsBy.text = item?.byline ?? APIConstants.unkown_author
        lblNewsDate.text = Utils.formateDate(date: item?.published_date ?? Utils.fakeDate())
        let media_array = item?.media ?? []
        if (media_array.count > 0) {
            let media = media_array[0]
            let metadata_array = media.media_metadata
            if (metadata_array.count > 0) {
                let image = metadata_array[0]
                imagView?.image(url: image.url)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


