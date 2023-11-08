//
//  SignUpViewController.swift
//  Balance Buddy
//
//  Created by Student on 11/10/23.
//  Copyright © 2023 Student. All rights reserved.
//

import UIKit
import Foundation
import WebKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var webview: WKWebView!
    
    @IBOutlet weak var agelbl: UILabel!
    
    @IBOutlet weak var sliderBtn: UISlider!
    @IBAction func handleAgeChange(_ sender: Any) {
        agelbl.text = String(Int(sliderBtn.value))
    }
    
    
    @IBAction func showTermsAndConditions(_ sender: Any) {
        let url = URL(string: "https://balancebuddy.netlify.app/")
        let myRequest = URLRequest(url: url!)
        webview.load(myRequest)
    }
    
    @IBOutlet weak var acceptBtn: UISwitch!
    
    
    @IBOutlet weak var createAccBtn: UIButton!
    
    @IBAction func acceptFunction(_ sender: Any) {
        if acceptBtn.isOn {
            createAccBtn.isEnabled = true
        }
        else {
            createAccBtn.isEnabled = false
        }
    }
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var pin: UITextField!
    
    @IBAction func createAccount(_ sender: Any) {
        if(name.text == "") {
            let alrt = UIAlertController(title: "Error", message: "Please Enter Name", preferredStyle: UIAlertController.Style.alert)
            alrt.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alrt, animated: true, completion: nil)
            return;
        }
        else if(email.text == "") {
            let alrt = UIAlertController(title: "Error", message: "Please Enter Email", preferredStyle: UIAlertController.Style.alert)
            alrt.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alrt, animated: true, completion: nil)
            return;
        } else if(password.text == "") {
            let alrt = UIAlertController(title: "Error", message: "Please Enter Password", preferredStyle: UIAlertController.Style.alert)
            alrt.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alrt, animated: true, completion: nil)
            return;
        } else if(pin.text == ""){
            let alrt = UIAlertController(title: "Error", message: "Please Enter Pin", preferredStyle: UIAlertController.Style.alert)
            alrt.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alrt, animated: true, completion: nil)
            return;
        }
        
        let user = User(username: name.text!, useremail: email.text!,userpassword: password.text!, userpin: Int(pin.text!)!)
        let userAdded = Data.shared.addUser(userToAdd: user)
        
        var action = {
            (a:UIAlertAction) -> Void in
            self.navigationController?.popViewController(animated: true)
        }
        if(userAdded){
            let alrt = UIAlertController(title: "Success", message: "Account Created", preferredStyle: UIAlertController.Style.alert)
            alrt.addAction(UIAlertAction(title: "Login Now", style: UIAlertAction.Style.default, handler: action))
            present(alrt, animated: true, completion: nil)
        }
        else {
            let alrt = UIAlertController(title: "Error", message: "Account Already Exists", preferredStyle: UIAlertController.Style.alert)
            alrt.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alrt, animated: true, completion: nil)
        }
    }
    
//    @IBAction func goBack(_ sender: Any) {
//            dismiss(animated: true, completion: nil)
//
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
