//
//  PeopleDetailsViewController.swift
//  getPeopletrt
//
//  Created by Tarooti on 24/05/1443 AH.
//

import UIKit

class PeopleDetailsViewController: UIViewController {

    var passedPerson :NSDictionary!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = passedPerson["name"] as? String
        lbl2.text = passedPerson["gender"] as? String
        lbl3.text = passedPerson["birth_year"] as? String
        lbl4.text = passedPerson["mass"] as? String
        
        var Species = passedPerson["species"] as! NSArray
        if Species != [] {
        
        StarWarsModel.getSpecies(url: (Species[0] as? String)!, completionHandler:{
            data, response, error in
                do {
                    // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        DispatchQueue.main.async {
                            self.lbl1.text = jsonResult["name"] as? String
                        }
                        
                    }
                 
                } catch {
                    print("Something went wrong")
                }        })
        }else{
            self.lbl1.text = "Nothing"

        }
        // Do any additional setup after loading the view.
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
