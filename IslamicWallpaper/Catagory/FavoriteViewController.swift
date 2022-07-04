//
//  FavoriteViewController.swift
//  IslamicWallpaper
//
//  Created by fdnsoft on 30.06.2022.
//

import UIKit
import GoogleMobileAds
class FavoriteViewController: UIViewController , GADBannerViewDelegate, GADFullScreenContentDelegate, SawAdInFullScreeen {
    func notShowAd() {
        isSeenAd = true
    }
    
    
    
   
    @IBOutlet weak var catagoriText: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var category : [UIImage] = []
    var catName : String = ""
    var bannerView: GADBannerView!
    private var interstitial: GADInterstitialAd?
    var isAd : Bool = false
    var isSeenAd : Bool = false

    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        // Do any additional setup after loading the view.
        
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = Utils.bannerId
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isAd == true {
            self.dismiss(animated: true)

            
        }
        catagoriText.text = catName
        createAdd()
        if self.traitCollection.userInterfaceStyle == .dark {
            catagoriText.textColor = .white
            backButton.tintColor = .white
        }
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
    
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        if interstitial != nil {
            if isSeenAd == false{
            interstitial?.present(fromRootViewController: self)
            isAd = true
            }else{
                self.dismiss(animated: true)

            }
        } else {
            print("Ad wasn't ready")
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
    
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoritecell", for: indexPath) as! FavoriteCollectionViewCell
        cell.imageView.image = category[indexPath.row]
        cell.layer.cornerRadius = 20
        cell.backgroundColor = .red
        cell.layer.masksToBounds = true
        
        
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        // The row value is the same as the index of the desired text within the array.
        
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FullScreenViewController") as! FullScreenViewController
        newViewController.delegate = self
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.selectedPhoto = category[indexPath.row]
        newViewController.categoriPhotos = category
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
