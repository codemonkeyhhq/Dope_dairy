//
//  ViewController.swift
//  dope
//
//  Created by Jiaming Duan on 4/24/19.
//  Copyright © 2019 HaoqiHuang. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    static var user:UserAccount?=nil
    @IBAction func signIn(_ sender: UIButton) {
        if valiateData(){
            ViewController.user=SearchHelper.userSearchByAccount(account: accountText.text!)
            performSegue(withIdentifier: "login", sender: nil)
        }else{
            Note.note(content: "please type correct information")
        }
    }
    @IBOutlet weak var accountText: UITextField!
    @IBOutlet weak var passWordText: UITextField!
    
    func valiateData()->Bool{
        if accountText.text==nil{return false}
        if passWordText.text==nil{return false}
        if  (accountText.text?.count)!<1{return false}
        if (passWordText.text?.count)!<1{return false}
        let u1=SearchHelper.userSearchByAccount(account:accountText.text!)
        let u2=SearchHelper.userSearchByPassword(password: passWordText.text!)
        if u1==nil || u2==nil{return false}
        return u1?.id==u2?.id
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        do{
//            try PersistenceService.context.execute(deleteRequest)
//        }catch let error as NSError{
//
//        }
        
       
    }


}

