//
//  TodoViewController.swift
//  Swift5 Todo
//
//  Created by 平林宏淳 on 2020/12/01.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit
import RealmSwift

class TodoViewController: UIViewController {
    
    // MARK: - Propertie
    @IBOutlet weak var tableView: UITableView!
    private let realm = try! Realm()
    //Realmから受け取るデータを入れる変数
    private var todoList: Results<Todo>!
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        todoList = realm.objects(Todo.self)//インスタンス化
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingView()
    }
    
    //編集ボタンを使えるようにする(ViewControllerの時のみ)
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    
    // MARK: - function
    private func settingView() {
        //最初から編集ボタンを表示させない
        tableView.isEditing = false
        //セルをタップできるようにする
        tableView.allowsSelectionDuringEditing = true
        //並び替え、削除ボタンを表示 タイトル名変更　色
        navigationItem.leftBarButtonItem = editButtonItem
        //Realmのパス
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    //Todo追加画面へ
    @IBAction func tapAddScreenTransitionButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AddTodo", bundle: nil)
        let addVC = storyboard.instantiateViewController(identifier: "AddVC") as! AddViewController
        addVC.delegate = self //Todo追加をAddViewControllerに渡す
        navigationController?.pushViewController(addVC, animated: true)
    }
    
}

// MARK: - UITableViewDataSource
extension TodoViewController: UITableViewDataSource {
    
    //セクションラベルの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //セルの行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    // セルの中身、データを表示する　//withIdentifierを設定した名前に合わせる
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let todoList: Todo = self.todoList[indexPath.row]
        cell.textLabel?.text = todoList.text
        cell.selectionStyle = .none
        
        return cell
    }
    
    //セルの並び替え
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }
    
    //セルを編集できるようにするかどうか設定
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //データ削除設定
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
    
}
// MARK: - UITableViewDelegate
extension TodoViewController: UITableViewDelegate {
    //セルがタップされた時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //タップした時にその配列の番号を取り出して値を渡す
        let storyboard = UIStoryboard(name: "EditTodo", bundle: nil)
        let editVC = storyboard.instantiateViewController(identifier: "EditVC") as! EditViewController
        //編集画面にテキストとセル番号を渡す
        editVC.editTodo = todoList[indexPath.row]
        editVC.returnIndexPath = indexPath
        editVC.delegate = self
        navigationController?.pushViewController(editVC, animated: true)
    }
    
}
// MARK: - EditViewControllerDelegate
extension TodoViewController: EditViewControllerDelegate {
    //編集画面から呼ばれる　delegete
    func tapEditButton(indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
// MARK: - AddViewControllerDelegate
extension TodoViewController: AddViewControllerDelegate {
    func tapAddTodoButton() {
        tableView.reloadData()
    }
    
}





