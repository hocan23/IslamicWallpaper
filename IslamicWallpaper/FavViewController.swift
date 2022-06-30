//
//  FavViewController.swift
//  IslamicWallpaper
//
//  Created by fdnsoft on 30.06.2022.
//

import UIKit

class FavViewController: UIViewController {
    
    @IBOutlet weak var removeAdd: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var favPhotos : [String] = []
    var favİmages : [UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        favPhotos = Utils.readLocal()
        collectionView.delegate = self
        collectionView.dataSource = self
        removeAdd.layer.borderColor = UIColor(red: 48/255, green: 62/255, blue: 100/255, alpha: 1.0).cgColor
        removeAdd.layer.borderWidth = 3
        removeAdd.layer.cornerRadius = 17
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        findPhoto()
    }
    
    @IBAction func removeAddTapped(_ sender: Any) {
    }
    func findPhoto (){
        for a  in favPhotos{
            print(a)
            favİmages.append(UIImage(named: a )!)
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension FavViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favPhotos.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoritecell", for: indexPath) as! FavoriteCollectionViewCell
        if favİmages.count != 0{
            cell.imageView.image = favİmages[indexPath.row]
            cell.layer.cornerRadius = 20
            cell.backgroundColor = .red
            cell.layer.masksToBounds = true
        }
        
        
        
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        // The row value is the same as the index of the desired text within the array.
        
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FullScreenViewController") as! FullScreenViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.selectedPhoto = favİmages[indexPath.row]
        self.present(newViewController, animated: true, completion: nil)
        print("You selected cell #\(indexPath.item)!")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.bounds.width/2-30, height: (view.bounds.width/2-30)*2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
    
}
