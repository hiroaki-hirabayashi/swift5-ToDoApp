//
//  AddViewController.swift
//  Swift5 Todo
//
//  Created by 平林宏淳 on 2020/12/02.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit
import RealmSwift

protocol AddViewControllerDelegate: class {  //一覧画面から委任
    func tapAddTodoButton()
}

final class AddViewController: UIViewController {
    
    // MARK: - Propertie
    weak var delegate: AddViewControllerDelegate?
    @IBOutlet private weak var todoTextField: UITextField!
    @IBOutlet private weak var todoRegisterButton: UIButton!
    @IBOutlet weak var prioritySegment: UISegmentedControl!

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTextField.delegate = self
        todoRegisterButton.isEnabled = false
        todoRegisterButton.backgroundColor = .darkGray
        prioritySegment.selectedSegmentIndex = -1
    }
    // MARK: - function
    @IBAction func tapTodoRegister(_ sender: Any) { //+Todo追加ボタン押下時
        let realm = try! Realm()
        if let text = todoTextField.text {
            let todo = Todo()
            todo.text = text
            
            try! realm.write {
                realm.add(todo)
            }
            
            navigationController?.popViewController(animated: true)
            delegate?.tapAddTodoButton() //
        }
    }
}
// MARK: - todoTextFieldDelegate
extension AddViewController: UITextFieldDelegate {
    internal func textFieldDidChangeSelection(_ textField: UITextField) {
        if  todoTextField.text?.isEmpty ?? true || prioritySegment.selectedSegmentIndex == -1 {
            todoRegisterButton.isEnabled = false
            todoRegisterButton.backgroundColor = .darkGray
        } else {
            todoRegisterButton.isEnabled = true
            todoRegisterButton.backgroundColor = .systemGreen
        }
    }

}

