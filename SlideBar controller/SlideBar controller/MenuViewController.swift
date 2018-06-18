//
//  MenuViewController.swift
//  SlideBar controller
//
//  Created by Meher Jyoti Singh on 5/24/18.
//  Copyright © 2018 Meher Jyoti Singh. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let title_arr = ["Home", "About us", "Reservation", "Logout"]

    @IBOutlet weak var Menu_Table_view: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Menu_Table_view.delegate = self
        Menu_Table_view.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return title_arr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.tag = indexPath.row
        cell.textLabel?.text = title_arr[indexPath.row]
        return cell
    }
}
