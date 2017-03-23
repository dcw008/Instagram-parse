//
//  FeedViewController.swift
//  Instagram-parse
//
//  Created by Derrick Wong on 2/25/17.
//  Copyright © 2017 Derrick Wong. All rights reserved.
//

import UIKit
import Parse
import ParseUI
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var posts: [PFObject]!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.estimatedRowHeight = 350
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //set a timer to call the query
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(FeedViewController.onTimer), userInfo: nil, repeats: true)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        let post = posts[indexPath.row]
        cell.postCaption.text = post["caption"] as? String
        cell.postImage.file = post["image"] as? PFFile
        
        cell.postImage.loadInBackground()
        
        return cell
    }
    
    func query(){
        //query for 'Post' objects
        let query = PFQuery(className: "Post")
        //order the elements
        query.order(byDescending: "createdAt")
        //limit to 20 posts
        query.limit = 20
        
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects?.count) posts.")
                
                //set local array field to retrieved objects
                self.posts = objects
                
                //reload the tableView
                self.tableView.reloadData()
            } else {
                // Log details of the failure
                print(error!.localizedDescription)
            }
        }
    }
    
    //call the query onTimer
    func onTimer() {
        query()
    }



}
