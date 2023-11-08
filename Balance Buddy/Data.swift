//
//  Data.swift
//  Balance Buddy
//
//  Created by Student on 11/10/23.
//  Copyright © 2023 Student. All rights reserved.
//
import Foundation

class User {
    var name: String
    var email:String
    var password:String
    var pin:Int
    var balance:Int
    
    init(username:String,useremail:String,userpassword:String,userpin:Int) {
        name=username
        email=useremail
        password=userpassword
        pin=userpin
        balance = 1000
    }
}

class Transaction {
    var from: User
    var to: User
    var amount: Int
    
    init(fromUser: User, toUser: User, amountTransfer: Int) {
        from = fromUser
        to = toUser
        amount = amountTransfer
    }
}

class Data {
    static let shared: Data = {
        let instance = Data()
        return instance
    }()
    
    var Users: [User] = [];
    var Transactions: [Transaction] = []
    var curUser: User? = nil
    func addUser(userToAdd: User) -> Bool {
        for user in Users {
            if(user.email == userToAdd.email) {
                return false;
            }
        }
        Users.append(userToAdd);
        return true;
    }
    
    func getUser(useremail:String, userpassword: String) -> User? {
        for user in Users {
            if user.email == useremail && user.password == userpassword {
                curUser = user
                return user
            }
        }
        return nil
    }
    
    func addTransaction(transaction: Transaction) {
        Transactions.append(transaction)
    }
    func logout(){
        curUser = nil
    }
    
    private init() {}
}
