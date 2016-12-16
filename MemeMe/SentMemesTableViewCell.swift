//
//  SentMemesTableViewCell.swift
//  MemeMe
//
//  Created by Ha Na Gill on 12/14/16.
//  Copyright © 2016 Ha Na Gill. All rights reserved.
//

import UIKit

class SentMemesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memeImagePreview: UIImageView!
    @IBOutlet weak var sentTopText: UILabel!
    @IBOutlet weak var sentBottomText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
