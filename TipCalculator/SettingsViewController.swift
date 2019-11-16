//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by peter on 11/15/19.
//  Copyright © 2019 peter. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    var customTipFromSettings: Double!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.minimumValue = 0
        stepper.maximumValue = 100
        stepper.value = 25
        changeStepperValue(stepper)
    }
    
    @IBAction func changeStepperValue(_ sender: UIStepper) {
        valueLabel.text = String(Int(sender.value))
        customTipFromSettings = sender.value
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "PickedTipSegue") {
            let vc = segue.destination as? ViewController
            vc?.customTip = customTipFromSettings / 100
        }
    }
}
