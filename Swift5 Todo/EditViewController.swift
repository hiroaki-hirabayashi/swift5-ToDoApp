//
//  EditViewController.swift
//  Swift5 Todo
//
//  Created by 平林宏淳 on 2020/11/18.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit
import RealmSwift

protocol EditViewControllerDelegate {
    func tapEditButton(num: Int)
}

class EditViewController: UIViewController {

    // MARK: - Properties

    var editTodo = Todo()
    //一覧画面から来たセル番号
    var returnIndexPath = Int()
    var delegate: EditViewControllerDelegate! = nil

    
    @IBOutlet weak var todoTextField: UITextField!
  
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        todoTextField.text = editTodo.text

    }
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //
    //        navigationController?.isNavigationBarHidden = false
    //
    //    }
    
    // MARK: - function

    @IBAction func tapEditButton(_ sender: Any) {
        let realm = try! Realm()
        let todos = realm.objects(Todo.self)

        try! realm.write {
            editTodo.text = todoTextField.text!
            editTodo.num = returnIndexPath
        }
        navigationController?.popViewController(animated: true)
        delegate.tapEditButton(num: returnIndexPath)
    }
}






