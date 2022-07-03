//
//  Extentions.swift
//  IslamicWallpaper
//
//  Created by fdnsoft on 30.06.2022.
//

import Foundation
class Utils{
    
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
