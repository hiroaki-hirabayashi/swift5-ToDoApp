//
//  EditViewController.swift
//  Swift5 Todo
//
//  Created by 平林宏淳 on 2020/11/18.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit
import RealmSwift

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
  
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTextField.text = editTodo.text
    }
    
    // MARK: - function
    @IBAction func tapEditButton(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write {
            editTodo.text = todoTextField.text!
        }
        navigationController?.popViewController(animated: true)
        delegate?.tapEditButton(indexPath: returnIndexPath )  //一覧画面から渡されたindexPathをそのまま返す
    }
}






