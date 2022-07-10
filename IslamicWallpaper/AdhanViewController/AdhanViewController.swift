//
//  AdhanViewController.swift
//  IslamicWallpaper
//
//  Created by fdnsoft on 8.07.2022.
//

import UIKit
import Lottie
import GoogleMobileAds
class AdhanViewController: UIViewController, GADBannerViewDelegate, GADFullScreenContentDelegate {
    var bannerView: GADBannerView!
    let animationView = AnimationView()
    private var interstitial: GADInterstitialAd?
    var isAd : Bool = false
    
    @IBOutlet weak var ishaTime: UILabel!
    @IBOutlet weak var ishaLbl: UILabel!
    @IBOutlet weak var sunsetTime: UILabel!
    @IBOutlet weak var sunsetLbl: UILabel!
    @IBOutlet weak var ASRtİME: UILabel!
    @IBOutlet weak var asrLbl: UILabel!
    @IBOutlet weak var dhuhreTime: UILabel!
    @IBOutlet weak var dhuhrLbl: UILabel!
    @IBOutlet weak var sunriseTime: UILabel!
    @IBOutlet weak var sunriseLbl: UILabel!
    @IBOutlet weak var fajrTimeLbl: UILabel!
    @IBOutlet weak var fajrLbl: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var altViewHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        prayerAnimation()
        altViewHeight.constant = view.bounds.height*0.45
        createAdd()
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = Utils.bannerId
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        backButton.setTitle(Helper.adhanTimes[Helper.SelectedlanguageNumber], for: .normal)
        networkService()
        if isAd == true {
            self.dismiss(animated: true)
            
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
    func networkService (){
        var flag = false
        
        LocationManager.shared.getCurrentReverseGeoCodedLocation { [weak self] location, placemark, error in
            if let placemark = placemark {
                DispatchQueue.main.async {
                    print(placemark.locality)
                    //                    self?.cityLabel.text = placemark.locality
                }
            }
            
            NetworkManager.shared.fetchData { result in
                if (flag == false) {
                    switch result {
                    case .success(let namazVakitleri):
                        DispatchQueue.main.async {
                            print()
                            print(Int(namazVakitleri.data.timings.Fajr.prefix(2)) )
                            self?.updateUI(namaz: namazVakitleri)
                            self?.calculateCurrentAdhanTime(namaz: namazVakitleri)

                            //                            self?.namazVakitleri = namazVakitleri
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
                flag = true
            }
        }
    }
    
    func updateUI (namaz: Response){
        fajrTimeLbl.text = namaz.data.timings.Fajr
        sunriseTime.text = namaz.data.timings.Sunrise
        dhuhreTime.text = namaz.data.timings.Dhuhr
        ASRtİME.text = namaz.data.timings.Asr
        ishaTime.text = namaz.data.timings.Isha
        sunsetTime.text = namaz.data.timings.Sunset
        
        fajrLbl.text = Helper.fajr[Helper.SelectedlanguageNumber]
        sunsetLbl.text = Helper.magrib[Helper.SelectedlanguageNumber]
        asrLbl.text = Helper.asr[Helper.SelectedlanguageNumber]
        dhuhrLbl.text = Helper.duhr[Helper.SelectedlanguageNumber]
        ishaLbl.text = Helper.isha[Helper.SelectedlanguageNumber]
        sunriseLbl.text = Helper.sunrise[Helper.SelectedlanguageNumber]
    }
    func calculateCurrentAdhanTime (namaz: Response){
        let fajrTimer = createAdhanTime(time: namaz.data.timings.Fajr )
        let sunriseTimer = createAdhanTime(time: namaz.data.timings.Sunrise)
        let dhuhrTimer = createAdhanTime(time: namaz.data.timings.Dhuhr)
        let asrTimer = createAdhanTime(time: namaz.data.timings.Asr)
        let ishaTimer = createAdhanTime(time: namaz.data.timings.Isha)
        let sunsetTimer = createAdhanTime(time: namaz.data.timings.Sunset)
        print(ishaTimer)
        print(sunsetTimer)
        // *** create calendar object ***
        var calendar = Calendar.current
        let date = Date()
        // *** Get components using current Local & Timezone ***
        let currentTime = calendar.dateComponents([.hour, .minute], from: date)
        let currentHour = Int(currentTime.hour!)
        let currentMinute = Int(currentTime.minute!)
        let currenttimer = currentHour*60+currentMinute
        switch currenttimer{
            
        case let x where x >= fajrTimer && x <= sunriseTimer:
            fajrLbl.textColor = .systemCyan
            fajrTimeLbl.textColor = .systemCyan
        case let x where x >= sunriseTimer && x <= dhuhrTimer:
            sunriseLbl.textColor = .systemCyan
            sunriseTime.textColor = .systemCyan
        case let x where  x >= dhuhrTimer && x <= asrTimer:
            dhuhrLbl.textColor = .systemCyan
            dhuhreTime.textColor = .systemCyan
        case let x where x >= asrTimer && x <= sunsetTimer:
            fajrLbl.textColor = .systemCyan
            fajrTimeLbl.textColor = .systemCyan
        case let x where x >= sunsetTimer && x <= ishaTimer:
            ishaLbl.textColor = .systemCyan
            ishaTime.textColor = .systemCyan
        case let x where x >= ishaTimer && x <= fajrTimer:
            
            sunsetLbl.textColor = .systemCyan
            sunsetTime.textColor = .systemCyan
            
        default:
            print("this is impossible")
        }
        print(currenttimer)
        
    }
    func createAdhanTime (time:String)->Int{
        let hour = Int(time.prefix(2))!
        let minute = Int(time.suffix(2))!
        let adhantime = hour*60+minute
        return adhantime
    }
    func prayerAnimation () {
        animationView.animation = Animation.named("prayer")
        animationView.frame = CGRect(x: 0, y: 60, width: 300, height: view.bounds.height*0.3)
        if view.bounds.height > 650{
            animationView.frame = CGRect(x: 0, y:90, width: 300, height: view.bounds.height*0.3)
        }
        animationView.center.x = view.center.x
        animationView.loopMode = .playOnce
        self.animationView.isHidden = false
        animationView.play()
        view.addSubview(animationView)
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        animationView.stop()
    }
    
    @IBAction func BackButtonPressed(_ sender: Any) {
        if interstitial != nil {
            interstitial?.present(fromRootViewController: self)
            isAd = true
            
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
