//
//  AdhanViewController.swift
//  IslamicWallpaper
//
//  Created by fdnsoft on 8.07.2022.
//

import UIKit
import Lottie
class AdhanViewController: UIViewController {
    let animationView = AnimationView()

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
        
        
       
        
    
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        networkService()
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
                            print(namazVakitleri.data.timings.Fajr)
                            self?.updateUI(namaz: namazVakitleri)
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
        self.dismiss(animated: true)
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
