//
//  SignUpViewController.swift
//  dope
//
//  Created by Jiaming Duan on 4/24/19.
//  Copyright © 2019 HaoqiHuang. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    static var count:Int16=0

    @IBOutlet weak var passWord2Text: UITextField!
    @IBOutlet weak var passWord1Text: UITextField!
    @IBOutlet weak var accountText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backSignIn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        if validateData(){
            let account:UserAccount=UserAccount(context: PersistenceService.context)
            account.account=accountText.text
            account.password=passWord2Text.text
            account.id = SignUpViewController.count
            SignUpViewController.count = SignUpViewController.count+1
            PersistenceService.saveContext()
            dismiss(animated: true, completion: nil)
        }else{
            Note.note(content: "please type correct information")}
    }
    
    func validateData()->Bool{
        guard let p1:String=passWord1Text.text else{
            return false
        }
        guard let p2:String=passWord2Text.text else{
            return false
        }
        guard let a:String=accountText.text else{
            return false
        }
        return p1 == p2 && a.count>0 && p1.count>0 && p2.count>0
    }   

}
