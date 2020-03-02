//
//  MemeCollectionViewCollectionViewController.swift
//  MeMeOG
//
//  Created by Nedra Mevoli on 2/28/20.
//  Copyright © 2020 Nedra Mevoli. All rights reserved.
//

import UIKit
import Foundation

class MemeCollectionViewController: UICollectionViewController{
        
    @IBOutlet weak var editButton: UIButton!
    
    var memes: [Meme]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        collectionView.register(UINib(nibName: "MemeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MemeCollectionViewCell.ReuseIdentifier)
//        collectionView.register(MemeCollectionViewCell.self, forCellWithReuseIdentifier: MemeCollectionViewCell.ReuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        collectionView!.reloadData()
//        self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes

    }

    override func numberOfSections (in collectionView: UICollectionView) -> Int {
        return memes.count
    }

    override func collectionView (_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView (_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemeCollectionViewCell.ReuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[indexPath.row]
            
        cell.collectionImageView.image = meme.memedImage
   
        return cell

    }
    
}
