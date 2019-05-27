//
//  ViewedTableViewController.swift
//  NYTimesApp
//
//  Created by Konstantin Kalivod on 5/22/19.
//  Copyright © 2019 Kostya Kalivod. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData

class ViewedTableViewController: UITableViewController {
    // MARK: - Variables
    var myArticleList : Array = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.getWeatherInfoIn(type: "viewed") { (array) in
            self.myArticleList = array
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myArticleList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewedCellId", for: indexPath) as! ViewedTableViewCell
        
        let myResultArray = myArticleList[indexPath.row]
        cell.titleLabel.text = myResultArray.title
        cell.abstarctLabel.text = myResultArray.abstract
        cell.dateLabel.text = myResultArray.published_date
        
        cell.thumbnailImageView.layer.cornerRadius = 32.5
        cell.thumbnailImageView.clipsToBounds = true
        cell.thumbnailImageView.kf.setImage(with: URL(string: myResultArray.urlImage))
        return cell
    }
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewedDetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow{
                Managers.segueDetail(segue: segue, indexPath: indexPath.row, list: self.myArticleList)
            }
        }
    }
    // MARK: - Edit Row
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let addToCoreData = UITableViewRowAction(style: .default, title: "Add") { (action, indexPath) in
            DataManager.addToData(indexPath: indexPath.row, list: self.myArticleList)
            self.present(Managers.addAlert(), animated: true, completion: nil)
        }
        return [addToCoreData]
    }
}
