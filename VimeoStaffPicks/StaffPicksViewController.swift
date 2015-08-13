//
//  StaffPicksViewController.swift
//  VimeoStaffPicks
//
//  Created by Michael Updegraff on 8/10/15.
//  Copyright (c) 2015 Michael Updegraff. All rights reserved.
//

import UIKit

class StaffPicksViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var tableView: UITableView?
    
    var items: Array<Video> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Staff Picks"
        
        self.setupTableView()
        
        self.refreshItems()
    }
    
    // MARK: Setup
    
    func setupTableView() {
        let nib = UINib(nibName: "VideoCell", bundle: nil)
        self.tableView?.registerNib(nib, forCellReuseIdentifier: NSStringFromClass(VideoCell.self))
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(VideoCell.self)) as! VideoCell
        
        let video = self.items[indexPath.row]
        cell.video = video
        
        return cell
    }
    
    func refreshItems() {
        
        VimeoClient.staffpicks { (videos, error) -> Void in
            
            if let constVideos = videos {
                
                for video: Video in constVideos {
                    
                    self.items = constVideos
                    
                    self.tableView?.reloadData()
                    
                }
            }
            else {
                // TODO: Update user
            }
        }
    }
    
}
