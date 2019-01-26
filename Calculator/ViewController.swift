//
//  ViewController.swift
//  Calculator
//
//  Created by Kapil Rathore on 09/11/17.
//  Copyright © 2017 Kapil Rathore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var userInTheMiddleOfTyping = false
    
    var displayValue: Double {
        get {
            return Double(resultLabel.text!)!
        }
        set {
            resultLabel.text = String(newValue)
        }
    }
    
    private var calculatorLogic = CalculatorLogic()
    
    @IBAction func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        if userInTheMiddleOfTyping {
            let currentlyInDisplay = resultLabel.text!
            resultLabel.text = currentlyInDisplay + digit
        } else {
            resultLabel.text = digit
            userInTheMiddleOfTyping = true
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userInTheMiddleOfTyping {
            calculatorLogic.setOperand(displayValue)
            userInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            calculatorLogic.performOperation(mathematicalSymbol)
        }
        
        if let result = calculatorLogic.result {
            displayValue = result
        }
    }
}

