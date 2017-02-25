//
//  MainFeedViewController.swift
//  Instagram-parse
//
//  Created by Derrick Wong on 2/25/17.
//  Copyright © 2017 Derrick Wong. All rights reserved.
//

import UIKit
import Parse

class MainFeedViewController: UIViewController {
    
    static var userDidLogutNotification = "userDidLogout"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onLogout(_ sender: Any) {
        // log the user out
        PFUser.logOutInBackground(block: { (error: Error?) -> Void in
            if let error = error {
                print(error.localizedDescription)
            } else {
                //call observer to go back to log in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: MainFeedViewController.userDidLogutNotification), object: nil )
            }
        })
        
    }
    
}
