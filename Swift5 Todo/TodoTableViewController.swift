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
    
    
    var textArray = String()
    
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
        let realm = try! Realm()
        let todos = realm.objects(Todo.self)
        
        return todos.count
    }
    
    //withIdentifierを設定した名前に合わせる
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let realm = try! Realm()
        let todos = realm.objects(Todo.self)
        let textArray = todos[indexPath.row]
        cell.textLabel?.text = textArray.text
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
        let realm = try! Realm()
        let todos = realm.objects(Todo.self)
        let textArray = todos[indexPath.row]

        //タップした時にその配列の番号を取り出して値を渡す
        let editVC = storyboard?.instantiateViewController(identifier: "EditView") as! EditViewController
        print("koko!!!!!!!!!!" , textArray.text)
        editVC.todoString = textArray.text
        
        navigationController?.pushViewController(editVC, animated: true)

               
    }

//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            performSegue(withIdentifier: "EditView", sender: nil)
//
//            if segue.identifier == "EditView" {
//                let editVC: EditViewController = (segue.destination as? EditViewController)!
//                editVC.todoString = textArray
//
////            }
//
//    }
//

    
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
      



//
//func tapEditButton(_ sender: Any) {
//    let editVC = storyboard?.instantiateViewController(withIdentifier: "EditView") as! EditViewController
//    navigationController?.pushViewController(editVC, animated: true)
//
//
//}


    @IBAction func tapAddButton(_ sender: Any) {
            
            let alertController = UIAlertController(title: "Todoを追加しますか？", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "追加", style: .default){
                (void) in
                let textField = alertController.textFields![0] as UITextField
                if let text = textField.text {
                    
                    let todo = Todo()
                    todo.text = text
                    
                    //Realmをインスタンス化して使えるようにする
                    let realm = try! Realm()
                    // Persist your data easily 永続化
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
    
    @IBAction func unwindToTop(sender: UIStoryboardSegue) {
           // 次画面のNavitukiViewControllerを受け取る
           guard let sourceVC = sender.source as? EditViewController else {
               // NavitukiViewControllerでなかったらやめる
               return
           }
           
           // NavitukiViewControllerの値を受け取って更新
           
           self.textArray = sourceVC.todoTextField.text!

       }







}






