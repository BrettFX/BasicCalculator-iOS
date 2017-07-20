//
//  ViewController.swift
//  BasicCalculator
//
//  Created by Brett Allen on 7/23/17.
//  Copyright © 2017 Brett Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let CLEAR_BUTTON:Int = 11
    let SIGN_BUTTON:Int = 12
    let PERCENT_BUTTON:Int = 13
    let DIVIDE_BUTTON:Int = 14
    let MULTIPLY_BUTTON:Int = 15
    let SUBTRACT_BUTTON:Int = 16
    let ADD_BUTTON:Int = 17
    let EQUALS_BUTTON:Int = 18
    let DECIMAL_BUTTON:Int = 19
    
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

