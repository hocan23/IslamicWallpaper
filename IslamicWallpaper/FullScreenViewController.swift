//
//  FullScreenViewController.swift
//  IslamicWallpaper
//
//  Created by Hasan onur Can on 29.06.2022.
//

import UIKit
import GoogleMobileAds

class FullScreenViewController: UIViewController, GADBannerViewDelegate, GADFullScreenContentDelegate {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var favorite: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var share: UIImageView!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    var selectedPhoto : UIImage?
    var favoritePhotos : [String] = []
    var position = Int ()
    var categoriPhotos : [UIImage] = []
    @IBOutlet weak var favoriteIcon: UIImageView!
    var bannerView: GADBannerView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
                        swipeLeft.direction = .left
                        self.view!.addGestureRecognizer(swipeLeft)
                                                         
                        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
                        swipeRight.direction = .right
                        self.view!.addGestureRecognizer(swipeRight)
        
        
        
        
        
        backButton.layer.cornerRadius = backButton.bounds.height/2
        backButton.clipsToBounds = true
        downloadButton.layer.cornerRadius = downloadButton.bounds.height/2
        downloadButton.clipsToBounds = true
        bottomView.layer.cornerRadius = bottomView.bounds.height/2
        imageView.image = selectedPhoto
       
        share.isUserInteractionEnabled = true
        share.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shareTapped)))
        favorite.isUserInteractionEnabled = true
        favorite.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favoriteTapped)))
        downloadButton.titleLabel?.text = Helper.download[Helper.SelectedlanguageNumber]
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        favoritePhotos = Utils.readLocal(key: "SavedStringArray")
        isfavorite()
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
           
           if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            if position < categoriPhotos.count - 1{
                position = position + 1
               
                imageView.image = categoriPhotos[position]
              
            }
               selectedPhoto = categoriPhotos[position]
               isfavorite()
           }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            if position > 0 {
                position = position - 1
                
                imageView.image = categoriPhotos[position]
                
            }
            selectedPhoto = categoriPhotos[position]
            isfavorite()
           }
    }
    @objc func favoriteTapped(_ recognizer: UITapGestureRecognizer) {
       findPhoto()
        
    }
    
    @objc func shareTapped(_ recognizer: UITapGestureRecognizer) {
        let image = selectedPhoto
                
                // set up activity view controller
                let imageToShare = [ image! ]
                let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                
                // exclude some activity types from the list (optional)
                activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
                
                // present the view controller
                self.present(activityViewController, animated: true, completion: nil)
            
        
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
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      // Add banner to view and add constraints as above.
      addBannerViewToView(bannerView)
    }

    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: bottomLayoutGuide,
                              attribute: .top,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
    }

    func isfavorite() {
        for a in favoritePhotos{
            if UIImage(named: a) == selectedPhoto {
                favoriteIcon.image = UIImage(named: "Group 52")

            }else{
                favoriteIcon.image = UIImage(named: "Group 51")

            }
        }
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
        Utils.saveLocal(array: favoritePhotos, key: "SavedStringArray")
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

