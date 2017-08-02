//
//  ViewController.swift
//  BasicCalculator
//
//  Created by Brett Allen on 7/23/17.
//  Copyright © 2017 Brett Allen. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    let MAX_CHAR_COUNT: Int = 11
    
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
    let ALL_CLEAR: String = "AC"
    let CLEAR: String = "C"
    
    let COLORS = [UIColor](arrayLiteral: UIColor.blue, UIColor.green, UIColor.red, UIColor.orange)
    var currentColor: Int = -1
    
    var num: Double = 0
    var mem: Double = 0
    var operation:String = ""
    var needSecondNum:Bool = false
    var hasDecimal: Bool = false
    
    var numberFormatter: NumberFormatter
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var btnDivide: UIButton!
    @IBOutlet weak var btnMultiply: UIButton!
    @IBOutlet weak var btnSubtract: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnEquals: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    
    init() {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = MAX_CHAR_COUNT
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: <#T##NSCoder#>)
    }
    
    @IBAction func numbers(_ sender: UIButton) {
        if(label.text! == "0" || label.text! == ERROR_MESSAGE || needSecondNum){
            label.text = String(sender.tag - 1)
        }else{
            appendToDisplay(text: String(sender.tag - 1))
        }
        
        if(btnClear.titleLabel!.text != CLEAR){
            btnClear.setTitle(CLEAR, for: .normal)
        }
        
        num = Double(toParseableStr(str: label.text!))!
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
                performNecessaryParsing(arithmetic: num)
                
                break
                
            case DECIMAL_BUTTON:
                hasDecimal = (label.text?.contains("."))!
                
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
            
            if(sender.tag != PERCENT_BUTTON){
                mem = Double(toParseableStr(str: label.text!))!
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
                if(!needSecondNum){
                    mem = num
                    needSecondNum = true
                }
                
                num = Double(toParseableStr(str: label.text!))!
            }
            
        }else if(sender.tag == CLEAR_BUTTON){
            if(sender.titleLabel!.text == ALL_CLEAR){
                clearAll()
            }else if(sender.titleLabel!.text == CLEAR){
                
                //Determine if the equals button was just clicked
                if(needSecondNum && num == Double(toParseableStr(str: label.text!))){
                    clearAll()
                }else{
                    label.text = "0"
                    num = 0
                    
                    switch(operation){
                    case ADD_OPERATION:
                        operationChosen(operation: operation, sender: btnAdd)
                        break
                        
                    case SUBTRACT_OPERATION:
                        operationChosen(operation: operation, sender: btnSubtract)
                        break
                        
                    case MULTIPLY_OPERATION:
                        operationChosen(operation: operation, sender: btnMultiply)
                        break
                        
                    case DIVIDE_OPERATION:
                        operationChosen(operation: operation, sender: btnDivide)
                        break
                        
                    default:
                        break
                    }
                }
                
                sender.setTitle(ALL_CLEAR, for: .normal)
            }
        }
    }
    
    private func clearAll() -> Void{
        label.text = "0"
        num = 0
        mem = 0
        operation = ""
        needSecondNum = false
        unselectFuncButtons()
    }
    
    private func performNecessaryParsing(arithmetic: Double) -> Void{
        //Determine if the number is just an integer, i.e., don't display 7 as 7.0
        let trunc: Int = (arithmetic - floor(arithmetic) == 0.0) ? Int(arithmetic) : 0
        
        //If the truncation flag is set to 0 then the arithmetic has a decimal
        let parseStr: String = trunc == 0 && arithmetic != 0.0 ? String(arithmetic) : String(trunc)
        
        label.text = formatNumber(numStr: parseStr)
    }
    
    private func operationChosen(operation: String, sender: UIButton) -> Void{
        self.operation = operation
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
        if((label.text?.characters.count)! < MAX_CHAR_COUNT){
            let append: String = label.text! + text
            label.text! = text == "." ? label.text! + text : formatNumber(numStr: append)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.isUserInteractionEnabled = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(labelTapped))
        
        label.addGestureRecognizer(tap)
        tap.delegate = self as? UIGestureRecognizerDelegate
    }
    
    private func formatNumber(numStr: String) -> String{
        let numDbl: Double = Double(toParseableStr(str: numStr))!
        let numToFmt: NSNumber = NSNumber(value: numDbl)
        
        //Only variably reduce the amount of decimal digits to show until a decimal point has been added
        if(!hasDecimal){
            numberFormatter.maximumFractionDigits = MAX_CHAR_COUNT - numStr.characters.count
        }
        
        return numberFormatter.string(from: numToFmt)!
    }
    
    private func toParseableStr(str: String) -> String{
        return str.components(separatedBy: ",").joined(separator: "")
    }
    
    @objc private func labelTapped(sender: UITapGestureRecognizer) -> Void{
        currentColor = (currentColor < (COLORS.count - 1)) ? currentColor + 1 : 0
        
        let foreground: UIColor = (currentColor == 1 || currentColor == 2) ? UIColor.black : UIColor.white
        
        btnDivide.backgroundColor = COLORS[currentColor]
        btnDivide.setTitleColor(foreground, for: .normal)
        
        btnMultiply.backgroundColor = COLORS[currentColor]
        btnMultiply.setTitleColor(foreground, for: .normal)
        
        btnSubtract.backgroundColor = COLORS[currentColor]
        btnSubtract.setTitleColor(foreground, for: .normal)
        
        btnAdd.backgroundColor = COLORS[currentColor]
        btnAdd.setTitleColor(foreground, for: .normal)
        
        btnEquals.backgroundColor = COLORS[currentColor]
        btnEquals.setTitleColor(foreground, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

