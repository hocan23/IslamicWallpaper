//
//  LanguageSelectionViewController.swift
//  IslamicWallpaper
//
//  Created by fdnsoft on 2.07.2022.
//

import UIKit

class LanguageSelectionViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
   let languages = ["English","Indian ","Russian",    "Indonesian"  ,  "Japan",    "Germany" ,   "Italy"  ,  "French" , "Turkish" ,  "Vietnam" ,"Arabic"]
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
        for row in 0..<tableView.numberOfRows(inSection: indexPath.section) {
            if let cell = tableView.cellForRow(at: IndexPath(row: row, section: indexPath.section)) {
                cell.accessoryType = row == indexPath.row ? .checkmark : .none
            }
        }
//                tableView.deselectRow(at: indexPath, animated: true)
        
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
