//
//  SettingsViewController.swift
//  IslamicWallpaper
//
//  Created by fdnsoft on 30.06.2022.
//

import UIKit
import GoogleMobileAds
class SettingsViewController: UIViewController , GADBannerViewDelegate, GADFullScreenContentDelegate{
  
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var otherApps: UIButton!
    @IBOutlet weak var languageButton: UIButton!
    var bannerView: GADBannerView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do something
        
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self

    }
  
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = Helper.settings[Helper.SelectedlanguageNumber]
        print(Helper.shareapp[Helper.SelectedlanguageNumber])
        print(Helper.SelectedlanguageNumber)
        shareButton.titleLabel?.text = Helper.shareapp[Helper.SelectedlanguageNumber]
        otherApps.titleLabel?.text = Helper.otherapps[Helper.SelectedlanguageNumber]
        languageButton.titleLabel?.text = Helper.language[Helper.SelectedlanguageNumber]
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
        UIGraphicsBeginImageContext(view.frame.size)
                view.layer.render(in: UIGraphicsGetCurrentContext()!)
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()

                let textToShare = "Check out my app"

                if let myWebsite = URL(string: " https://apps.apple.com/us/app/islamic-wallpaper-hd-pro/id1632238123") {//Enter link to your app here
                    let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "app-logo")] as [Any]
                    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

                    //Excluded Activities
                    activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
                    //

                    activityVC.popoverPresentationController?.sourceView = sender as? UIView
                    self.present(activityVC, animated: true, completion: nil)
                }
    }
    
    @IBAction func otherApps(_ sender: Any) {
        if let url = URL(string: "https://apps.apple.com/tr/developer/mehmet-rasit-arisu/id1346135076?see-all=i-phonei-pad-apps") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func languagePressed(_ sender: Any) {

      
    }
   
    
    
    
    

}
