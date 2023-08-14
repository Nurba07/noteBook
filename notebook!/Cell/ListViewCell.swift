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
protocol ArchiveViewControllerDelegate{
    func deleteButtonPressed(done: Done)
}

class ListViewCell: UITableViewCell {

    static let identifier = "ListViewCell"
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var task: List?
    var done: Done?

    var delegate: ViewControllerDelegate?
    var archiveDelegate: ArchiveViewControllerDelegate?
    
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
        if let task = task {
            self.delegate?.deleteButtonPressed(list: task)
        }else if let done = done{
            self.archiveDelegate?.deleteButtonPressed(done: done)
        }
    }
}
