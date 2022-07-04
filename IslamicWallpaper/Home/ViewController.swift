//
//  ViewController.swift
//  IslamicWallpaper
//
//  Created by Hasan onur Can on 28.06.2022.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, CategoriasTableViewCellDelegate, GADBannerViewDelegate, GADFullScreenContentDelegate, GADAdLoaderDelegate, GADNativeAdLoaderDelegate {
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
        print("dsa")
    }
    
    func selectPhotoTapped(value: Int, tableIndex: Int) {
        print(value)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FullScreenViewController") as! FullScreenViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.categoriPhotos = allcatagories[tableIndex]
        newViewController.selectedPhoto = allcatagories[tableIndex][value]
        newViewController.position = value
        
        self.present(newViewController, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    var arcArray : [UIImage] = []
        var mosqArray : [UIImage] = []
        var roseArray : [UIImage] = []
        var kuranArray : [UIImage] = []
        var kaabaArray : [UIImage] = []
        var godArray : [UIImage] = []
        var ramadanArray : [UIImage] = []
    var patternsArray : [UIImage] = []
    var discover : [UIImage] = []
        var allcatagories : [[UIImage]] = []
    var categoriNumber = 1
    var categoriesTitle : [String] = []
    var adLoader : GADAdLoader!
    var bannerView: GADBannerView!
    private var interstitial: GADInterstitialAd?

    @IBOutlet weak var vv: UIView!
    
    @IBOutlet weak var vvgg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languageSelection()
        
        
        createArrays()
        setTabbar()
        
        
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        createAdd()
        
        let multipleAdsOptions = GADMultipleAdsAdLoaderOptions()
        multipleAdsOptions.numberOfAds = 5
        adLoader = GADAdLoader(adUnitID: "ca-app-pub-3940256099942544/3986624511",
            rootViewController: self,
            adTypes: [ .native ],
                               options: [multipleAdsOptions])
        adLoader.delegate = self
        adLoader.load(GADRequest())
    }
    func adLoader(_ adLoader: GADAdLoader,
                   didReceive nativeAd: GADNativeAd) {
       // A native ad has loaded, and can be displayed.
        adLoader.delegate = self
       
    
        
     }

     func adLoaderDidFinishLoading(_ adLoader: GADAdLoader) {
         // The adLoader has finished loading ads, and a new request can be sent.
     }
    override func viewWillAppear(_ animated: Bool) {
        prepareLang()
        tableView.reloadData()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
    
    func createAdd() {
        let request = GADRequest()
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

    
//    @objc func tableViewTapped(recognizer: UITapGestureRecognizer) {
//        let location = recognizer.location(in: self.tableView) // point of touch in tableView
//        if let indexPath = self.tableView.indexPathForRow(at: location) { // indexPath of touch location
//            print(indexPath)
//            categoriNumber = indexPath.row
//        }
//    }
    
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allcatagories.count
        
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if interstitial != nil {
            interstitial?.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? TableviewCellController else {fatalError()}
        
        cell.array = allcatagories[indexPath.row]
        cell.selectionStyle = .none
        cell.categories.text = categoriesTitle[indexPath.row]
        cell.seeAllButton.tag = indexPath.row
        cell.index = indexPath.row
        cell.seeAllButton.addTarget(self, action:#selector(seeAllbtnPressed(sender:)), for: .touchUpInside)
        

        cell.delegate = self
        return cell
    }
    @objc func seeAllbtnPressed(sender: UIButton)
    
    {
        print("Button tag \(sender.tag)")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FavoriteViewController") as! FavoriteViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.catName = categoriesTitle[sender.tag]
        newViewController.category = allcatagories[sender.tag]
        self.present(newViewController, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 350
        }else{
            return 250
            
        }
    }
    
    
    
    
    
  func createArrays(){
            for a in 1..<9 {
                        print(a)
                        for i in 10..<40{
                            
                            if let c = UIImage(named: "\(a)\(i)") {
                                switch a{
                                case  1:
                                    arcArray.append(c)
                                case 2:
                                    mosqArray.append(c)
                                case  3:
                                    roseArray.append(c)
                                case  4:
                                    kuranArray.append(c)
                                case  5:
                                    kaabaArray.append(c)
                                case  6:
                                    godArray.append(c)
                                case  7:
                                    ramadanArray.append(c)
                                case 8 :
                                    patternsArray.append(c)
                                default:
                                    return
                                }
                                }
                        }
                    }
      
        discover.append(arcArray[Int.random(in: 0..<10)])
      discover.append(mosqArray[Int.random(in: 0..<10)])
      discover.append(roseArray[Int.random(in: 0..<10)])
      discover.append(kuranArray[Int.random(in: 0..<10)])
      discover.append(kaabaArray[Int.random(in: 0..<10)])
      discover.append(godArray[Int.random(in: 0..<10)])
      discover.append(ramadanArray[Int.random(in: 0..<10)])
      discover.append(patternsArray[Int.random(in: 0..<10)])

      
      allcatagories.append(discover)

            allcatagories.append(arcArray)
            allcatagories.append(mosqArray)
            allcatagories.append(roseArray)
            allcatagories.append(kuranArray)
            allcatagories.append(kaabaArray)
            allcatagories.append(godArray)
            allcatagories.append(ramadanArray)
      allcatagories.append(patternsArray)
        }
    func prepareLang (){
        categoriesTitle = [Helper.favorites[Helper.SelectedlanguageNumber],Helper.architecture[Helper.SelectedlanguageNumber],Helper.mosque[Helper.SelectedlanguageNumber],Helper.rose[Helper.SelectedlanguageNumber],Helper.kuran[Helper.SelectedlanguageNumber],Helper.kaaba[Helper.SelectedlanguageNumber],Helper.allah[Helper.SelectedlanguageNumber],Helper.ramadan[Helper.SelectedlanguageNumber],Helper.patterns[Helper.SelectedlanguageNumber]]
        tableView.reloadData()
    }
    
    func setTabbar(){
        if self.traitCollection.userInterfaceStyle == .dark {
            
            if let tabBarItem1 = self.tabBarController?.tabBar.items?[0] {
                tabBarItem1.selectedImage = UIImage(named: "Group 16")?.withRenderingMode(.alwaysOriginal).withBaselineOffset(fromBottom: UIFont.systemFontSize / 2+10);
                tabBarItem1.image = UIImage(named: "Group 18")?.withBaselineOffset(fromBottom: UIFont.systemFontSize / 2+10);
            }
            if let tabBarItem2 = self.tabBarController?.tabBar.items?[1] {
                tabBarItem2.selectedImage = UIImage(named: "Group 15")?.withRenderingMode(.alwaysOriginal).withBaselineOffset(fromBottom: UIFont.systemFontSize / 2+10);
                tabBarItem2.image = UIImage(named: "Group 19")?.withBaselineOffset(fromBottom: UIFont.systemFontSize / 2+10);
            }
            if let tabBarItem3 = self.tabBarController?.tabBar.items?[2] {
                tabBarItem3.selectedImage = UIImage(named: "Group 17")?.withRenderingMode(.alwaysOriginal).withBaselineOffset(fromBottom: UIFont.systemFontSize / 2+10);
                tabBarItem3.image = UIImage(named: "Group 20")?.withBaselineOffset(fromBottom: UIFont.systemFontSize / 2+10);
            }
            let tabBarAppearance = UITabBar.appearance()
            tabBarAppearance.isTranslucent = false
            tabBarAppearance.barTintColor = .black
            tabBarAppearance.backgroundColor = .black

            print("dark")
               } else {
                   if let tabBarItem1 = self.tabBarController?.tabBar.items?[0] {
                       tabBarItem1.selectedImage = UIImage(named: "Group 18")?.withRenderingMode(.alwaysOriginal).withBaselineOffset(fromBottom: UIFont.systemFontSize / 2+10);
                       tabBarItem1.image = UIImage(named: "Group 16")?.withBaselineOffset(fromBottom: UIFont.systemFontSize / 2+10);
                   }
                   if let tabBarItem2 = self.tabBarController?.tabBar.items?[1] {
                       tabBarItem2.selectedImage = UIImage(named: "Group 19")?.withRenderingMode(.alwaysOriginal).withBaselineOffset(fromBottom: UIFont.systemFontSize / 2+10);
                       tabBarItem2.image = UIImage(named: "Group 15")?.withBaselineOffset(fromBottom: UIFont.systemFontSize / 2+10);
                   }
                   if let tabBarItem3 = self.tabBarController?.tabBar.items?[2] {
                       tabBarItem3.selectedImage = UIImage(named: "Group 20")?.withRenderingMode(.alwaysOriginal).withBaselineOffset(fromBottom: UIFont.systemFontSize / 2+10);
                       tabBarItem3.image = UIImage(named: "Group 17")?.withBaselineOffset(fromBottom: UIFont.systemFontSize / 2+10);
                   }
                   self.tabBarController!.tabBar.backgroundColor = .white

               }
       
    }
    func languageSelection (){
        print(NSLocale.preferredLanguages[0].prefix(2))
        print(Utils.readLocalLang(key: "languaageSelection"))
        if let lang = Utils.readLocalLang(key: "languaageSelection") {
            Helper.Selectedlanguage = lang
        }else{
            Helper.Selectedlanguage = String(NSLocale.preferredLanguages[0].prefix(2))
            Utils.saveLocalLang(string: "String(NSLocale.preferredLanguages[0].prefix(2))", key: "languaageSelection")

        }
        switch Helper.Selectedlanguage{
                case "en":
                    Helper.SelectedlanguageNumber = 0
                case "cn":
                    Helper.SelectedlanguageNumber = 1
                case "hi":
                    Helper.SelectedlanguageNumber = 2
                case "ru":
                    Helper.SelectedlanguageNumber = 3
                case "id":
                    Helper.SelectedlanguageNumber = 4
                case "jp":
                    Helper.SelectedlanguageNumber = 5
                case "de":
                    Helper.SelectedlanguageNumber = 6
                case "it":
                    Helper.SelectedlanguageNumber = 7
                case "fr":
                    Helper.SelectedlanguageNumber = 8
                case "tr":
                    Helper.SelectedlanguageNumber = 9
                case "vn":
                    Helper.SelectedlanguageNumber = 10
                case "sa":
                    Helper.SelectedlanguageNumber = 11
                default:
                    Helper.SelectedlanguageNumber = 0
        }
    }
    }
    




