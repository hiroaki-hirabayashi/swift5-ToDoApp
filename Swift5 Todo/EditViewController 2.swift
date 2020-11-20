//
//  EditViewController.swift
//  Swift5 Todo
//
//  Created by 平林宏淳 on 2020/11/18.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController {
    
    var todoString = ""
    
    @IBOutlet weak var todoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoLabel.text = todoString

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        
    }
    
    
    
    
    
    
}







