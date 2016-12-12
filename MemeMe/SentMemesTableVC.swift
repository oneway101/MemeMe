//
//  SentMemesTableVC.swift
//  MemeMe
//
//  Created by Ha Na Gill on 12/7/16.
//  Copyright © 2016 Ha Na Gill. All rights reserved.
//

import UIKit

class sentMemesTableVC: UITableViewController {
    
    @IBOutlet var memesTableView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let cellID = "sentMemeCell"
    
    @IBAction func createNewMeme(_ sender: Any) {
        performSegue(withIdentifier: "createNewMeme", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(appDelegate.memes.count)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellID)!
        let meme = appDelegate.memes[(indexPath as NSIndexPath).row]
        // set the image and name
        cell.textLabel?.text = meme.topText + " " + meme.bottomText
        cell.imageView?.image = meme.memedImage
        return cell
    }
    
    
    
}
