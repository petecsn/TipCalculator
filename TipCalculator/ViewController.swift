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
    var customTip: Double = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        billField.becomeFirstResponder()
        
        if (customTip < 0) {
            tipControl.setEnabled(false, forSegmentAt: 3)
        }
    }
    
    @IBAction func onTap(_ sender: Any) {
        // dismiss keyboard
        //view.endEditing(true)
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
        let tipFormatted = formatCurreny(currency: tip)
        let totalFormatted = formatCurreny(currency: total)
        tipLabel.text = tipFormatted
        totalLabel.text = totalFormatted
    }
    
    func getTipPercentage() -> Double {
        let tipPercentages = [0.15, 0.18, 0.20, customTip]
        return tipPercentages[tipControl.selectedSegmentIndex]
    }
    
    func removeDoubleDecimalPoint() {
        let bill = billField.text!
        
        if (bill.contains("..")) {
            billField.text = bill.replacingOccurrences(of: "..", with: ".")
        }
    }
    
    // format currency to locale-specific
    func formatCurreny(currency: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let formattedCurrency = currencyFormatter.string(from: NSNumber(value: currency))!
        return formattedCurrency
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // don't need to send anything so nothing here
    }
    
    // gets called by unwind segue from SettingsViewController
    @IBAction func selectedCustomTip(_ segue: UIStoryboardSegue){
        // don't need variable for source since customTip is set in the settings vc
        // let controller = segue.source as! SettingsViewController
        
        tipControl.setEnabled(true, forSegmentAt: 3)
        tipControl.selectedSegmentIndex = 3
        tipControl.setTitle(String(Int(customTip * 100)) + "%", forSegmentAt: 3)
        calculateTip(true)
    }
    
}

