//
//  SettingsViewController.swift
//  IslamicWallpaper
//
//  Created by fdnsoft on 30.06.2022.
//

import UIKit
import GoogleMobileAds


class SettingsViewController: UIViewController , GADBannerViewDelegate, GADFullScreenContentDelegate,LangChange{
    @IBOutlet weak var backButton: UIButton!
    var isAd : Bool = false
    private var interstitial: GADInterstitialAd?

    func changelang() {
//        titleLabel.text = Helper.settings[Helper.SelectedlanguageNumber]
        print(Helper.shareapp[Helper.SelectedlanguageNumber])
        print(Helper.SelectedlanguageNumber)
        shareButton.setTitle(Helper.shareapp[Helper.SelectedlanguageNumber], for: .normal)
        otherApps.setTitle(Helper.otherapps[Helper.SelectedlanguageNumber], for: .normal)
        languageButton.setTitle(Helper.language[Helper.SelectedlanguageNumber], for: .normal)
        backButton.setTitle(Helper.settings[Helper.SelectedlanguageNumber], for: .normal)

        if self.traitCollection.userInterfaceStyle == .dark {
//            titleLabel.textColor = .white
            shareButton.tintColor = .white
            otherApps.tintColor = .white
            languageButton.tintColor = .white
        }    }
    
    
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var otherApps: UIButton!
    @IBOutlet weak var languageButton: UIButton!
    var bannerView: GADBannerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do something
        
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = Utils.bannerId
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        titleLabel.text = Helper.settings[Helper.SelectedlanguageNumber]
        createAdd()
        backButton.setTitle(Helper.settings[Helper.SelectedlanguageNumber], for: .normal)
        print(Helper.shareapp[Helper.SelectedlanguageNumber])
        print(Helper.SelectedlanguageNumber)
        shareButton.setTitle(Helper.shareapp[Helper.SelectedlanguageNumber], for: .normal)
        otherApps.setTitle(Helper.otherapps[Helper.SelectedlanguageNumber], for: .normal)
        languageButton.setTitle(Helper.language[Helper.SelectedlanguageNumber], for: .normal)
        if self.traitCollection.userInterfaceStyle == .dark {
//            titleLabel.textColor = .white
            shareButton.tintColor = .white
            otherApps.tintColor = .white
            languageButton.tintColor = .white
        }
        if isAd == true {
            self.dismiss(animated: true)
            
        }
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
    @IBAction func sharePressed(_ sender: Any) {
        if let name = URL(string: "https://apps.apple.com/us/app/islamic-wallpaper-hd-pro/id1632238123"), !name.absoluteString.isEmpty {
            let objectsToShare = [name]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        } else {
            // show alert for not available
        }
        //        UIGraphicsBeginImageContext(view.frame.size)
        //                view.layer.render(in: UIGraphicsGetCurrentContext()!)
        //                let image = UIGraphicsGetImageFromCurrentImageContext()
        //                UIGraphicsEndImageContext()
        //
        //                let textToShare = "Check out my app"
        //
        //                if let myWebsite = URL(string: " https://apps.apple.com/us/app/islamic-wallpaper-hd-pro/id1632238123") {//Enter link to your app here
        //                    let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "app-logo")] as [Any]
        //                    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        //
        //                    //Excluded Activities
        //                    activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
        //                    //
        //
        //                    activityVC.popoverPresentationController?.sourceView = sender as? UIView
        //                    self.present(activityVC, animated: true, completion: nil)
        //                }
    }
    
    @IBAction func otherApps(_ sender: Any) {
        if let url = URL(string: "https://apps.apple.com/tr/developer/mehmet-rasit-arisu/id1346135076?see-all=i-phonei-pad-apps") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func languagePressed(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "LanguageSelectionViewController") as! LanguageSelectionViewController
        newViewController.delegate = self
        self.present(newViewController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        if interstitial != nil {
            interstitial?.present(fromRootViewController: self)
            isAd = true
            
        } else {
            print("Ad wasn't ready")
            self.dismiss(animated: true)
        }    }
    
    
    
    
    
}
