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
    
    let ADD_OPERATION:String = "+"
    let SUBTRACT_OPERATION:String = "-"
    let DIVIDE_OPERATION:String = "/"
    let MULTIPLY_OPERATION:String = "*"
    let PERCENT_OPERATION:String = "%"
    let DECIMAL_OPERATION:String = "."
    
    var num:Double = 0
    var mem:Double = 0
    var operation:String = ""
    var needSecondNum:Bool = false
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func numbers(_ sender: UIButton) {
        label.text = (label.text! == "0" || needSecondNum) ? String(sender.tag - 1) : label.text! + String(sender.tag - 1)
        num = Double(label.text!)!
        needSecondNum = false
    }
    
    
    @IBAction func functionButtons(_ sender: UIButton) {
        //Handles add, subtract, multiply, subtract, percent, sign, and decimal function buttons
        if(label.text != "" && sender.tag != CLEAR_BUTTON && sender.tag != EQUALS_BUTTON){
            switch(sender.tag){
            case ADD_BUTTON:
                sender.layer.borderWidth = 2.0
                operation = ADD_OPERATION
                mem = Double(label.text!)!
                needSecondNum = true
                break;
                
            case SUBTRACT_BUTTON:
                operation = SUBTRACT_OPERATION
                mem = Double(label.text!)!
                needSecondNum = true
                break;
                
            case MULTIPLY_BUTTON:
                operation = MULTIPLY_OPERATION
                mem = Double(label.text!)!
                needSecondNum = true
                break;
                
            case DIVIDE_BUTTON:
                operation = DIVIDE_OPERATION
                mem = Double(label.text!)!
                needSecondNum = true
                break;
                
            case PERCENT_BUTTON:
                operation = PERCENT_OPERATION
                break;
                
            case DECIMAL_BUTTON:
                operation = DECIMAL_OPERATION
                break;
                
            default:
                break;
            }
        }else if(sender.tag == EQUALS_BUTTON){
            switch(operation){
            case ADD_OPERATION:
                label.text = String(mem + num)
                break;
                
            case SUBTRACT_OPERATION:
                break;
                
            case MULTIPLY_OPERATION:
                break;
            
            case DIVIDE_OPERATION:
                break;
                
            case PERCENT_OPERATION:
                break;
                
            case DECIMAL_OPERATION:
                break;
                
            default:
                break;
            }
        }else if(sender.tag == CLEAR_BUTTON){
            label.text = "0"
            operation = ""
        }
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

