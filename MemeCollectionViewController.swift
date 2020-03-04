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

//        self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        collectionView!.reloadData()

    }

    override func numberOfSections (in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView (_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView (_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemeCollectionViewCell.ReuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[indexPath.row]
            
        cell.collectionImageView.image = meme.memedImage
        cell.collectionImageView.contentMode = .scaleToFill

        return cell

    }
    
    // Setup the presentation of the Detail View
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let detailController = self.storyboard!.instantiateViewController(identifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.selectedIndex = indexPath.row
        detailController.highlightedMeme = memes[indexPath.row]
        
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}

