//
//  ViewController.swift
//  XProperty
//
//  Created by Omara on 26.11.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit


struct IntroObject {
    var image: UIImage
    var mainText: String
    var descriptionText: String
    var index: Int
}

class IntroVC: UIViewController {

    @IBOutlet weak var introCV: UICollectionView!
    
    let introObjects = [
        IntroObject(image: UIImage(named: "manageYourList")!, mainText: "Manage your list so easy", descriptionText: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu",index: 0),
    IntroObject(image: UIImage(named: "communicate with customers")!, mainText: "Communicate with customers", descriptionText: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu",index: 1),
    IntroObject(image: UIImage(named: "why should shoose us")!, mainText: "Why should you choose us", descriptionText: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu",index: 2)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        introCV.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        introCV.decelerationRate = UIScrollView.DecelerationRate.fast


    }
    
    
}

extension IntroVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return introObjects.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IntroCVC
        cell.setup(withIntroObject: introObjects[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize: CGSize = collectionView.bounds.size
        
        cellSize.width -= collectionView.contentInset.left * 2
        cellSize.width -= collectionView.contentInset.right * 2
        cellSize.height = collectionView.frame.height
        
        return cellSize
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateCellsLayout()
    }
    
    
}


extension IntroVC{
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateCellsLayout()
    }
    
    func updateCellsLayout()  {
        
        let centerX = introCV.contentOffset.x + (introCV.frame.size.width)/2
        
        for cell in introCV.visibleCells {
            var offsetX = centerX - cell.center.x
            if offsetX < 0 {
                offsetX *= -1
            }
            cell.transform = CGAffineTransform.identity
            let offsetPercentage = offsetX / (view.bounds.width * 2.7)
            let scaleX = 1-offsetPercentage
            cell.transform = CGAffineTransform(scaleX: scaleX, y: scaleX)
        }
    }
}
