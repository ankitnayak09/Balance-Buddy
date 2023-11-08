//
//  AdminViewController.swift
//  Balance Buddy
//
//  Created by Student on 01/11/23.
//  Copyright © 2023 Student. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    var users: [User] = [];
    var transactions: [Transaction] = [];
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        users = Data.shared.Users
        transactions = Data.shared.Transactions;
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0) {
            return users.count;
        } else {
            return transactions.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let header = ["Users","Transactions"]
        return header[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
            var cellObj = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
            cellObj.textLabel?.text = users[indexPath.row].name
            cellObj.detailTextLabel?.text = String(users[indexPath.row].balance)
            return cellObj
        }
        else {
            var cellObj = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
            cellObj.textLabel?.text = "\(transactions[indexPath.row].from.name) -> \(transactions[indexPath.row].to.name)"
            cellObj.detailTextLabel?.text = " \(transactions[indexPath.row].amount)"
            return cellObj
        }
    }
    
    @IBOutlet weak var userSelected: UITextField!
    
    @IBOutlet weak var amountDeposit: UITextField!
    
    var selectIndex: Int = 0;
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userSelected.text = Data.shared.Users[indexPath.row].email
        selectIndex = indexPath.row
    }
    
    
    @IBAction func deposityAmount(_ sender: Any) {
        Data.shared.Users[selectIndex].balance += Int(amountDeposit.text!)!
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func logout(_ sender: Any) {
        Data.shared.logout()
        self.navigationController?.popViewController(animated: true)
    }
    
//    @IBAction func goBack(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
    
}
