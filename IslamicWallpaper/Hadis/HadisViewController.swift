//
//  HadisViewController.swift
//  IslamicWallpaper
//
//  Created by fdnsoft on 6.07.2022.
//

import UIKit
import GoogleMobileAds
class HadisViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,GADBannerViewDelegate, GADFullScreenContentDelegate  {

    
   
    
    
    var bannerView: GADBannerView!
    private var interstitial: GADInterstitialAd?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HadisTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        
        createAdd()
        // Do any additional setup after loading the view. bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = Utils.bannerId
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
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
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
//    {
//        let verticalPadding: CGFloat = 8
//
//        let maskLayer = CALayer()
//        maskLayer.borderWidth = 2
//        maskLayer.borderColor = UIColor.red.cgColor
//        maskLayer.backgroundColor = UIColor.black.cgColor
//        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
//        cell.layer.mask = maskLayer
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HadisTableViewCell{
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 2, height: 2)
            cell.layer.shadowRadius = 5
            cell.layer.shadowOpacity = 0.1
            cell.textLbl.text = Helper.hadithENG[Helper.SelectedlanguageNumber][indexPath.row]
            cell.shareButton.addTarget(self, action: #selector(shareButtonAction), for: .touchUpInside)
            cell.copyButton.addTarget(self, action: #selector(copyButtonAction), for: .touchUpInside)
            return cell
        }
        return UITableViewCell()
    }
    
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Helper.hadithENG[Helper.SelectedlanguageNumber].count
    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return hadithTR.count
//    }
//
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->CGFloat {

    return UITableView.automaticDimension

    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableView.automaticDimension
       }
    @objc func shareButtonAction (sender: UIButton) {
        UIGraphicsBeginImageContext(view.frame.size)
                view.layer.render(in: UIGraphicsGetCurrentContext()!)
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()

                let textToShare = Helper.hadithENG[Helper.SelectedlanguageNumber][sender.tag]

                if let myWebsite = URL(string: "https://apps.apple.com/us/app/islamic-wallpaper-hd-pro/id1632238123") {//Enter link to your app here
                    let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "app-logo")] as [Any]
                    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

                    //Excluded Activities
                    activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
                    //

                    activityVC.popoverPresentationController?.sourceView = sender
                    self.present(activityVC, animated: true, completion: nil)
                    if interstitial != nil {
                        interstitial?.present(fromRootViewController: self)
                       

                    } else {
                        print("Ad wasn't ready")
                    }
    }
    }
    
    @objc func copyButtonAction (sender: UIButton) {
        UIPasteboard.general.string = Helper.hadithENG[Helper.SelectedlanguageNumber][sender.tag]
        if interstitial != nil {
            interstitial?.present(fromRootViewController: self)
           

        } else {
            print("Ad wasn't ready")
            self.dismiss(animated: true)
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
