//
//  MyZoneViewController.swift
//  dope
//
//  Created by Jiaming Duan on 4/26/19.
//  Copyright © 2019 HaoqiHuang. All rights reserved.
//

import UIKit
import CoreData

class MyZoneViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate  {

    @IBOutlet weak var tableT: UITableView!

    @IBOutlet weak var searchBar: UISearchBar!
    var actList:[Activity]=[Activity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpdata()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpdata()
        tableT.reloadData()
    }
    func setUpdata(){
        actList.removeAll()
        let books:[Book]=SearchHelper.booksSearchByUser(userId: (ViewController.user?.id)!)!
       
        
        for book in books{
            let a=SearchHelper.activitySearchByTitle(activityId: book.activityId)
            if(a != nil){actList.append(a!)}
        }
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionTop = UIContextualAction(style: .normal, title: "Top") { (action, view, finished) in
            let first = IndexPath(row: 0, section: 0)
            tableView.moveRow(at: indexPath, to: first)
            finished(true)
        }
        actionTop.backgroundColor = UIColor.orange
        return UISwipeActionsConfiguration(actions: [actionTop])
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDel = UIContextualAction(style: .destructive, title: "delete") { (action, view, finished) in
            let cell:MyZoneTableCell=tableView.cellForRow(at: indexPath) as! MyZoneTableCell
            self.deleteBooking(a:cell.actt)
            tableView.deleteRows(at: [indexPath], with: .fade)
            finished(true)
        }

        actionDel.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [actionDel])
    }
    func deleteBooking(a:Activity?){
        if a != nil{

            actList=actList.filter(){$0 !== a}
         
         
            
            let bookList=SearchHelper.booksSearchByUser(userId: (ViewController.user?.id)!)
            for book in bookList!{
            
                
                if book.activityId == a?.id{
                    PersistenceService.context.delete(book)
                }
            }
        
            
        Note.note(content:"delete success")
            PersistenceService.saveContext()}
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return actList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableT.dequeueReusableCell(withIdentifier: "actCell") as? MyZoneTableCell else{
            return UITableViewCell()
        }
        cell.titleLabel.text=actList[indexPath.row].title
        cell.actt=actList[indexPath.row]
        cell.actImage.image=actList[indexPath.row].image!.toImage()
        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var list=[Activity]()
        let fetchRequest:NSFetchRequest<Activity>=Activity.fetchRequest()
        do{list=try PersistenceService.context.fetch(fetchRequest)
            self.actList=list
        }
        catch{}
        actList=list.filter({a->Bool in
            if searchText.isEmpty{return true}
            return a.title!.contains(searchText)
        })
        tableT.reloadData()
    }
    
}
