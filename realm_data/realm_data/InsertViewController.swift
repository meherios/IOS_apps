//
//  InsertViewController.swift
//  realm_data
//
//  Created by Meher Jyoti Singh on 6/6/18.
//  Copyright © 2018 Meher Jyoti Singh. All rights reserved.
//

import UIKit
import RealmSwift

class InsertViewController: UIViewController {
    
    var incomingToDo: ToDo? = nil
    let realm = try! Realm()

    @IBOutlet weak var todotextField: UITextField!
    @IBOutlet weak var switchbutton: UISwitch!
    @IBAction func saveButton(_ sender: Any) {
        
        if let goodtodo = incomingToDo{
            try! realm.write {
                goodtodo.IsDone = switchbutton.isOn
                goodtodo.ToDotext = todotextField.text!
            }
        } else {
            let todo = ToDo()
            todo.ToDotext = todotextField.text!
            todo.IsDone = switchbutton.isOn
        
            try! realm.write {
                realm.add(todo)
            }
        }
        
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let goodtodo = incomingToDo{
            todotextField.text = goodtodo.ToDotext
            switchbutton.isOn = goodtodo.IsDone
        }
       
    }

}
