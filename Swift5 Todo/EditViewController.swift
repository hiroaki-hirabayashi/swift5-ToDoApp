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
    
    var todoString = ""
    var editTodo = Todo()
    
    @IBOutlet weak var todoTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTextField.text! = todoString
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //
    //        navigationController?.isNavigationBarHidden = false
    //
    //    }
    
    
    @IBAction func tapEditButton(_ sender: Any) {

        
        //タップした時にその配列の番号を取り出して値を渡す
        let todoVC = storyboard?.instantiateViewController(identifier: "TodoTableView") as! TodoTableViewController
        
        let realm = try! Realm()
        let toBeUpdatedUserName = todoTextField.text!
        let toBeUpdatedRecords = realm.objects(Todo.self)
        
        
        try! realm.write {
            editTodo.text = todoTextField.text!
            
//            for element in toBeUpdatedRecords{
//             let element = todoTextField.text!
//
//
//            }
        }

        print("todo.text　確認", todoVC.nextTextArray, todoVC.todoArray)
        todoVC.tableView.reloadData()

        navigationController?.pushViewController(todoVC, animated: true)
    }
}


