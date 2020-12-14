//
//  EditViewController.swift
//  Swift5 Todo
//
//  Created by 平林宏淳 on 2020/11/18.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit
import RealmSwift
import Combine

protocol EditViewControllerDelegate: class { //一覧画面から委任
    func tapEditButton(indexPath: IndexPath)
}

final class EditViewController: UIViewController {
    
    // MARK: - Propertie
    var editTodo = Todo()
    //一覧画面から来たセル番号
    var returnIndexPath = IndexPath()
    weak var delegate: EditViewControllerDelegate?
    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var todoUpdateButton: UIButton!
    private var didChangeCancellable: AnyCancellable? //Combineを使ってNotificationを受け取る
    private var didChangeButtonColorCancellable: AnyCancellable?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTextField.text = editTodo.text
        
//        didChangeCancellable = NotificationCenter.default
//            .publisher(for: UITextField.textDidChangeNotification, object: todoTextField)
//            .sink(receiveValue: { (notification) in
//                if let editText = notification.object as? UITextField {
//                    if let editTodo = editText.text {
//                        if editTodo.isEmpty ?? true {
//                            self.todoUpdateButton.isEnabled = false
//                            self.todoUpdateButton.backgroundColor = .gray
//                        } else {
//                            self.todoUpdateButton.isEnabled = true
//                            self.todoUpdateButton.backgroundColor = .orange
//                        }
//                    }
//                }
//            })
        didChangeCancellable = NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: todoTextField)
            .compactMap { $0.object as? UITextField } //notification.objectがUITextFieldにキャストできるものだけ次に進む
            .compactMap { $0.text?.count ?? 1 >= 1 } //上から渡されたTextField.textの文字数が1文字以上か
            .assign(to: \.isEnabled, on: todoUpdateButton)
        
        didChangeButtonColorCancellable = NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: todoTextField)
            .compactMap { $0.object as? UITextField }
            .compactMap { $0.text?.isEmpty ?? true ? .gray : .systemPurple }
            .assign(to: \.backgroundColor, on: todoUpdateButton)
        
    }
    // MARK: - function
    @IBAction func tapEditButton(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write {
            editTodo.text = todoTextField.text!
        }
        navigationController?.popViewController(animated: true)
        delegate?.tapEditButton(indexPath: returnIndexPath)  //一覧画面から渡されたindexPathをそのまま返す
    }
}






