//
//  ViewController.swift
//  notebook!
//
//  Created by Nurbakhyt on 10.08.2023.
//

import UIKit
import Foundation

class ViewController: UIViewController, ViewControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var plusButton: UIButton!
    
    var list: [List] = [List](){
        didSet{
            tableView.reloadData()
        }
    }
    
    var delegate: ViewControllerDelegate?
    var coreData = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasks"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListViewCell.nib, forCellReuseIdentifier: ListViewCell.identifier)
        tableView.register(FIrstCell.nib, forCellReuseIdentifier: FIrstCell.identifier)
        getData()
        // Do any additional setup after loading the view.
    }

    @IBAction func plusButtonPressed(_ sender: Any) {
        showAlertWithTwoTextFields()
    }
    func deleteButtonPressed(list: List) {
        coreData.delete(list: list)
        getData()
    }
    func getData(){
        if let list = coreData.getAllTasks() {
            self.list = list.reversed()
            self.tableView.reloadData()
        }
    }
    func currentDate() ->String{
        let date = Date()
        let dateFormatter = DateFormatter()
         
        dateFormatter.dateFormat = "dd.MM.yyyy"
         
        let result = dateFormatter.string(from: date)
        return result
    }
    
    func showAlertWithTwoTextFields() {
        let alertController = UIAlertController(title: "Add Task", message: "Enter task's description", preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { [self]
            alert -> Void in

            let title = alertController.textFields![0] as UITextField
            let body = alertController.textFields![1] as UITextField

            if title.text != ""{
                self.coreData.save(title: title.text, body: body.text, date: self.currentDate())
                self.getData()
            }else{
            }

        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
        })

        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Task Title"
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter task description in short"
        }

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FIrstCell.identifier) as! FIrstCell
            cell.textLabel?.text = "Archive"
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ListViewCell.identifier) as! ListViewCell
            cell.task = list[indexPath.row - 1]
            cell.delegate = self
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row == 0 {
            if let vc = storyboard?.instantiateViewController(identifier: "archive") as? ArchiveViewController{
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}
