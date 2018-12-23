//
//  PropertiesVC.swift
//  XProperty
//
//  Created by SpellAd on 12/10/18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit


struct Property {
    var BDNum: String
    var tyoe: String
    var area: String
    var price: String
}

class PropertiesVC: UIViewController {
    
    @IBOutlet weak var propertiesTV: UITableView!
    @IBOutlet weak var propertiesTV2: UITableView!
    @IBOutlet weak var propertiesTVHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var propertiesTVHeightConstraint2: NSLayoutConstraint!
    
    var properties = [Property(BDNum: "2", tyoe: "Typical", area: "120", price: "1,300,000"),
                      Property(BDNum: "2", tyoe: "Ground", area: "115", price: "1,450,000")]
    
    private var rowHeight: CGFloat = 50

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        propertiesTVHeightConstraint.constant = propertiesTV.contentSize.height
        propertiesTVHeightConstraint2.constant = propertiesTV2.contentSize.height

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

extension PropertiesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = indexPath.row == 0 ? "headerCell" : "propertyCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        (cell as? PropertyTVC)?.setup(withProperty: properties[indexPath.item - 1])
        (cell as? PropertyTVC)?.typeLBKGV.backgroundColor = indexPath.item % 2 == 0 ? #colorLiteral(red: 0, green: 0.6528939605, blue: 0.5067526698, alpha: 1) : #colorLiteral(red: 0.1529411765, green: 0.5607843137, blue: 0.4352941176, alpha: 1)
        if indexPath.item == properties.count {
            (cell as? PropertyTVC)?.typeLBKGV.cornerRadius = 20
            (cell as? PropertyTVC)?.typeLBKGV.maskedCornerBottom = true
        }
        
        return cell
    }
    
    
}

extension PropertiesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}
