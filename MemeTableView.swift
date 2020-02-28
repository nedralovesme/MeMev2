//
//  MemeTableView.swift
//  MeMeOG
//
//  Created by Nedra Mevoli on 2/27/20.
//  Copyright © 2020 Nedra Mevoli. All rights reserved.
//

import UIKit
import Foundation

class MemeTableView: UITableViewController {
    
    var memes: [Meme]!
    
       override func viewDidLoad()  {
            super.viewDidLoad()
        
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            memes = appDelegate.savedMeme
        }

    override func viewWillAppear(_ animated: Bool) {
        
        // Refresh the TableViewController
            self.tableView!.reloadData()
            
            // Setting the height of each table cell
            self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "MemeCell")
            self.tableView!.rowHeight = 70
        }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")
        let _ = self.memes[indexPath.row]
            
        cell?.imageView?.contentMode = .scaleToFill
        
        return cell!
    }
    }

    
