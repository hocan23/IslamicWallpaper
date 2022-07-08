//
//  InitialViewController.swift
//  IslamicWallpaper
//
//  Created by fdnsoft on 8.07.2022.
//

import UIKit

    class InitialViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
      
        var titleArray  = [[Helper.copy],[Helper.allah],[Helper.qiblafinder],[Helper.hadiths],[Helper.favorites],[Helper.settings]]
        var imageArray = [UIImage(named: "islamicWallpaperIcon"),UIImage(named: "adhanTimeIcon"),UIImage(named: "QiblaFinderIcon"),UIImage(named: "40HadithIcon"),UIImage(named: "favoritesIcon"),UIImage(named: "settingsIcon")]
        @IBOutlet weak var lettersCW: UICollectionView!
        private let reuseIdentifier = "Cell"
        
        let insets = UIEdgeInsets(top: 10, left: 15, bottom: 50, right: 15)
        let spacing = CGSize(width: 5, height: 5)

        
        override func viewDidLoad() {
            super.viewDidLoad()
            
        }
        
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          
                
                return imageArray.count
                
     
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = lettersCW.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! InitialCollectionViewCell
            
            cell.imageView.image = imageArray[indexPath.row]
            
            cell.nameLabel.text = titleArray[indexPath.row][0][Helper.SelectedlanguageNumber]
            cell.layer.cornerRadius = 10
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 2, height: 2)
            cell.layer.shadowRadius = 5
            cell.layer.shadowOpacity = 0.1
            
            return cell

        }
      
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
            switch indexPath.row{
            case 0:
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
            case 1:
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "AdhanViewController") as! AdhanViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
            case 2:
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "KibleViewController") as! KibleViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
            case 3:
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "HadisViewController") as! HadisViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
            case 4:
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "FavViewController") as! FavViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
            case 5:
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
            default:
                return
            }
            
        }
        
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            spacing.height
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            spacing.width
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            insets
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
          
                
                
                let numberOfVisibleCellHorizontal: CGFloat = 2
                let horizontalOtherValues = insets.right + insets.left + (spacing.width * numberOfVisibleCellHorizontal)
                let width = (collectionView.bounds.width - horizontalOtherValues) / numberOfVisibleCellHorizontal
                
                return CGSize(width: width, height: width+30)
                
            
           
            
//            let numberOfVisibleCellHorizontal: CGFloat = 2
//            let horizontalOtherValues = insets.right + insets.left + (spacing.width * numberOfVisibleCellHorizontal)
//            let width = (collectionView.bounds.width - horizontalOtherValues) / numberOfVisibleCellHorizontal
//
//            return CGSize(width: width, height: width)
            
        }
        
        
        
    }

//    extension ViewController: DetailViewControllerDelegate{
//        func diddismis() {
//
//        }
//
        
        
        
   
