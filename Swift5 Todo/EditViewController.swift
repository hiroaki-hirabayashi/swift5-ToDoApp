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
    
    @IBOutlet weak var todoTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTextField.text = todoString
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
        
        todoVC.textArray = todoTextField.text!
        let realm = try! Realm()
        let todo = Todo()
        let todos = realm.objects(Todo.self)

//        todo.text = todoVC.textArray

        
        try! realm.write {
            todo.text = todoVC.textArray
        }
        
        print("todo.text　確認", todo.text)

//        todoVC.tableView.reloadData()
        navigationController?.pushViewController(todoVC, animated: true)
    }
}


