//
//  FullScreenViewController.swift
//  IslamicWallpaper
//
//  Created by Hasan onur Can on 29.06.2022.
//

import UIKit
import GoogleMobileAds
import Lottie
import Photos
protocol SawAdInFullScreeen {
    func notShowAd()
}
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
    var isFirst : String = "true"
    var swipeCount : Int = 0
    let animationView = AnimationView()
    let animationBackView = UIView()
    var delegate : SawAdInFullScreeen?
    
    
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
        bannerView.adUnitID = Utils.bannerId
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if isAd == true {
            self.dismiss(animated: true)
            
        }
        print(Helper.download[Helper.SelectedlanguageNumber])
        downloadButton.setTitle(Helper.download[Helper.SelectedlanguageNumber], for: .normal)
        favoritePhotos = Utils.readLocal(key: "SavedStringArray")
        isfavorite()
        createAdd()
        if Utils.readLocalLang(key: "isFirst") != "false"{
            swipeAnimation()
            Utils.saveLocalLang(string: "false", key: "isFirst")
            
        }
        
    }
    func swipeAnimation () {
        animationView.animation = Animation.named("swipe")
        animationBackView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        animationBackView.layer.cornerRadius = 30
        animationBackView.center = view.center
        animationBackView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animationView.center = view.center
        animationView.loopMode = .loop
        self.animationView.isHidden = false
        
        animationView.play()
        view.addSubview(animationBackView)
        view.addSubview(animationView)
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.animationView.stop()
            self.animationView.isHidden = true
            self.animationBackView.isHidden = true
        }
    }
    func setupDownloadAnimation () {
        animationView.animation = Animation.named("download")
        animationView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        animationView.center = view.center
        animationView.loopMode = .playOnce
        self.animationView.isHidden = false
        
        animationView.play()
        
        view.addSubview(animationView)
        DispatchQueue.main.asyncAfter(deadline: .now()+1.7) {
            self.animationView.isHidden = true
            
        }
        
    }
    
    func likeAnimation () {
        animationView.animation = Animation.named("like")
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animationView.center = view.center
        animationView.loopMode = .loop
        self.animationView.isHidden = false
        
        animationView.play()
        view.addSubview(animationBackView)
        view.addSubview(animationView)
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.animationView.stop()
            self.animationView.isHidden = true
            self.animationBackView.isHidden = true
        }
    }
    
    
    
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        print(position)
        
        if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            if position < categoriPhotos.count - 1{
                position = position + 1
                print(position)
                imageView.image = categoriPhotos[position]
                
                UIView.transition(with: self.imageView,
                                  duration: 1.0,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    self.selectedPhoto = self.categoriPhotos[self.position]
                    self.isfavorite()
                    self.swipeCounter()
                    if self.position == self.categoriPhotos.count-1{
                        self.position = 0
                    }
                    
                    
                }, completion: nil)
                
            }
            isfavorite()
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            if position > 0 {
                position = position - 1
                
                imageView.image = categoriPhotos[position]
                
            }else{
                imageView.image = categoriPhotos[self.categoriPhotos.count-1]
            }
            UIView.transition(with: self.imageView,
                              duration: 1.0,
                              options: .transitionCrossDissolve,
                              animations: {
                self.selectedPhoto = self.categoriPhotos[self.position]
            }, completion: nil)
            
            isfavorite()
            swipeCounter()
            if self.position == 0{
                self.position = self.categoriPhotos.count-1
            }
        }
    }
    func swipeCounter (){
        createAdd()
        swipeCount += 1
        if swipeCount > 3{
            if interstitial != nil {
                interstitial?.present(fromRootViewController: self)
                swipeCount = 0
            } else {
                print("Ad wasn't ready")
            }
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
        backButton.zoomIn()

        if interstitial != nil {
            interstitial?.present(fromRootViewController: self)
            isAd = true
            delegate?.notShowAd()

        } else {
            print("Ad wasn't ready")
            self.dismiss(animated: true)
        }
        //        self.dismiss(animated: true)
        
    }
    
    @IBAction func downloadTapped(_ sender: UIButton) {
        
        downloadButton.zoomIn()
        
            guard let inputImage = selectedPhoto else { return }
         
        openGallery()
       
    }
    
    func createAdd() {
        let request = GADRequest()
        interstitial?.fullScreenContentDelegate = self
        GADInterstitialAd.load(withAdUnitID:Utils.fullScreenAdId,
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
    
    //
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer)->Bool {
        print("Save finished!")
        setupDownloadAnimation()
        
        return true
    }
    
    
    
    func findPhoto (){
        for a in 1..<9 {
            print(a)
            for i in 10..<40{
                
                if let c = UIImage(named: "\(a)\(i)") {
                    if c == selectedPhoto{
                        if  favoritePhotos.filter({$0 == "\(a)\(i)"}).count == 0{
                            favoritePhotos.append( "\(a)\(i)")
                            favoriteIcon.image = UIImage(named: "Group 52")
                            likeAnimation()
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
    
    func openGallery() {
        if #available(iOS 14, *) {
            let authState = PHPhotoLibrary.authorizationStatus(for: PHAccessLevel.addOnly)
            
            if authState == .notDetermined  {
                
                PHPhotoLibrary.requestAuthorization(for: .addOnly) { php in
                    if php == .authorized{
                        DispatchQueue.main.async {
                            self.writeToPhotoAlbum(image: self.selectedPhoto! )
                        }
                    }
                }
                
            }else if authState == .authorized{
                writeToPhotoAlbum(image: self.selectedPhoto! )
                
            }else{
                showAlertAction(titleText: "IslamicWallpaper HD Would Like to Access Your Photos. ", messages: "IslamicWallpaper HD  asks for permission to download the selected photo to your gallery ", alertTitle: "Settings",buttonAction: { UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!) })
                
            }
        } else {
            // Fallback on earlier versions
            writeToPhotoAlbum(image: self.selectedPhoto! )
        }
    }
    func showAlertAction(titleText:String,messages:String,alertTitle:String,buttonAction: (() -> Void)? = nil){
        let alertController = UIAlertController(title: titleText, message: messages, preferredStyle: .alert)
        let alertTitle = alertTitle
        let phoneAction = UIAlertAction(title: alertTitle, style: .default, handler: {
            alert -> Void in
            buttonAction!()
            
        })
        alertController.addAction(phoneAction)
        let cancelAction = UIAlertAction(title: "Deny", style: .destructive, handler: {
            alert -> Void in
//            self.dismiss(animated: true)
        })
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

