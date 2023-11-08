//
//  ViewController.swift
//  Balance Buddy
//
//  Created by Student on 11/10/23.
//  Copyright © 2023 Student. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a
        var _ = Data.shared.addUser(userToAdd: User(username: "Ankit", useremail: "ankit@gmail.com", userpassword: "ankit", userpin: 1234))
        _ = Data.shared.addUser(userToAdd: User(username: "Rahul", useremail: "rahul@gmail.com", userpassword: "rahul", userpin: 4321))
        _ = Data.shared.addUser(userToAdd: User(username: "Sahil", useremail: "sahil@gmail.com", userpassword: "sahil", userpin: 1243))
        _ = Data.shared.addUser(userToAdd: User(username: "Revant", useremail: "revant@gmail.com", userpassword: "revant", userpin: 1243))
    }

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    var path : String!
    var urlPath: URL!
    var btnAudio:AVAudioPlayer!
    var user: User?
    
    
    @IBAction func login(_ sender: Any) {

        
        if(email.text == "") {
            let alrt = UIAlertController(title: "Error", message: "Please Enter Email", preferredStyle: UIAlertController.Style.alert)
            alrt.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alrt, animated: true, completion: nil)
            return;
        }
        else if(password.text == ""){
            let alrt = UIAlertController(title: "Error", message: "Please Enter Password", preferredStyle: UIAlertController.Style.alert)
            alrt.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alrt, animated: true, completion: nil)
            return;
        }
        
        user = Data.shared.getUser(useremail: email.text!, userpassword: password.text!)
        
        if(email.text=="admin@gmail.com" && password.text == "admin") {
            performSegue(withIdentifier: "adminSegue", sender: self)
        }
        else {
            if(user == nil) {
                let alrt = UIAlertController(title: "Error", message: "Invalid Credentials", preferredStyle: UIAlertController.Style.alert)
                alrt.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: nil))
                present(alrt, animated: true, completion: nil)
                return;
            }
            do {
                path = Bundle.main.path(forResource: "clickMusic", ofType: "mp3")
                urlPath = URL(fileURLWithPath: path!)
                btnAudio = try AVAudioPlayer(contentsOf: urlPath)
                btnAudio.play()
            }
            catch {
                //                print("Cant Play Audio")
            }
            performSegue(withIdentifier: "displayDashboard", sender: nil)
        }
    }
    
    
    @IBAction func goToSignup(_ sender: Any) {
        do {
            path = Bundle.main.path(forResource: "clickMusic", ofType: "mp3")
            urlPath = URL(fileURLWithPath: path!)
            btnAudio = try AVAudioPlayer(contentsOf: urlPath)
            btnAudio.play()
        }
        catch {
            //                print("Cant Play Audio")
        }
        performSegue(withIdentifier: "signup", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signup" {
            var dest = segue.destination as!  SignUpViewController
        }
        else if segue.identifier == "displayDashboard" {
            var dest = segue.destination as!  DashboardViewController
//            dest.user = user;
        } else {
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}

