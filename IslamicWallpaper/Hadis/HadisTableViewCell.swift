//
//  HadisTableViewCell.swift
//  IslamicWallpaper
//
//  Created by fdnsoft on 6.07.2022.
//

import UIKit

class HadisTableViewCell: UITableViewCell {
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        shareButton.setTitle(Helper.share[Helper.SelectedlanguageNumber], for: .normal)
        copyButton.setTitle(Helper.copy[Helper.SelectedlanguageNumber], for: .normal)
        super.setSelected(selected, animated: animated)
        copyButton.layer.cornerRadius = 12
        view.layer.cornerRadius = 12
        copyButton.layer.cornerRadius = 12
        copyButton.layer.maskedCorners = [.layerMinXMaxYCorner]
        shareButton.layer.cornerRadius = 12
        shareButton.layer.maskedCorners = [.layerMaxXMaxYCorner]
        if self.traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = UIColor(red: 47/255, green: 54/255, blue: 65/255, alpha: 100)
            shareButton.backgroundColor = UIColor(red: 66/255, green: 187/255, blue: 115/255, alpha: 100)
            copyButton.backgroundColor = UIColor(red: 84/255, green: 222/255, blue: 139/255, alpha: 100)


        }

    }
    @IBAction func shareTapped(_ sender: Any) {
        shareButton.zoomIn()
    }
    @IBAction func copyTapped(_ sender: UIButton) {
        copyButton.zoomIn()

    }
    
}
