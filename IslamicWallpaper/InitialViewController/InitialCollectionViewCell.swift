//
//  InitialCollectionViewCell.swift
//  IslamicWallpaper
//
//  Created by fdnsoft on 8.07.2022.
//

import UIKit

class InitialCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    override var isHighlighted: Bool {
      didSet {
        UIView.animate(withDuration: 0.7) {
          let scale: CGFloat = 0.9
          self.transform = self.isHighlighted ? CGAffineTransform(scaleX: scale, y: scale) : .identity
        }
      }
    }
}
