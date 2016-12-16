//
//  SentMemesCollectionVC.swift
//  MemeMe
//
//  Created by Ha Na Gill on 12/10/16.
//  Copyright © 2016 Ha Na Gill. All rights reserved.
//

import UIKit

class SentMemesCollectionVC: UICollectionViewController {
    
    @IBAction func createNewMeme(_ sender: Any) {
        performSegue(withIdentifier: "createNewMeme", sender: self)
    }
    
    @IBOutlet var memesCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let cellID = "SentMemesCollectionViewCell"
    
    override func viewWillAppear(_ animated: Bool) {
        self.memesCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        
        // MARK: Set spacing between items
        let space: CGFloat = 3.0
        let viewWidth = self.view.frame.width
        let viewHeight = self.view.frame.height
        let dimension: CGFloat = (viewWidth-(2*space))/3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = memesCollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SentMemesCollectionViewCell
        let meme = appDelegate.memes[indexPath.row]
        cell.memeImagePreview.image = meme.memedImage
        cell.backgroundColor = UIColor.green

        return cell
    }

    
    
    
}
