//  ArticlesTableViewCell.swift
//  JonesSpencer_Final
//  Created by Spencer Jones on 4/28/24.

import UIKit

class ArticlesTableViewCell: UITableViewCell {

    // Outlets
    @IBOutlet var articleTitleLabel: UILabel!
    @IBOutlet var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
