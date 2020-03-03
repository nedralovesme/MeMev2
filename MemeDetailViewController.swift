//
//  MemeDetailViewController.swift
//  MeMeOG
//
//  Created by Nedra Mevoli on 2/28/20.
//  Copyright © 2020 Nedra Mevoli. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    var highlightedMeme: Meme!
    var selectedIndex: Int!
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        imageView!.image = highlightedMeme.memedImage
    }

}
