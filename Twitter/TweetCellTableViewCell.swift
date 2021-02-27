//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Nancy Ng  on 2/26/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var TweetTitle: UILabel!
    @IBOutlet weak var TweetBody: UILabel!
    @IBOutlet weak var TweetImage: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
