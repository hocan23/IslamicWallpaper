//
//  SettingsViewController.swift
//  IslamicWallpaper
//
//  Created by fdnsoft on 30.06.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var otherApps: UIButton!
    @IBOutlet weak var languageButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Ayarlar"
        shareButton.titleLabel?.text = "Uygulamayı Paylaş"
        otherApps.titleLabel?.text = "Diğer Uygulamalar"
        languageButton.titleLabel?.text = "Dil seçimi"


    }
    @IBAction func sharePressed(_ sender: Any) {
        UIGraphicsBeginImageContext(view.frame.size)
                view.layer.render(in: UIGraphicsGetCurrentContext()!)
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()

                let textToShare = "Check out my app"

                if let myWebsite = URL(string: "http://itunes.apple.com/app/idXXXXXXXXX") {//Enter link to your app here
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
        if let url = URL(string: "https://apps.apple.com/tr/app/birevim-mobil/id1530582251?l=tr") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func languagePressed(_ sender: Any) {
        
      
    }
  
        
    
    
    
    
    

}
