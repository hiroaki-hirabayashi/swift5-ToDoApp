//
//  TodoTableViewController.swift
//  Swift5 Todo
//
//  Created by 平林宏淳 on 2020/05/22.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit
import RealmSwift

class TodoTableViewController: UITableViewController {
    
    
    let realm = try! Realm()
    
   override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.isEditing = true
        tableView.allowsSelectionDuringEditing = true
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Realmをインスタンス化して使えるようにする
        let realms = realm.objects(Todo.self)
        
        return realms.count
    }
    
    //withIdentifierを設定した名前に合わせる
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let realms = realm.objects(Todo.self)
        let todoArray = realms[indexPath.row]
        cell.textLabel?.text = todoArray.text
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let realms = realm.objects(Todo.self)
        
        var nextTextArray = realms[indexPath.row]
        //タップした時にその配列の番号を取り出して値を渡す
        let editVC = storyboard?.instantiateViewController(identifier: "EditView") as! EditViewController
        editVC.todoString = nextTextArray.text
        editVC.editTodo = realms[indexPath.row]
        
        navigationController?.pushViewController(editVC, animated: true)
        
        
    }
    
    //    //データ削除設定
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //
    //            let realm = try! Realm()
    //            let todos = realm.objects(Todo.self)
    //            let todo = todos[indexPath.row]
    //
    //            try! realm.write {
    //                realm.delete(todo)
    //            }
    //
    //
    //
    //
    //
    //            tableView.deleteRows(at: [indexPath], with: .fade)
    //        } else if editingStyle == .insert {
    //
    //        }
    //    }
    //
    
    @IBAction func tapAddButton(_ sender: Any) {
        let realm = try! Realm()
        let alertController = UIAlertController(title: "Todoを追加しますか？", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "追加", style: .default){
            (void) in
            let textField = alertController.textFields![0] as UITextField
            
            if let text = textField.text {
                let todo = Todo()
                todo.text = text
                
                try! realm.write {
                    realm.add(todo)
                }
                
                self.tableView.reloadData()
            }
            
        }
        
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        alertController.addTextField{(textField) in
            textField.placeholder = "Todoの名前を入れてください。"
            
        }
        alertController.addAction(action)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
}






