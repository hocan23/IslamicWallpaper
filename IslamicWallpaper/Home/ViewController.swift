//
//  ViewController.swift
//  IslamicWallpaper
//
//  Created by Hasan onur Can on 28.06.2022.
//

import UIKit

class ViewController: UIViewController, CategoriasTableViewCellDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var arcArray : [UIImage] = []
        var mosqArray : [UIImage] = []
        var roseArray : [UIImage] = []
        var kuranArray : [UIImage] = []
        var kaabaArray : [UIImage] = []
        var godArray : [UIImage] = []
        var ramadanArray : [UIImage] = []
    var discover : [UIImage] = []
        var allcatagories : [[UIImage]] = []
    var categoriNumber = 1
    var categoriesTitle = ["Keşfet","Mimari","Cami","Gül","Kuran","Kabe","Allah","Ramazan"]
    override func viewDidLoad() {
        super.viewDidLoad()
        createArrays()
        if let tabBarItem1 = self.tabBarController?.tabBar.items?[0] {
            tabBarItem1.selectedImage = UIImage(named: "Group 18")?.withRenderingMode(.alwaysOriginal);
            tabBarItem1.image = UIImage(named: "Group 16");
        }
        if let tabBarItem2 = self.tabBarController?.tabBar.items?[1] {
            tabBarItem2.selectedImage = UIImage(named: "Group 19")?.withRenderingMode(.alwaysOriginal);
            tabBarItem2.image = UIImage(named: "Group 15");
        }
        if let tabBarItem3 = self.tabBarController?.tabBar.items?[2] {
            tabBarItem3.selectedImage = UIImage(named: "Group 20")?.withRenderingMode(.alwaysOriginal);
            tabBarItem3.image = UIImage(named: "Group 17");
        }
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tableViewTapped(recognizer:)))
//        tableView.addGestureRecognizer(tapGestureRecognizer)
        //        tabBarItem[0].selectedImage = UIImage(named: "Group 18")?.withRenderingMode(.alwaysOriginal);
        //        tabBarItem[0].image = UIImage(named: "Group 16");
        // Do any additional setup after loading the view.
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? TableviewCellController else {fatalError()}
        cell.array = allcatagories[indexPath.row]
        cell.selectionStyle = .none
        cell.categories.text = categoriesTitle[indexPath.row]
        cell.seeAllButton.tag = indexPath.row
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("mkl")
        //        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FullScreenViewController") as! FullScreenViewController
        //        newViewController.modalPresentationStyle = .fullScreen
        //
        //                self.present(newViewController, animated: true, completion: nil)
    }
    func selectPhotoTapped(value: Int) {
        print(value)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FullScreenViewController") as! FullScreenViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.selectedPhoto = allcatagories[categoriNumber][value]
        
        self.present(newViewController, animated: true, completion: nil)
    }
  func createArrays(){
            for a in 1..<8 {
                        print(a)
                        for i in 10..<30{
                            
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

      
      allcatagories.append(discover)

            allcatagories.append(arcArray)
            allcatagories.append(mosqArray)
            allcatagories.append(roseArray)
            allcatagories.append(kuranArray)
            allcatagories.append(kaabaArray)
            allcatagories.append(godArray)
            allcatagories.append(ramadanArray)
        }
    }
    




