//
//  ViewedTableViewCell.swift
//  NYTimesApp
//
//  Created by Konstantin Kalivod on 5/23/19.
//  Copyright © 2019 Kostya Kalivod. All rights reserved.
//

import UIKit

class ViewedTableViewCell: UITableViewCell {
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

        // Configure the view for the selected state
    }

}
