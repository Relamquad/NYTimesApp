//
//  EmailedTableViewController.swift
//  NYTimesApp
//
//  Created by Konstantin Kalivod on 5/22/19.
//  Copyright © 2019 Kostya Kalivod. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData

class EmailedTableViewController: UITableViewController, UITabBarDelegate {
    // MARK: - Variables
    var myArticleList : Array = [Article]()
    var myArticleSavedList : Array = [SavedArticles]()
    enum TabBarTag : Int{
        case Emailed = 1
        case Shared = 2
        case Viewed = 3
        case myFavorite = 4
    }
    override func viewWillAppear(_ animated: Bool) {
        let tag = self.tabBarController?.tabBar.selectedItem!.tag
        switch tag {
        case TabBarTag.myFavorite.rawValue:
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<SavedArticles> = SavedArticles.fetchRequest()
        do {
            myArticleSavedList = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        default:
            break
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 85
        let tag = self.tabBarController?.tabBar.selectedItem!.tag
        switch tag {
        case TabBarTag.Emailed.rawValue:
            APIManager.getWeatherInfoIn(type: "emailed") { (array) in
                self.myArticleList = array
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        case TabBarTag.Shared.rawValue:
            APIManager.getWeatherInfoIn(type: "shared") { (array) in
                self.myArticleList = array
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        case TabBarTag.Viewed.rawValue:
            APIManager.getWeatherInfoIn(type: "viewed") { (array) in
                self.myArticleList = array
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        default:
            addRefreshControl()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tag = self.tabBarController?.tabBar.selectedItem!.tag
        switch tag {
        case TabBarTag.myFavorite.rawValue:
            return myArticleSavedList.count
        default:
            return myArticleList.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tag = self.tabBarController?.tabBar.selectedItem!.tag
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        switch tag {
        case TabBarTag.myFavorite.rawValue:
            let myResultArray = myArticleSavedList[indexPath.row]
            cell.titleLabel.text = myResultArray.title
            cell.abstarctLabel.text = myResultArray.abstract
            cell.dateLabel.text = myResultArray.published_date
            
            cell.thumbnailImageView.layer.cornerRadius = 32.5
            cell.thumbnailImageView.clipsToBounds = true
            cell.thumbnailImageView.kf.setImage(with: URL(string: myResultArray.urlImage ?? ""))
            return cell
        default:
            let myResultArray = myArticleList[indexPath.row]
            cell.titleLabel.text = myResultArray.title
            cell.abstarctLabel.text = myResultArray.abstract
            cell.dateLabel.text = myResultArray.published_date
            
            cell.thumbnailImageView.layer.cornerRadius = 32.5
            cell.thumbnailImageView.clipsToBounds = true
            cell.thumbnailImageView.kf.setImage(with: URL(string: myResultArray.urlImage))
            return cell
        }        
    }
    // MARK: - Segue
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "emailedDetailSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let dvc = mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            
            print("Error View")
            return
        }
        let tag = self.tabBarController?.tabBar.selectedItem!.tag
        switch tag {
        case TabBarTag.myFavorite.rawValue:
            let myResultArray = myArticleSavedList[indexPath.row]
            dvc.titleText = myResultArray.title
            dvc.abstract = myResultArray.abstract
            dvc.date = myResultArray.published_date
            dvc.imageURL = myResultArray.urlImage
            dvc.url = myResultArray.url
        default:
            let myResultArray = myArticleList[indexPath.row]
            dvc.titleText = myResultArray.title
            dvc.abstract = myResultArray.abstract
            dvc.date = myResultArray.published_date
            dvc.imageURL = myResultArray.urlImage
            dvc.url = myResultArray.url
        }
        
        navigationController?.pushViewController(dvc, animated: true)
    }
    // MARK: - Edit Row
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let tag = self.tabBarController?.tabBar.selectedItem!.tag
        switch tag {
        case TabBarTag.myFavorite.rawValue:
            let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            let myResultArray = self.myArticleSavedList[indexPath.row]
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            do {
                context.delete(myResultArray)
                self.myArticleSavedList.remove(at: indexPath.row)
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            return [delete]
        default:
            let addToCoreData = UITableViewRowAction(style: .default, title: "Add") { (action, indexPath) in
                DataManager.addToData(indexPath: indexPath.row, list: self.myArticleList)
                self.present(Managers.addAlert(), animated: true, completion: nil)
            }
            return [addToCoreData]
            
        }
        
    }
    
    
    
    // MARK: - Refreshing funcs
    func addRefreshControl() {
        
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = UIColor.red
        refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        tableView.addSubview(refreshControl!)
    }
    
    @objc func refreshList() {
        refreshControl?.endRefreshing()
        self.tableView.reloadData()
        print("RELOADED")
    }
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let tag = self.tabBarController?.tabBar.selectedItem!.tag
        switch tag {
        case TabBarTag.myFavorite.rawValue:
            tableView.reloadData()
        default:
            break
        }
    }
}
