//
//  FullScreenViewController.swift
//  IslamicWallpaper
//
//  Created by Hasan onur Can on 29.06.2022.
//

import UIKit
import GoogleMobileAds

class FullScreenViewController: UIViewController, GADBannerViewDelegate, GADFullScreenContentDelegate  {
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
    private var interstitial: GADInterstitialAd?
    var isAd : Bool = false

    
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
        
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if isAd == true {
            self.dismiss(animated: true)

            
        }
        downloadButton.setTitle(Helper.download[Helper.SelectedlanguageNumber], for: .normal) 
        favoritePhotos = Utils.readLocal(key: "SavedStringArray")
        isfavorite()
        createAdd()

    }
    

    
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {

           if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            if position < categoriPhotos.count - 1{
                position = position + 1
                imageView.image = categoriPhotos[position]

                UIView.transition(with: self.imageView,
                                    duration: 1.0,
                                    options: .transitionCrossDissolve,
                                    animations: {
                    self.selectedPhoto = self.categoriPhotos[self.position]
                    self.isfavorite()

                  }, completion: nil)

            }
               isfavorite()
           }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            if position > 0 {
                position = position - 1

                imageView.image = categoriPhotos[position]

            }
            UIView.transition(with: self.imageView,
                                duration: 1.0,
                                options: .transitionCrossDissolve,
                                animations: {
                self.selectedPhoto = self.categoriPhotos[self.position]
              }, completion: nil)
            
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
        if interstitial != nil {
            interstitial?.present(fromRootViewController: self)
            isAd = true
        } else {
            print("Ad wasn't ready")
        }
//        self.dismiss(animated: true)

    }
    
    @IBAction func downloadTapped(_ sender: UIButton) {
//        UIView.animate(withDuration: 2.0,
//                                       delay: 0,
//                                       usingSpringWithDamping: CGFloat(0.20),
//                                       initialSpringVelocity: CGFloat(6.0),
//                                       options: UIView.AnimationOptions.allowUserInteraction,
//                                       animations: {
//                                        sender.transform = CGAffineTransform.identity
//                },
//                                       completion: { Void in()  }
//            )
        downloadButton.zoomIn()
        guard let inputImage = selectedPhoto else { return }
        
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
        
    }
    
    func createAdd() {
        let request = GADRequest()
        interstitial?.fullScreenContentDelegate = self
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
                                    request: request,
                          completionHandler: { [self] ad, error in
                            if let error = error {
                              print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                              return
                            }
                            interstitial = ad
                          }
                               )
    }
  
    func interstitialWillDismissScreen(_ ad: GADInterstitialAd) {
            print("interstitialWillDismissScreen")
        }

        //Tells the delegate the interstitial had been animated off the screen.
    
    
    
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
                break

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

