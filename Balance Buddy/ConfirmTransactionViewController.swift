//
//  ConfirmTransactionViewController.swift
//  Balance Buddy
//
//  Created by Himanshi Rathore on 04/11/23.
//  Copyright © 2023 Student. All rights reserved.
//

import UIKit

class ConfirmTransactionViewController: UIViewController {

    var accountId: String = "";
    var accountHolder: String = "";
    var amount: String = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        accId.text! += accountId;
        accHolderlbl.text! += accountHolder;
        amountlbl.text! += amount;
    }

    @IBOutlet weak var accId: UILabel!
    @IBOutlet weak var accHolderlbl: UILabel!
    @IBOutlet weak var amountlbl: UILabel!
    
    @IBOutlet weak var pinInput: UITextField!
    
    @IBAction func doTransaction(_ sender: Any) {
        if(pinInput.text == ""){
            var alrt = UIAlertController(title: "Error", message: "Enter Pin", preferredStyle: UIAlertController.Style.actionSheet)
            alrt.addAction(UIAlertAction(title: "Re-Enter Pin", style: UIAlertAction.Style.cancel))
            present(alrt, animated: true)
            return ;
        }
        var toUser = Data.shared.Users[Int(accountId)!]
        if(Int(pinInput.text!)! == Data.shared.curUser?.pin) {
            for user in Data.shared.Users {
                if(user.email == Data.shared.curUser!.email){
                    user.balance = user.balance - Int(amount)!
                }
                if(user.email == toUser.email) {
                    user.balance = user.balance + Int(amount)!;
                }
            }
//            var alrt = UIAlertController(title: "Successfull", message: "Transaction Successfull", preferredStyle: UIAlertController.Style.actionSheet)
//            alrt.addAction(UIAlertAction(title: "Go To Dashboard", style: UIAlertAction.Style.default))
//            present(alrt, animated: true)
//            performSegue(withIdentifier: "backToDashboard", sender: self)
            self.navigationController?.popToRootViewController(animated: true)
        }else {
            var alrt = UIAlertController(title: "Error", message: "Wrong Pin", preferredStyle: UIAlertController.Style.actionSheet);
            alrt.addAction(UIAlertAction(title: "Re-Enter Pin", style: UIAlertAction.Style.default))
                        present(alrt, animated: true)
        }
    }
    
    
    @IBAction func cancelTransaction(_ sender: Any) {
            dismiss(animated: true)
    }
    
}
