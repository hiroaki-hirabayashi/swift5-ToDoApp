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
    
    var realm = try! Realm()
    var todoArray = Todo()
    var textArray = String()
    
    var nextTextArray = String()
    var nextTodoArray = try! Realm()
    var todo = Todo()

    
    
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
        let todos = realm.objects(Todo.self)
        
        return todos.count
    }
    
    //withIdentifierを設定した名前に合わせる
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let todos = realm.objects(Todo.self)
        todoArray = todos[indexPath.row]
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
        var nextTodoArray = realm.objects(Todo.self)

        var nextTextArray = nextTodoArray[indexPath.row]
        //タップした時にその配列の番号を取り出して値を渡す
        let editVC = storyboard?.instantiateViewController(identifier: "EditView") as! EditViewController
        print("koko!!!!!!!!!!" , textArray)
        editVC.todoString = nextTextArray.text


        editVC.editTodo = nextTodoArray[indexPath.row]
        
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
            
            let alertController = UIAlertController(title: "Todoを追加しますか？", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "追加", style: .default){
                (void) in
                let textField = alertController.textFields![0] as UITextField
               
                if let text = textField.text {
                    self.todo.text = text
                    
                    //Realmをインスタンス化して使えるようにする
                    // Persist your data easily 永続化
                    try! self.realm.write {
                        self.realm.add(self.todo)
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
    
//    @IBAction func unwindToTop(sender: UIStoryboardSegue) {
//           // 次画面のNavitukiViewControllerを受け取る
//           guard let sourceVC = sender.source as? EditViewController else {
//               // NavitukiViewControllerでなかったらやめる
//               return
//           }
//
//           // NavitukiViewControllerの値を受け取って更新
//
//           self.textArray = sourceVC.todoTextField.text!

//       }







}






