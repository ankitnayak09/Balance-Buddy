//
//  DashboardViewController.swift
//  Balance Buddy
//
//  Created by Student on 11/10/23.
//  Copyright © 2023 Student. All rights reserved.
//

import UIKit
import AVKit

class DashboardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var email:String!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    
    var transactions:[Transaction] = [];

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lbl.text = Data.shared.curUser!.name
        balanceLbl.text = balanceLbl.text! + String(Data.shared.curUser!.balance)
        startAnimate()
        
        for transaction in Data.shared.Transactions {
            if(transaction.from.email == Data.shared.curUser?.email || transaction.to.email
               == Data.shared.curUser?.email) {
                transactions.append(transaction);
            }
        }
    }
    
    @IBOutlet weak var imgViewer: UIImageView!
    var imgSet: [UIImage] = [UIImage(named: "offers1")!,UIImage(named: "offers2")!,UIImage(named: "offers3")!]
    
    func startAnimate() {
        imgViewer.animationImages = imgSet
        imgViewer.animationDuration = 3
        imgViewer.animationRepeatCount = 0
        imgViewer.startAnimating()
    }
    
    func stopAnimate() {
        imgViewer.stopAnimating()
        imgViewer.image = UIImage(named:"offers1")
    }

    
    var path: String!
    var urlPath:URL!
    var player:AVPlayer!
    var videoController = AVPlayerViewController()
    
    @IBAction func showVideo(_ sender: Any) {
//        TODO: Resolve Video Player
//        path = Bundle.main.path(forResource: "piggy_video", ofType: "mp4")
        path = Bundle.main.path(forResource: "piggyvideo", ofType: "mp4")
        urlPath = URL(fileURLWithPath: path)
        player = AVPlayer(url: urlPath)
        videoController.player = player
        present(videoController, animated: true, completion: nil)
        videoController.player?.play()
    }
    
//    Transaction History Table
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellObj = tableView.dequeueReusableCell(withIdentifier: "cellObj",for: indexPath)
        if(transactions[indexPath.row].from.email == Data.shared.curUser?.email) {
            cellObj.textLabel?.text = transactions[indexPath.row].to.name
            cellObj.detailTextLabel?.text = "- \(transactions[indexPath.row].amount)"
        } else {
            cellObj.textLabel?.text = transactions[indexPath.row].from.name
            cellObj.detailTextLabel?.text = "+ \(transactions[indexPath.row].amount)"
        }
        
        return cellObj
    }
    
    
    @IBAction func addToTransactions(_ sender: Any) {
        performSegue(withIdentifier: "transactionSegue", sender: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        Data.shared.logout()
        self.navigationController?.popViewController(animated: true)
    }
        
    
}
