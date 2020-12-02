//
//  AddViewController.swift
//  Swift5 Todo
//
//  Created by 平林宏淳 on 2020/12/02.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit
import RealmSwift

protocol AddViewControllerDelegate: class {
    func tapAddTodoButton()
}

final class AddViewController: UIViewController {
    
    // MARK: - Propertie
    @IBOutlet weak var todoTextField: UITextField!
    weak var delegate: AddViewControllerDelegate?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - function
    @IBAction func tapAddTodoButton(_ sender: Any) {
        let realm = try! Realm()
        if let text = todoTextField.text {
            let todo = Todo()
            todo.text = text
            
            try! realm.write {
                realm.add(todo)
            }
            navigationController?.popViewController(animated: true)
            delegate?.tapAddTodoButton()
        }
    }
    
}
