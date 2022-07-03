//
//  LanguageSelectionViewController.swift
//  IslamicWallpaper
//
//  Created by fdnsoft on 2.07.2022.
//

import UIKit


class LanguageSelectionViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
   let languages = ["English",    "中国人",    "हिन्दी" ,   "Русский",    "Indonesia",    "日本",    "Deutsch",    "Italiano",    "Français",    "Türkçe",    "Tiếng Việt",    "عربي"  ]
    var  selectedLanguage : String = ""
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        

        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? LangTableViewCell else {fatalError()}
        cell.langLabel.text = languages[indexPath.row]
        
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
//                    if cell.accessoryType == .checkmark {
//                        cell.accessoryType = .none
//                    } else {
//                        cell.accessoryType = .checkmark
//                    }
//
//                }
        var newlang = ""

        for row in 0..<tableView.numberOfRows(inSection: indexPath.section) {
            if let cell = tableView.cellForRow(at: IndexPath(row: row, section: indexPath.section)) {
                cell.accessoryType = row == indexPath.row ? .checkmark : .none
                print(findlangcode(cellNumber: indexPath.row))
                
                newlang = findlangcode(cellNumber: indexPath.row)
                Utils.saveLocalLang(string: newlang, key: "languaageSelection")
            }
        }
        Helper.SelectedlanguageNumber = indexPath.row

        let vc = SettingsViewController()
        vc.modalPresentationStyle = .fullScreen
        self.dismiss(animated: true)

//                tableView.deselectRow(at: indexPath, animated: true)
        
    }
    func findlangcode (cellNumber:Int)->String{
        var code = "en"
        switch cellNumber{
        case 0:
            code = "en"
        case 1:
            code = "cn"
        case 2:
            code = "hi"
        case 3:
            code = "ru"
        case 4:
            code = "id"
        case 5:
            code = "jp"
        case 6:
            code = "de"
        case 7:
            code = "it"
        case 8:
            code = "fr"
        case 9:
            code = "tr"
        case 10:
            code = "vn"
        case 11:
            code = "sa"
       
        default:
            code = "en"
            
        }
        return code
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
