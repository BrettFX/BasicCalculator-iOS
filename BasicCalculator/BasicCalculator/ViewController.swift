//
//  ViewController.swift
//  BasicCalculator
//
//  Created by Brett Allen on 7/23/17.
//  Copyright © 2017 Brett Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var num:Double = 0
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func numbers(_ sender: UIButton) {
        label.text = label.text! == "0" ? String(sender.tag - 1) : label.text! + String(sender.tag - 1)
        num = Double(label.text!)!
    }
    
    
    @IBAction func functionButtons(_ sender: UIButton) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

