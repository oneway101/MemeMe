//
//  SentMemesCollectionVC.swift
//  MemeMe
//
//  Created by Ha Na Gill on 12/10/16.
//  Copyright © 2016 Ha Na Gill. All rights reserved.
//

import UIKit

class sentMemesCollectionVC: UICollectionViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBAction func createNewMeme(_ sender: Any) {
        performSegue(withIdentifier: "createNewMeme", sender: self)
    }
    
    
}
