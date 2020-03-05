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
    @IBOutlet weak var button: UIBarButtonItem!
    @IBOutlet weak var new: UIButton!
    @IBOutlet weak var label: UILabel!

       override func viewDidLoad()  {
            super.viewDidLoad()

                }

    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        // Refresh the TableViewController
            self.tableView!.reloadData()
            self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "MemeCell")
            self.tableView.rowHeight = 120
        }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
                            
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let meme = memes[indexPath.row]
            
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = "\(meme.topTextField) ... " + "\(meme.bottomTextField)"
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let detailController = storyboard!.instantiateViewController(identifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.selectedIndex = indexPath.row
        detailController.highlightedMeme = memes[indexPath.row]
        
        self.navigationController!.pushViewController(detailController, animated: true)
}
}
