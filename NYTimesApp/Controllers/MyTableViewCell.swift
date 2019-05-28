//
//  MyTableViewCell.swift
//  NYTimesApp
//
//  Created by Konstantin Kalivod on 5/28/19.
//  Copyright © 2019 Kostya Kalivod. All rights reserved.
//

import UIKit
import Kingfisher

class MyTableViewCell: UITableViewCell {
    var titleText : String?
    var abstract : String?
    var date : String?
    var url : String?
    var imageURL : String?
    // MARK: - IBOutlets
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abstarctLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        thumbnailImageView.layer.cornerRadius = 32.5
//        thumbnailImageView.clipsToBounds = true
        titleLabel.text = titleText
        abstarctLabel.text = abstract
        dateLabel.text = date
        let resorce = ImageResource(downloadURL: URL(string: imageURL!)!, cacheKey: imageURL)
        thumbnailImageView.kf.setImage(with: resorce)
        // Configure the view for the selected state
    }

}
