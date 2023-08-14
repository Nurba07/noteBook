//
//  FIrstCell.swift
//  notebook!
//
//  Created by Nurbakhyt on 14.08.2023.
//

import UIKit

class FIrstCell: UITableViewCell {

    static let identifier = "FIrstCell"
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
