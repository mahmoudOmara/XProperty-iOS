//
//  HomeVC.swift
//  XProperty
//
//  Created by Omara on 26.11.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit
import PagingKit

class HomeVC: UIViewController {

    var menuViewController: PagingMenuViewController?
    var contentViewController: PagingContentViewController?
    
    let dataSource: [(menu: String, content: UIViewController)] = ["Area", "Companies", "Projects"].map {
        
        var vc = UIStoryboard(name: "Home", bundle: .main).instantiateViewController(withIdentifier: "HomeDetailsVC") as! HomeDetailsVC
        vc.nextVCStoryBoardIdentiefer = "first"
        return (menu: $0, content: vc)
    }
    
    lazy var firstLoad: (() -> Void)? = { [weak self, menuViewController, contentViewController] in
        menuViewController?.reloadData()
        contentViewController?.reloadData()
        self?.firstLoad = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        menuViewController?.register(type: TitleLabelMenuViewCell.self, forCellWithReuseIdentifier: "identifier")
        let underLineFocus = UnderlineFocusView(image: nil)
        underLineFocus.underlineColor = #colorLiteral(red: 0.2156862745, green: 0.6862745098, blue: 0.5647058824, alpha: 1)
        menuViewController?.registerFocusView(view: underLineFocus)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstLoad?()
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PagingMenuViewController {
            menuViewController = vc
            menuViewController?.dataSource = self
            menuViewController?.delegate = self
        } else if let vc = segue.destination as? PagingContentViewController {
            contentViewController = vc
            contentViewController?.delegate = self
            contentViewController?.dataSource = self
        }
    }

}



extension HomeVC: PagingMenuViewControllerDataSource {
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "identifier", for: index)  as! TitleLabelMenuViewCell
        cell.focusBackGroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.normalBackGroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.focusColor = #colorLiteral(red: 0.01568627451, green: 0.01568627451, blue: 0.01568627451, alpha: 1)
        cell.normalColor = #colorLiteral(red: 0.5697702169, green: 0.5698549747, blue: 0.5697516799, alpha: 1)
        cell.titleLabel.text = dataSource[index].menu
        return cell
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return viewController.view.bounds.width / CGFloat(dataSource.count)
    }
    
    var insets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets
        } else {
            return .zero
        }
    }
    
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
}

extension HomeVC: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt Index: Int) -> UIViewController {
        return dataSource[Index].content
    }
}

extension HomeVC: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        
        contentViewController?.scroll(to: page, animated: true)
    }
    
    func contentViewController(viewController: PagingContentViewController, willBeginPagingAt index: Int, animated: Bool) {
        
    }
}

extension HomeVC: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        menuViewController?.scroll(index: index, percent: percent, animated: false)
    }
    
}
