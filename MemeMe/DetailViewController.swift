//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Ha Na Gill on 12/14/16.
//  Copyright © 2016 Ha Na Gill. All rights reserved.
//

import Foundation
import UIKit

class detailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    var selectedMeme: UIImage!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailImageView.image = selectedMeme
    }
}
