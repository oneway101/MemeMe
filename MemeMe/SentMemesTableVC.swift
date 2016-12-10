//
//  SentMemesTableVC.swift
//  MemeMe
//
//  Created by Ha Na Gill on 12/7/16.
//  Copyright © 2016 Ha Na Gill. All rights reserved.
//

import UIKit

class sentMemesTableVC: UITableViewController {
    
    @IBAction func createNewMeme(_ sender: Any) {
        performSegue(withIdentifier: "createNewMeme", sender: self)
    }
    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var memes = appDelegate.memes
    }
    
}
