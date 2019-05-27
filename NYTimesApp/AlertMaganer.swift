//
//  AlertMaganer.swift
//  NYTimesApp
//
//  Created by Konstantin Kalivod on 5/25/19.
//  Copyright © 2019 Kostya Kalivod. All rights reserved.
//

import Foundation
import UIKit
class Managers{
    class func addAlert() -> UIAlertController {
        
        let ac = UIAlertController(title: "Success", message: "article added to favorites", preferredStyle: .alert)
        //First alert controller action cancel
        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        ac.addAction(cancel)

        return ac
    }
    class func segueDetail(segue: UIStoryboardSegue, indexPath: Int, list: [Article] ){
            let myResultArray = list[indexPath]
            let dvc = segue.destination as! DetailViewController
            dvc.titleText = myResultArray.title
            dvc.abstract = myResultArray.abstract
            dvc.date = myResultArray.published_date
            dvc.imageURL = myResultArray.urlImage
            dvc.url = myResultArray.url
            
        }
    }

