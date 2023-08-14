//
//  ListViewCell.swift
//  notebook!
//
//  Created by Nurbakhyt on 10.08.2023.
//

import UIKit

protocol ViewControllerDelegate{
    func deleteButtonPressed(list: List)
}

class ListViewCell: UITableViewCell {

    static let identifier = "ListViewCell"
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var task: List?
    
    var delegate: ViewControllerDelegate?
    
    @IBOutlet weak var doneButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let body = task?.body else { return }
        guard let date = task?.date else { return }

        self.titleLabel.text = task?.title
        self.bodyLabel.text = "\(body) \n\(date)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        guard let task = task else { return }
        self.delegate?.deleteButtonPressed(list: task)
    }
}
