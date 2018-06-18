//
//  ViewController.swift
//  realm_data
//
//  Created by Meher Jyoti Singh on 6/6/18.
//  Copyright © 2018 Meher Jyoti Singh. All rights reserved.
//

import UIKit
import RealmSwift

var todos: Results<ToDo>!
let realm = try! Realm()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todos = realm.objects(ToDo.self)
        tableView.delegate = self
        tableView.dataSource = self
        reload()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reload()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoCell
        let todo = todos[indexPath.row]
        cell.todoText.text = todo.ToDotext
        cell.isdoneText.text = todo.IsDone ? "Is it done" : "Do it"
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func reload(){
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           try! realm.write {
                realm.delete(todos[indexPath.row])
            }
            reload()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editsegue" {
            let destination = segue.destination as! InsertViewController
            let todo = todos[tableView.indexPathForSelectedRow!.row]
            destination.incomingToDo = todo 
        }
    }

}

class ToDo: Object{
    @objc dynamic var ToDotext = ""
    @objc dynamic var IsDone = false
}

class TodoCell: UITableViewCell{
    
    @IBOutlet weak var todoText: UILabel!
    @IBOutlet weak var isdoneText: UILabel!
    
}

