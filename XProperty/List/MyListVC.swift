//
//  MyListVC.swift
//  XProperty
//
//  Created by Omara on 26.11.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit

struct ListItem {
    var projects = Array(repeating: "Duplix Typical 120", count: 4)
    var name = "6 October"
    var isOpened = false
    
}

class MyListVC: UIViewController {

    var list = Array(repeating: ListItem(), count: 6)
    var spaceBetweenSections:CGFloat = 10
    var heightForHeader:CGFloat = 60
    var heightForItem:CGFloat = 100
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filterButtonClicked(_ sender: Any) {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "FilterVC")
        self.navigationController?.pushViewController(vc, animated: true)
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

extension MyListVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].isOpened ? list[section].projects.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listObjectCell", for: indexPath) as! ListObjectTVC
        cell.nameL.text = list[indexPath.section].projects[indexPath.item]
        return cell
    }
    
    
}

extension MyListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForItem
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Bundle.main.loadNibNamed("MyListHeaderV", owner: nil, options: nil)?.first as! MyListHeaderV
        view.isOpened = list[section].isOpened
        view.HeaderTitle.text = list[section].name
        
        view.openCloseSection = {
            (isOpened) in
            self.list[section].isOpened = isOpened
            tableView.reloadSections([section], with: UITableView.RowAnimation.fade)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeader
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return spaceBetweenSections
    }
}
