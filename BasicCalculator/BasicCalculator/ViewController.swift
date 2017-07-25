//
//  ViewController.swift
//  BasicCalculator
//
//  Created by Brett Allen on 7/23/17.
//  Copyright © 2017 Brett Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let CLEAR_BUTTON: Int = 11
    let SIGN_BUTTON: Int = 12
    let PERCENT_BUTTON: Int = 13
    let DIVIDE_BUTTON: Int = 14
    let MULTIPLY_BUTTON: Int = 15
    let SUBTRACT_BUTTON: Int = 16
    let ADD_BUTTON: Int = 17
    let EQUALS_BUTTON: Int = 18
    let DECIMAL_BUTTON: Int = 19
    
    let ADD_OPERATION: String = "+"
    let SUBTRACT_OPERATION: String = "-"
    let DIVIDE_OPERATION: String = "/"
    let MULTIPLY_OPERATION: String = "*"
    
    let ERROR_MESSAGE: String = "Error"
    
    var num: Double = 0
    var mem: Double = 0
    var operation:String = ""
    var needSecondNum:Bool = false
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var btnDivide: UIButton!
    @IBOutlet weak var btnMultiply: UIButton!
    @IBOutlet weak var btnSubtract: UIButton!
    @IBOutlet weak var btnAdd: UIButton!    
    
    
    @IBAction func numbers(_ sender: UIButton) {
        if(label.text! == "0" || label.text! == ERROR_MESSAGE || needSecondNum){
            label.text = String(sender.tag - 1)
        }else{
            appendToDisplay(text: String(sender.tag - 1))
        }
        
        num = Double(label.text!)!
        needSecondNum = false
        unselectFuncButtons()
    }
    
    
    @IBAction func functionButtons(_ sender: UIButton) {
        //Handles add, subtract, multiply, subtract, percent, sign, and decimal function buttons
        if(label.text != "" && sender.tag != CLEAR_BUTTON && sender.tag != EQUALS_BUTTON){
            switch(sender.tag){
            case ADD_BUTTON:
                operationChosen(operation: ADD_OPERATION, sender: sender)
                break
                
            case SUBTRACT_BUTTON:
                operationChosen(operation: SUBTRACT_OPERATION, sender: sender)
                break
                
            case MULTIPLY_BUTTON:
                operationChosen(operation: MULTIPLY_OPERATION, sender: sender)
                break
                
            case DIVIDE_BUTTON:
                operationChosen(operation: DIVIDE_OPERATION, sender: sender)
                break
                
            case PERCENT_BUTTON:
                num /= 100
                label.text = String(num)
                
                break
                
            case DECIMAL_BUTTON:
                let hasDecimal: Bool = (label.text?.contains("."))!
                
                if(needSecondNum || label.text! == ERROR_MESSAGE){
                    label.text! = "0."
                    needSecondNum = false
                }else if(!hasDecimal){
                    appendToDisplay(text: ".")
                }
                
                break
                
            case SIGN_BUTTON:
                if(label.text != "0"){
                    num *= -1
                    performNecessaryParsing(arithmetic: num)
                }
                
                break
                
            default:
                break
            }
        }else if(sender.tag == EQUALS_BUTTON){
            
            var arithmetic: Double = 0
            
            switch(operation){
            case ADD_OPERATION:
                arithmetic = mem + num
                break
                
            case SUBTRACT_OPERATION:
                arithmetic = mem - num
                break
                
            case MULTIPLY_OPERATION:
                arithmetic = mem * num
                break
            
            case DIVIDE_OPERATION:
                if(num != 0){
                    arithmetic = mem / num
                }else{
                    label.text = ERROR_MESSAGE
                    return
                }
                
                break
                
            default:
                break
            }
            
            performNecessaryParsing(arithmetic: arithmetic)
				
            if(operation != ""){
                num = Double(label.text!)!
                needSecondNum = true
            }
            
        }else if(sender.tag == CLEAR_BUTTON){
            label.text = "0"
            num = 0
            mem = 0
            operation = ""
            needSecondNum = false
            unselectFuncButtons()
        }
    }
    
    private func performNecessaryParsing(arithmetic: Double) -> Void{
        //Determine if the number is just an integer, i.e., don't display 7 as 7.0
        let trunc: Int = ((arithmetic - floor(arithmetic) == 0.0) || arithmetic == 0.0) ? Int(arithmetic) : 0
        
        //If the truncation flag is set to 0 then the arithmetic has a decimal
        label.text = trunc == 0 ? String(arithmetic) : String(trunc)
    }
    
    private func operationChosen(operation: String, sender: UIButton) -> Void{
        self.operation = operation
        mem = Double(label.text!)!
        needSecondNum = true
        unselectFuncButtons()
        sender.layer.borderWidth = 2.0
        
    }
    
    private func unselectFuncButtons() -> Void{
        btnAdd.layer.borderWidth = 0.0
        btnSubtract.layer.borderWidth = 0.0
        btnMultiply.layer.borderWidth = 0.0
        btnDivide.layer.borderWidth = 0.0
    }
    
    private func appendToDisplay(text: String) -> Void{
        if((label.text?.characters.count)! < 11){
            label.text! += text
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

