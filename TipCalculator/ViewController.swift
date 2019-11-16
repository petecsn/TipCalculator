//
//  ViewController.swift
//  TipCalculator
//
//  Created by peter on 11/15/19.
//  Copyright © 2019 peter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onTap(_ sender: Any) {
        // dismiss keyboard
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        removeDoubleDecimalPoint()
        
        // get bill amount input
        let bill = Double(billField.text!) ?? 0
        
        // calculate tip and total
        let tipPercentage = getTipPercentage()
        let tip = bill * tipPercentage
        let total = bill + tip
        
        // update tip and total labels
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    func getTipPercentage() -> Double {
        let tipPercentages = [0.15, 0.18, 0.20]
        return tipPercentages[tipControl.selectedSegmentIndex]
    }
    
    func removeDoubleDecimalPoint() {
        let bill = billField.text!
        
        if (bill.contains("..")) {
            billField.text = bill.replacingOccurrences(of: "..", with: ".")
        }
    }
}

