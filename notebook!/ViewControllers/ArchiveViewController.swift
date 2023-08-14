//
//  ArchiveViewController.swift
//  notebook!
//
//  Created by Nurbakhyt on 14.08.2023.
//

import UIKit

class ArchiveViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var coreDataManager = CoreDataManager()
    
    var done: [Done] = [Done](){
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Archive"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListViewCell.nib, forCellReuseIdentifier: ListViewCell.identifier)
        updateData()
        // Do any additional setup after loading the view.
    }
    func updateData(){
        if let done = coreDataManager.getAllDone() {
            self.done = done.reversed()
        }
        self.tableView.reloadData()
    }
    
}

extension ArchiveViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return done.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListViewCell.identifier) as! ListViewCell
        cell.titleLabel.text = done[indexPath.row].title
        cell.bodyLabel.text = done[indexPath.row].body
        cell.doneButton.setTitle("Delete", for: .normal)
        cell.doneButton.tintColor = .black
        cell.doneButton.backgroundColor = .red
        cell.doneButton.layer.cornerRadius = 5
        return cell
    }
    
}
