//
//  MyZoneTableCell.swift
//  dope
//
//  Created by Jiaming Duan on 4/26/19.
//  Copyright © 2019 HaoqiHuang. All rights reserved.
//

import Foundation
import UIKit
class MyZoneTableCell: UITableViewCell {
    var actt:Activity!
    @IBOutlet weak var actImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
