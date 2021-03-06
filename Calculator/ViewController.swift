//
//  ViewController.swift
//  Calculator
//
//  Created by 钱恒 on 15/11/23.
//  Copyright © 2015年 East China University of Science and Technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    var existDot = false
    
    var brain = CalculatorBrain()  //Model part
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
            existDot = false
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0  //displayValue = nil
            }
        }
    }

    @IBAction func appendDot(sender: UIButton) {
        if !existDot {
            display.text = display.text! + "."
            existDot = true
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0  //displayValue = nil
        }
    }
    
    @IBAction func cleanAll(sender: UIButton) {
        display.text = "0"
        userIsInTheMiddleOfTypingANumber = false
        existDot = false
        brain.cleanOpStack()
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
}

