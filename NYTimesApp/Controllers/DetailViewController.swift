//
//  DetailViewController.swift
//  NYTimesApp
//
//  Created by Konstantin Kalivod on 5/24/19.
//  Copyright © 2019 Kostya Kalivod. All rights reserved.
//

import UIKit
import Kingfisher
import SafariServices
class DetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abstarctLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    // MARK: - Variables
    var titleText : String?
    var abstract : String?
    var date : String?
    var url : String?
    var imageURL : String?
    
    @IBAction func PressButtonRead(_ sender: Any) {
        if let url = URL(string: url!){
            let svc = SFSafariViewController(url: url)
            present(svc, animated: true, completion: nil)
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        readButton.layer.cornerRadius = 5
        readButton.clipsToBounds = true
        titleLabel.text = titleText
        abstarctLabel.text = abstract
        dateLabel.text = date
        let resorce = ImageResource(downloadURL: URL(string: imageURL!)!, cacheKey: imageURL)
        thumbnailImageView.kf.setImage(with: resorce)
        
    }
    

}
