//
//  ViewController.swift
//  JonahsWhale
//
//  Created by michael febrianto on 21/08/2016.
//  Copyright © 2016 mfebrianto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var consoleText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func clickGetAllObjects(sender: AnyObject) {
        print("button clicked")
        
        ProjectService.getAll()
            .success { (value) in
                print("value = \(value)")
                self.consoleText.text = value
                
                self.performSegueWithIdentifier("segueGalleryViewController", sender: self)
                
            }
            .error { (error) in
                print("error = \(error)")                
        }
        
//        self.performSegueWithIdentifier("segueGalleryViewController", sender: self)
    }
}

