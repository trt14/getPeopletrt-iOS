//
//  ViewController.swift
//  getPeopletrt
//
//  Created by Tarooti on 24/05/1443 AH.
//

import UIKit

class ViewController: UIViewController {

    
    var pageNumber = 1
    var peopleList = [NSDictionary]()
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gettingDataFromAPI()
        mainTableView.dataSource = self
        mainTableView.delegate = self
    }
    
    func gettingDataFromAPI() {
        StarWarsModel.getAllPeople(completionHandler: { // passing what becomes "completionHandler" in the 'getAllPeople' function definition in StarWarsModel.swift
            data, response, error in
                do {
                    // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let results = jsonResult["results"] as? NSArray {
                            for person in results {
                                let personDict = person as! NSDictionary
                                self.peopleList.append(personDict)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.mainTableView.reloadData()
                    }
                } catch {
                    print("Something went wrong")
                }
        })
    }

    
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = peopleList[indexPath.row]["name"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = peopleList[indexPath.row]
        performSegue(withIdentifier: "showSegue", sender: person)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let person = sender as? NSDictionary
        let destController = segue.destination as? PeopleDetailsViewController
        destController?.passedPerson = person
    }
    
    
}
