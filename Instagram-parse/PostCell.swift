//
//  PostCell.swift
//  Instagram-parse
//
//  Created by Derrick Wong on 2/28/17.
//  Copyright © 2017 Derrick Wong. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCell: UITableViewCell {
    
    
    @IBOutlet weak var postCaption: UILabel!
    @IBOutlet weak var postImage: PFImageView!
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
