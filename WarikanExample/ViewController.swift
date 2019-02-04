//
//  ViewController.swift
//  WarikanExample
//
//  Created by MURAKAMI on 2019/02/04.
//  Copyright © 2019 MURAKAMI. All rights reserved.
//

import UIKit
import Foundation

fileprivate extension UIColor {
    func toUIImage() -> UIImage {
        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var peopleNumberField: UITextField!
    @IBOutlet weak var unitField: UITextField!
    
    @IBOutlet weak var amountErrorLbl: UILabel!
    @IBOutlet weak var peopleNumberErrorLbl: UILabel!
    @IBOutlet weak var unitErrorLbl: UILabel!
    
    @IBOutlet weak var calcBtn: UIButton!
    
    @IBOutlet weak var payPerPersonLbl: UILabel!
    @IBOutlet weak var kickBackLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func initUI() {
        calcBtn.setBackgroundImage(UIColor(red: 3.0/255,
                                           green: 218.0/255,
                                           blue: 198.0/255,
                                           alpha: 0.8).toUIImage(),
                                   for: .normal)
        calcBtn.setBackgroundImage(UIColor(red: 3.0/255,
                                           green: 218.0/255,
                                           blue: 198.0/255,
                                           alpha: 0.4).toUIImage(),
                                   for: .highlighted)
        calcBtn.clipsToBounds = true
        calcBtn.layer.cornerRadius = 8.0
        
        payPerPersonLbl.isHidden = true
        kickBackLbl.isHidden = true
        
        amountField.layer.borderColor = UIColor.darkText.cgColor
        amountField.layer.borderWidth = 1.0
        peopleNumberField.layer.borderColor = UIColor.darkText.cgColor
        peopleNumberField.layer.borderWidth = 1.0
        unitField.layer.borderColor = UIColor.darkText.cgColor
        unitField.layer.borderWidth = 1.0
        
        amountErrorLbl.isHidden = true
        peopleNumberErrorLbl.isHidden = true
        unitErrorLbl.isHidden = true
    }
    
    @IBAction func calc(_ sender: Any) {
        initUI()
        let res = CalcController().tapCalcBtn(payUnitStr: unitField.text,
                                    amountStr: amountField.text,
                                    peopleNumberStr: peopleNumberField.text)
        handleResult(result: res)
    }
    
    private func handleResult(result: SplitBillResult) {
        switch result {
        case .sucsess(let pay):
            payPerPersonLbl.isHidden = false
            payPerPersonLbl.text = String(pay.payPerPerson) + " 円"
            kickBackLbl.isHidden = false
            kickBackLbl.text = String(pay.kickback) + " 円"
        case .failure(error: let error):
            switch(error) {
            case .amount:
                amountField.layer.borderColor = UIColor.red.cgColor
                amountErrorLbl.isHidden = false
                amountErrorLbl.text = error.localizedDescription
            case .peopleNumber:
                peopleNumberField.layer.borderColor = UIColor.red.cgColor
                peopleNumberErrorLbl.isHidden = false
                peopleNumberErrorLbl.text = error.localizedDescription
            case .payUnit:
                unitField.layer.borderColor = UIColor.red.cgColor
                unitErrorLbl.isHidden = false
                unitErrorLbl.text = error.localizedDescription
            }
        }
    }
}

class CalcController {
    func tapCalcBtn(payUnitStr: String?, amountStr: String?, peopleNumberStr: String?) -> SplitBillResult {
        guard let amount = UInt.init(amountStr ?? "") else { return SplitBillResult.failure(error: .amount) }
        guard let peopleNumber = UInt.init(peopleNumberStr ?? "") else { return SplitBillResult.failure(error: .peopleNumber) }
        guard let payUnit = UInt.init(payUnitStr ?? "") else { return SplitBillResult.failure(error: .payUnit) }
        
        return SplitBillResult.splitBill(payUnit: payUnit, amount: amount, peopleNumber: peopleNumber)
    }
}
