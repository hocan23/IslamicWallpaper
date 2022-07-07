//
//  HadisTableViewCell.swift
//  IslamicWallpaper
//
//  Created by fdnsoft on 6.07.2022.
//

import UIKit

class HadisTableViewCell: UITableViewCell {
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        copyButton.layer.cornerRadius = 10
        
        copyButton.layer.cornerRadius = 10
        copyButton.layer.maskedCorners = [.layerMinXMaxYCorner]
        shareButton.layer.cornerRadius = 10
        shareButton.layer.maskedCorners = [.layerMaxXMaxYCorner]


    }
    
}
