//
//  MyFavoritesTableViewController.swift
//  NYTimesApp
//
//  Created by Konstantin Kalivod on 5/22/19.
//  Copyright © 2019 Kostya Kalivod. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData

class MyFavoritesTableViewController: UITableViewController {
    // MARK: - Variables
    var myArticleSavedList : Array = [SavedArticles]()
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<SavedArticles> = SavedArticles.fetchRequest()
        do {
            myArticleSavedList = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFunc), name: NSNotification.Name(rawValue: "reload"), object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl()



    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myArticleSavedList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! MyTableViewCell
        let myResultArray = myArticleSavedList[indexPath.row]
        cell.titleLabel.text = myResultArray.title
        cell.abstarctLabel.text = myResultArray.abstract
        cell.dateLabel.text = myResultArray.published_date
        
        cell.thumbnailImageView.layer.cornerRadius = 32.5
        cell.thumbnailImageView.clipsToBounds = true
        cell.thumbnailImageView.kf.setImage(with: URL(string: myResultArray.urlImage ?? ""))
        return cell
}
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoriteDetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let myResultArray = myArticleSavedList[indexPath.row]
                let dvc = segue.destination as! DetailViewController
                dvc.titleText = myResultArray.title
                dvc.abstract = myResultArray.abstract
                dvc.date = myResultArray.published_date
                dvc.imageURL = myResultArray.urlImage
                dvc.url = myResultArray.url
                
            }
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "favoriteDetailSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // MARK: - Delete Row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
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

    }
    // MARK: - Refreshing funcs
    @objc func reloadFunc(notification: NSNotification) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
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
}

