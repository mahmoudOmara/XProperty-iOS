//
//  FewOptionsCell.swift
//  XProperty
//
//  Created by Omara on 02.12.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit

class FewOptionsCell: UITableViewCell, CommonSearch {

    @IBOutlet weak var searchkeyL: UILabel!
    @IBOutlet weak var optionsCV: UICollectionView!
    var options: [String] = []
    lazy var selections = Array(repeating: false, count: options.count)
    
    func setup(withSearchObject searchObject: SearchObject) {
        searchkeyL.text = searchObject.searchKey
        optionsCV.dataSource = self
        optionsCV.delegate = self
        self.options = searchObject.options ?? []
        optionsCV.reloadData()
    }

}

extension FewOptionsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "optionCell", for: indexPath) as! FewOptionCVC
        cell.setup(withOption: options[indexPath.item], isSelected: selections[indexPath.row])
        return cell
    }
    
    
}

extension FewOptionsCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selections[indexPath.item] = !selections[indexPath.item]
        collectionView.reloadItems(at: [indexPath])
    }
}
