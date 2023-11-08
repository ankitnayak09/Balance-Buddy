//
//  TransactionViewController.swift
//  Balance Buddy
//
//  Created by Himanshi Rathore on 04/11/23.
//  Copyright © 2023 Student. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var accountId: UITextField!
    @IBOutlet weak var accountHolder: UITextField!
    @IBOutlet weak var amount: UITextField!
    var isValid: Bool!
    
    
    @IBAction func getAccountId(_ sender: Any) {
        if(Int(accountId.text!)! >= Data.shared.Users.count) {
            accountHolder.text = "Invalid Account Id";
            accountHolder.textColor = UIColor.red;
            isValid = false
        }
        else {
            accountHolder.textColor = UIColor.black; 
            var toUser = Data.shared.Users[Int(accountId.text!)!];
            if(Data.shared.curUser?.email != toUser.email
            ){
                accountHolder.text = toUser.name
                isValid = true
            }
            else {
                accountHolder.text = "Cannot Send Money to Yourself"
                accountHolder.textColor = UIColor.red
                isValid=false
            }
        }
    }
    
    
    @IBAction func performTransaction(_ sender: Any) {
        if(!isValid){ return };
        var toUser = Data.shared.Users[Int(accountId.text!)!];
        if(Data.shared.curUser?.email == toUser.email) {
            return;
        }
        if(Int(Data.shared.curUser!.balance) >= Int(amount.text!)!) {
            var transactionData = Transaction(fromUser: Data.shared.curUser!, toUser: toUser, amountTransfer: Int(amount.text!)!)
            Data.shared.addTransaction(transaction: transactionData)
            performSegue(withIdentifier: "confirmSegue", sender: self)
        }
        else {
            var alrt = UIAlertController(title: "Error", message: "Insufficient Balance", preferredStyle: UIAlertController.Style.alert)
            alrt.addAction(UIAlertAction(title: "Re-Enter Amount", style: UIAlertAction.Style.cancel))
            present(alrt, animated: true)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "confirmSegue" {
            var dest = segue.destination as! ConfirmTransactionViewController
            dest.accountId = accountId.text!
            dest.accountHolder = accountHolder.text!
            dest.amount = amount.text!
        }
    }
    
//    Segmented Index
    
    @IBOutlet weak var messageImageView: UIImageView!
    
    @IBOutlet weak var segBtn: UISegmentedControl!
    
    @IBAction func segAction(_ sender: Any) {
        switch segBtn.selectedSegmentIndex {
        case 0:
            messageImageView.image = UIImage(named:"Do")
        default:
            messageImageView.image = UIImage(named:"Don't")
        }
    }
    
}
