//
//  Extentions.swift
//  IslamicWallpaper
//
//  Created by fdnsoft on 30.06.2022.
//

import Foundation
class Utils{
    
static func saveLocal (array:[String]){
    let defaults = UserDefaults.standard
    defaults.set(array, forKey: "SavedStringArray")
}
static func readLocal ()->[String]{
        let defaults = UserDefaults.standard
        let myarray = defaults.stringArray(forKey: "SavedStringArray") ?? [String]()
        return myarray
    }
}
extension String {
    var localized: String {
        return NSLocalizedString(self, comment:"")
    }
}
