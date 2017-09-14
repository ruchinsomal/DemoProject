//
//  MainCell.swift
//  DemoProject
//
//  Created by Ruchin Somal on 13/09/17.
//  Copyright © 2017 Ruchin Somal. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {

    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblMain: UILabel!
    @IBOutlet weak var lblSub: UILabel!
    @IBOutlet weak var vw1: UIView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var vw2: UIView!
    @IBOutlet weak var lbl2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
