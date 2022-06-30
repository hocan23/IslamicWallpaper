//
//  FullScreenViewController.swift
//  IslamicWallpaper
//
//  Created by Hasan onur Can on 29.06.2022.
//

import UIKit

class FullScreenViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var favorite: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var share: UIImageView!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    var selectedPhoto : UIImage?
    var favoritePhotos : [String] = []
    
    @IBOutlet weak var removeadd: UIButton!
    @IBOutlet weak var favoriteIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritePhotos = Utils.readLocal()
        isfavorite()
        backButton.layer.cornerRadius = 17
        backButton.clipsToBounds = true
        downloadButton.layer.cornerRadius = 25
        downloadButton.clipsToBounds = true
        bottomView.layer.cornerRadius = 27
        imageView.image = selectedPhoto
        removeadd.layer.borderColor = UIColor(red: 48/255, green: 62/255, blue: 100/255, alpha: 1.0).cgColor
        removeadd.layer.borderWidth = 3
        removeadd.layer.cornerRadius = 17
        
        favorite.isUserInteractionEnabled = true
        favorite.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favoriteTapped)))
        // Do any additional setup after loading the view.
    }
    @objc func favoriteTapped(_ recognizer: UITapGestureRecognizer) {
       findPhoto()
        Utils.saveLocal(array: favoritePhotos)
        print(favoritePhotos)
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//        newViewController.modalPresentationStyle = .fullScreen
//
//        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func downloadButtonTapped(_ sender: Any) {
        guard let inputImage = selectedPhoto else { return }
        
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
    func isfavorite() {
        for a in favoritePhotos{
            if UIImage(named: a) == selectedPhoto {
                favoriteIcon.image = UIImage(named: "Group 52")

            }
        }
    }
    
    @IBAction func removeAddTapped(_ sender: Any) {
    }
    
    
    
    func findPhoto (){
        for a in 1..<8 {
                    print(a)
                    for i in 10..<30{
                        
                        if let c = UIImage(named: "\(a)\(i)") {
                            if c == selectedPhoto{
                                if  favoritePhotos.filter({$0 == "\(a)\(i)"}).count == 0{
                                    favoritePhotos.append( "\(a)\(i)")
                                    favoriteIcon.image = UIImage(named: "Group 52")
                                }else{
                                    favoriteIcon.image = UIImage(named: "Group 51")
                                    favoritePhotos = favoritePhotos.filter({$0 != "\(a)\(i)"})
                                }
                            }
                        }
    }
}
        Utils.saveLocal(array: favoritePhotos)
    }
    
}

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
    
}

