//
//  ActivityDetail.swift
//  dope
//
//  Created by Jiaming Duan on 4/25/19.
//  Copyright © 2019 HaoqiHuang. All rights reserved.
//

import UIKit

class ActivityDetail: UIViewController {
    static var count:Int16=0
    var actTitle: String?
    var act:Activity!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var Detail: UILabel!
    @IBAction func book(_ sender: UIButton) {
        if validateData(){
            let b:Book=Book(context:PersistenceService.context)
            b.activityId=act.id
            b.host=false
            b.userId=(ViewController.user?.id)!
          
            b.id=ActivityDetail.count
            ActivityDetail.count=ActivityDetail.count+1
            PersistenceService.saveContext()
         
     
            Note.note(content: "book success")
        }
        else{
            Note.note(content: "You have already booked this event")
        }
    }
    @IBOutlet weak var dateText: UILabel!
    @IBAction func BackToMap(_ sender: UIButton) {
          dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if(actTitle==nil){
            Note.note(content: "can't find activity for now")
        }else{
            if SearchHelper.activitySearchByTitle(title: actTitle!)==nil
            {
                Note.note(content: "can't find activity for now")
            }
            else{
                let activity:Activity=SearchHelper.activitySearchByTitle(title: actTitle!)!
                dateText.text=activity.date
                titleText.text=activity.title
                Detail.text=activity.detail
                imageView.image=activity.image?.toImage()
                act=activity
            }
        }
        
    }
    func validateData()->Bool{
        if actTitle==nil||act==nil{
            return false
        }
        guard let books=SearchHelper.booksSearchByUser(userId: (ViewController.user?.id)!)else{
            return false
        }
        if books.count<1{
            return true
        }
        for booked in books{

            if booked.activityId==act.id{
                return false
            }
        }
        return true
    }
}
