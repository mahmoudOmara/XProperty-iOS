//
//  SearchVC.swift
//  XProperty
//
//  Created by Omara on 30.11.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit

struct SearchObject {
    var viewIdentifier: String
    var searchKey:String
    var options: [String]?
    var metric: String?
    var unit: String?
    var rangeMaxValue: CGFloat?
}

protocol CommonSearch {
    func setup(withSearchObject searchObject: SearchObject)
}

class SearchVC: UIViewController {
    
    var spaceBetweenItems: CGFloat = 15
    @IBOutlet weak var contentTV: UITableView!
    
    let searchObjects: [SearchObject] = [
        SearchObject(viewIdentifier: "dropDown", searchKey: "Project developer", options: ["Emaar","Talaat Mostafa"], metric: nil, unit: nil, rangeMaxValue: nil),
        SearchObject(viewIdentifier: "dropDown", searchKey: "Area", options: ["6 October","Abasya"], metric: nil, unit: nil, rangeMaxValue: nil),
        SearchObject(viewIdentifier: "dropDown", searchKey: "Unit type", options: ["Duplix","Single floor"], metric: nil, unit: nil, rangeMaxValue: nil),
        SearchObject(viewIdentifier: "fewOptions", searchKey: "Bedrooms", options: ["Any","1+","2+","3+","4+","5+"], metric: nil, unit: nil, rangeMaxValue: nil),
        SearchObject(viewIdentifier: "dropDown", searchKey: "sub Type", options: ["Ground"], metric: nil, unit: nil, rangeMaxValue: nil),
        SearchObject(viewIdentifier: "objectiveMetric", searchKey: "Land Size", options: nil, metric: "min.", unit: "m²", rangeMaxValue: nil),
        SearchObject(viewIdentifier: "range", searchKey: "Price range", options: nil, metric: nil, unit: nil, rangeMaxValue: 2000000),
        SearchObject(viewIdentifier: "objectiveMetric", searchKey: "Roof", options: nil, metric: "min.", unit: "m²", rangeMaxValue: nil),
        SearchObject(viewIdentifier: "objectiveMetric", searchKey: "Garden", options: nil, metric: "min.", unit: "m²", rangeMaxValue: nil),
        SearchObject(viewIdentifier: "dropDown", searchKey: "DownPayment", options: ["2 years","3 years","5 years", "7 years", "10 years"], metric: nil, unit: nil, rangeMaxValue: nil),
        SearchObject(viewIdentifier: "dropDown", searchKey: "Payment Years", options: ["2 years","3 years","5 years", "7 years", "10 years"], metric: nil, unit: nil, rangeMaxValue: nil),
        SearchObject(viewIdentifier: "dropDown", searchKey: "Delievery", options: ["20 - 8 - 2018","1 - 9 - 2018","1 - 10 - 2018", "1 - 11 - 2018", "1 - 12 - 2018"], metric: nil, unit: nil, rangeMaxValue: nil),
        SearchObject(viewIdentifier: "dropDown", searchKey: "Finishing", options: ["2019","2020","2021", "2022", "2023"], metric: nil, unit: nil, rangeMaxValue: nil)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        contentTV.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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

extension SearchVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchObjects.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchObject = searchObjects[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: searchObject.viewIdentifier, for: indexPath)
        (cell as! CommonSearch).setup(withSearchObject: searchObject)
        
        return cell
    }
    
    
}

extension SearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return spaceBetweenItems
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
}
