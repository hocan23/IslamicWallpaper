//
//  TableviewCellController.swift
//  IslamicWallpaper
//
//  Created by Hasan onur Can on 28.06.2022.
//

import UIKit

protocol CategoriasTableViewCellDelegate {
    func selectPhotoTapped(value : Int , tableIndex : Int)
}
class TableviewCellController: UITableViewCell {
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet weak var categories: UILabel!
    var delegate : CategoriasTableViewCellDelegate?
    var array : [UIImage] = []
    var index = 0
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        seeAllButton.titleLabel?.text = Helper.seeall[Helper.SelectedlanguageNumber]
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        collectionView.reloadData()
    }
    @IBAction func seeAllTapped(_ sender: Any) {
        print("Button tag tapped")
    }
}
extension TableviewCellController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
        
        if index == 0 {
            seeAllButton.isHidden = true
        }
        if indexPath.row < array.count {
            cell.image.image = array[indexPath.item]
                }
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if index == 0 {
            return CGSize(width: 200, height: 300)

        }else{
            return CGSize(width: 125, height: 190)

        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        print(index)
        delegate?.selectPhotoTapped(value: indexPath.row, tableIndex: index)
    }
    
    
}
