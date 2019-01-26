//
//  CalculatorLogin.swift
//  Calculator
//
//  Created by Kapil Rathore on 09/11/17.
//  Copyright © 2017 Kapil Rathore. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: [String: Operation] = [
        "𝛑": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        
        "√": Operation.unaryOperation(sqrt),
        "±": Operation.unaryOperation({ -$0 }),
        
        "+": Operation.binaryOperation({ $0 + $1 }),
        "-": Operation.binaryOperation({ $0 - $1 }),
        "÷": Operation.binaryOperation({ $0 / $1 }),
        "x": Operation.binaryOperation({ $0 * $1 }),
        
        "=": Operation.equals
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            
            switch operation {
            
            case .constant(let value):
                accumulator = value
                
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
                
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                }
                
            case .equals:
                if pendingBinaryOperation != nil && accumulator != nil {
                    accumulator = pendingBinaryOperation!.performOperation(with: accumulator!)
                    pendingBinaryOperation = nil
                }
            }
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func performOperation(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
}
