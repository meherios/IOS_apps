//
//  ViewController.swift
//  SlideBar controller
//
//  Created by Meher Jyoti Singh on 5/24/18.
//  Copyright © 2018 Meher Jyoti Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var menu_vc: MenuViewController!
    
    @IBAction func menu_action(_ sender: UIBarButtonItem){
        if AppDelegate.menu_bool{
            show_menu()
        } else {
            close_menu()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        menu_vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
    }
        
        @objc func respondToGesture(gesture: UISwipeGestureRecognizer){
            switch gesture.direction {
            case UISwipeGestureRecognizerDirection.right:
            print("Swipe Right")
                 close_on_swipe()
            case UISwipeGestureRecognizerDirection.left:
            print("Swipe Left")
                close_on_swipe()
            default:
                break
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func show_menu(){
        UIView.animate(withDuration: 0.3) { ()->Void in
            self.menu_vc.view.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.menu_vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
            self.addChildViewController(self.menu_vc)
            self.view.addSubview(self.menu_vc.view)
            AppDelegate.menu_bool = false
        }
        
    }

    func close_menu(){
        
        UIView.animate(withDuration: 0.3, animations: { ()->Void in
            self.menu_vc.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            } )
        { (finished) in
            self.menu_vc.view.removeFromSuperview()
        }
            AppDelegate.menu_bool = true
        }
    

func close_on_swipe(){
    if AppDelegate.menu_bool{
        show_menu()
    } else {
        close_menu()
    }
    
}
}

