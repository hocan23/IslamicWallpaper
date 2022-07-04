//
//  Extentions.swift
//  IslamicWallpaper
//
//  Created by fdnsoft on 30.06.2022.
//

import Foundation
import UIKit
class Utils{
   
    static var fullScreenAdId = " ca-app-pub-3940256099942544/4411468910"
    static var  bannerId = "ca-app-pub-3940256099942544/2934735716"
    
//    static var fullScreenAdId = "ca-app-pub-1501030234998564/7610227592"
//    static var  bannerId = "ca-app-pub-1501030234998564/5367207636"
    static func saveLocal (array:[String], key : String){
    let defaults = UserDefaults.standard
    defaults.set(array, forKey: key)
}
    static func readLocal (key: String)->[String]{
        let defaults = UserDefaults.standard
        let myarray = defaults.stringArray(forKey: key) ?? [String]()
        return myarray
    }
    static func saveLocalLang (string:String, key : String){
    let defaults = UserDefaults.standard
    defaults.set(string, forKey: key)
}
    static func readLocalLang (key: String)->String?{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: key)
    }
}
extension String {
    var localized: String {
        return NSLocalizedString(self, comment:"")
    }
}
extension UIView {

/**
 Simply zooming in of a view: set view scale to 0 and zoom to Identity on 'duration' time interval.

 - parameter duration: animation duration
 */
func zoomIn(duration: TimeInterval = 0.2) {
    self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
        self.transform = .identity
        }) { (animationCompleted: Bool) -> Void in
    }
}

/**
 Simply zooming out of a view: set view scale to Identity and zoom out to 0 on 'duration' time interval.

 - parameter duration: animation duration
 */
func zoomOut(duration : TimeInterval = 0.2) {
    self.transform = .identity
    UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
        self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        }) { (animationCompleted: Bool) -> Void in
    }
}
    func zoomInWithEasing(duration: TimeInterval = 0.2, easingOffset: CGFloat = 0.2) {
        let easeScale = 1.0 + easingOffset
        let easingDuration = TimeInterval(easingOffset) * duration / TimeInterval(easeScale)
        let scalingDuration = duration - easingDuration
        UIView.animate(withDuration: scalingDuration, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: easeScale, y: easeScale)
            }, completion: { (completed: Bool) -> Void in
                UIView.animate(withDuration: easingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                    self.transform = .identity
                    }, completion: { (completed: Bool) -> Void in
                })
        })
    }

    /**
     Zoom out any view with specified offset magnification.

     - parameter duration:     animation duration.
     - parameter easingOffset: easing offset.
     */
    func zoomOutWithEasing(duration: TimeInterval = 0.2, easingOffset: CGFloat = 0.2) {
        let easeScale = 1.0 + easingOffset
        let easingDuration = TimeInterval(easingOffset) * duration / TimeInterval(easeScale)
        let scalingDuration = duration - easingDuration
        UIView.animate(withDuration: easingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: easeScale, y: easeScale)
            }, completion: { (completed: Bool) -> Void in
                UIView.animate(withDuration: scalingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                    self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                    }, completion: { (completed: Bool) -> Void in
                })
        })
    }
   

    }
    
