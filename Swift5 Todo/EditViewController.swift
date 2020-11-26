//
//  EditViewController.swift
//  Swift5 Todo
//
//  Created by 平林宏淳 on 2020/11/18.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController {

    // MARK: - Properties

    var editTodo = Todo()
    var indexPath = IndexPath(row: 0, section: 0)
    
    @IBOutlet weak var todoTextField: UITextField!
  
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTextField.text = editTodo.text
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "更新", style: .plain, target: self, action: #selector(rowUpdata))

    }
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //
    //        navigationController?.isNavigationBarHidden = false
    //
    //    }
    
    // MARK: - function
    
    @IBAction func tapEditButton(_ sender: Any) {
        //タップした時にその配列の番号を取り出して値を渡す
        let todoVC = storyboard?.instantiateViewController(identifier: "TodoTableView") as! TodoTableViewController
        
        let realm = try! Realm()
        try! realm.write {
            editTodo.text = todoTextField.text!
        }
        todoVC.tableView.reloadRows(at: [indexPath], with: .fade)
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationController?.popViewController(animated: true)
    }
    
    
}






