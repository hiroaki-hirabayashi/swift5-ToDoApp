//
//  TodoTableViewController.swift
//  Swift5 Todo
//
//  Created by 平林宏淳 on 2020/05/22.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit
import RealmSwift

class TodoTableViewController: UITableViewController, EditViewControllerDelegate {
    

    // MARK: - Properties

    let realm = try! Realm()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingView()

    }
    
    func settingView() {
        //最初から編集ボタンを表示させない
        tableView.isEditing = false
        //セルをタップできるようにする
        tableView.allowsSelectionDuringEditing = true
        //並び替え、削除ボタンを表示 タイトル名変更　色
        navigationItem.leftBarButtonItem = editButtonItem
        //Realmのパス
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    
    // MARK: - Table view data source
    
    //セクションラベルの数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //セルの行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Realmをインスタンス化して使えるようにする
        let realms = realm.objects(Todo.self)
        
        return realms.count
    }
    
    // セルの中身、データを表示する　//withIdentifierを設定した名前に合わせる
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let realms = realm.objects(Todo.self)
        let todoArray = realms[indexPath.row]
        cell.textLabel?.text = todoArray.text
        cell.selectionStyle = .none
        
        return cell
    }
    
    //セルがタップされた時の処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let realms = realm.objects(Todo.self)
        //タップした時にその配列の番号を取り出して値を渡す
        let editVC = storyboard?.instantiateViewController(identifier: "EditView") as! EditViewController
        //編集画面にテキストとセル番号を渡す
        let indexNum = indexPath.row
        editVC.editTodo = realms[indexPath.row]
        editVC.returnIndexPath = indexNum
        editVC.delegate = self
        navigationController?.pushViewController(editVC, animated: true)

    }
    
    //セルの並び替え
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }
    
    //セルを編集できるようにするかどうか設定
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //データ削除設定
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realm = try! Realm()
            let todos = realm.objects(Todo.self)
            let todo = todos[indexPath.row]
            
            try! realm.write {
                realm.delete(todo)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - function
    
    //    編集ボタン
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
    
    //編集画面から呼ばれる　delegete
    func tapEditButton(num: Int) {
        var indexPath = IndexPath(row: num, section: 0)
        
        print("check", num)
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
}


