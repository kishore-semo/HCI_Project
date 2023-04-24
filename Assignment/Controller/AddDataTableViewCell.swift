//
//  AddDataTableViewCell.swift
//  Assignment
//
//  Created by Durgarao on 20/04/23.
//

import UIKit

class AddDataTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var lblBloodSugarBeforeBreakfast: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblBloodSugarBeforeBreakfastTime: UILabel!
    @IBOutlet weak var lblBreakfast: UILabel!
    @IBOutlet weak var lblBreakfasttime: UILabel!
    @IBOutlet weak var lblLunch: UILabel!
    @IBOutlet weak var lblLunchTime: UILabel!
    @IBOutlet weak var lblDinner: UILabel!
    @IBOutlet weak var lblDinnerTime: UILabel!
    @IBOutlet weak var lblBloodSugarAfterBreakfast: UILabel!
    @IBOutlet weak var lblBloodSugarAfterBreakfastTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 8
        backView.layer.borderColor = UIColor.white.cgColor
        backView.layer.borderWidth = 1.0
        backView.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
