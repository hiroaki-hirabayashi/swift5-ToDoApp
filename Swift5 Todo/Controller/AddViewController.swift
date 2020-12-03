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
    @IBOutlet private weak var todoTextField: UITextField!
    @IBOutlet private weak var todoRegisterButton: UIButton!
    weak var delegate: AddViewControllerDelegate?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTextField.delegate = self
        todoRegisterButton.isEnabled = false
        todoRegisterButton.backgroundColor = .darkGray
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
// MARK: - todoTextFieldDelegate
extension AddViewController: UITextFieldDelegate {
    internal func textFieldDidChangeSelection(_ textField: UITextField) {
        if  todoTextField.text == nil || todoTextField.text?.isEmpty == true {
            todoRegisterButton.isEnabled = false
            todoRegisterButton.backgroundColor = .darkGray
        } else {
            todoRegisterButton.isEnabled = true
            todoRegisterButton.backgroundColor = .systemGreen
        }

    }
}

