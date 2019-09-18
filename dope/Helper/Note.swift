//
//  Note.swift
//  dope
//
//  Created by Jiaming Duan on 4/24/19.
//  Copyright © 2019 HaoqiHuang. All rights reserved.
//

import Foundation
import UIKit
class Note{
    class func note(content:String){
        var alert = UIAlertView()
        alert.title = "Note"
        alert.message = "\(content)"
        alert.addButton(withTitle: "OK")
        alert.show()
    }
    
}
