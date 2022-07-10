//
//  InitialViewController.swift
//  IslamicWallpaper
//
//  Created by fdnsoft on 8.07.2022.
//

import UIKit
import GoogleMobileAds

    class InitialViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GADBannerViewDelegate, GADFullScreenContentDelegate {
        var bannerView: GADBannerView!
        private var interstitial: GADInterstitialAd?

        var screenHeight = UIScreen.main.bounds.height / 3.9
        var titleArray  = [[Helper.islamicWallpapers],[Helper.adhanTimes],[Helper.qiblafinder],[Helper.hadiths],[Helper.favorites],[Helper.settings]]
        var imageArray = [UIImage(named: "islamicWallpaperIcon"),UIImage(named: "adhanTimeIcon"),UIImage(named: "QiblaFinderIcon"),UIImage(named: "40HadithIcon"),UIImage(named: "favoritesIcon"),UIImage(named: "settingsIcon")]
        @IBOutlet weak var lettersCW: UICollectionView!
        private let reuseIdentifier = "Cell"
        
        let insets = UIEdgeInsets(top: 30, left: 15, bottom: 60, right: 15)
        let spacing = CGSize(width: 5, height: 10)

        
        override func viewDidLoad() {
              super.viewDidLoad()
              print(titleArray[0][0])
              lettersCW.isScrollEnabled = false
              print("SCREEN SIZE", screenHeight)
              bannerView = GADBannerView(adSize: GADAdSizeBanner)
              bannerView.adUnitID = Utils.bannerId
              bannerView.rootViewController = self
              bannerView.load(GADRequest())
              bannerView.delegate = self
              languageSelection()
            }
        
        override func viewWillAppear(_ animated: Bool) {
            if interstitial != nil {
                interstitial?.present(fromRootViewController: self)
                
            } else {
                print("Ad wasn't ready")
            }
            lettersCW.reloadData()
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
        
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          
                
                return imageArray.count
                
     
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = lettersCW.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! InitialCollectionViewCell
            
            cell.imageView.image = imageArray[indexPath.row]
            
            cell.nameLabel.text = titleArray[indexPath.row][0][Helper.SelectedlanguageNumber]
            cell.layer.cornerRadius = 20
        
            cell.layer.masksToBounds = false
            cell.layer.shadowColor = UIColor.darkGray.cgColor
            cell.layer.shadowOffset = CGSize(width: 1.0, height: 5.0)
            cell.layer.shadowRadius = 5
            cell.layer.shadowOpacity = 0.1

            
            if self.traitCollection.userInterfaceStyle == .dark {
              
                cell.nameLabel.text = titleArray[indexPath.row][0][Helper.SelectedlanguageNumber]
                cell.layer.cornerRadius = 20
                cell.layer.backgroundColor = UIColor(red: 0.129, green: 0.156, blue: 0.2, alpha: 0.75).cgColor
                
                collectionView.backgroundColor = UIColor.black
                view.backgroundColor = UIColor.black
                
          
            }
            
            return cell

        }
      
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
            switch indexPath.row{
            case 0:
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
            case 1:
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "AdhanViewController") as! AdhanViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
            case 2:
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "KibleViewController") as! KibleViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
            case 3:
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "HadisViewController") as! HadisViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
            case 4:
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "FavViewController") as! FavViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
            case 5:
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
            default:
                return
            }
            
        }
        
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            spacing.height
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            spacing.width
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            insets
        }
        
      
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
          
                
                
                let numberOfVisibleCellHorizontal: CGFloat = 2
                let horizontalOtherValues = insets.right + insets.left + (spacing.width * numberOfVisibleCellHorizontal)
                let width = (collectionView.bounds.width - horizontalOtherValues) / numberOfVisibleCellHorizontal
        
                           
           
      

            return CGSize(width: width, height: screenHeight)
            
            
            
                
            
           
            
//            let numberOfVisibleCellHorizontal: CGFloat = 2
//            let horizontalOtherValues = insets.right + insets.left + (spacing.width * numberOfVisibleCellHorizontal)
//            let width = (collectionView.bounds.width - horizontalOtherValues) / numberOfVisibleCellHorizontal
//
//            return CGSize(width: width, height: width)
            
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

//    extension ViewController: DetailViewControllerDelegate{
//        func diddismis() {
//
//        }
//
        
        
        
