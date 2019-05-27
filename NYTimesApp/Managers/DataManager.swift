//
//  DataManager.swift
//  NYTimesApp
//
//  Created by Konstantin Kalivod on 5/26/19.
//  Copyright © 2019 Kostya Kalivod. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class DataManager {
    class func addToData(indexPath: Int, list: [Article] ){
        let myResultArray = list[indexPath]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "SavedArticles", in: context)
        let articleObject = NSManagedObject(entity: entity!, insertInto: context) as! SavedArticles
        articleObject.title = myResultArray.title
        articleObject.abstract = myResultArray.abstract
        articleObject.published_date = myResultArray.published_date
        articleObject.urlImage = myResultArray.urlImage
        articleObject.url = myResultArray.url
        
        do {
            try context.save()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
            print("All okey!!!!")
        } catch {
            print(error.localizedDescription)
        }

    }


}
