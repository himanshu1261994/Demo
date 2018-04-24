//
//  MasterPageController.swift
//  LawyerApp
//
//  Created by indianic on 09/05/17.
//  Copyright © 2017 Indianic. All rights reserved.
//

import UIKit
protocol MasterPageControllerDataSource {
    func numberOfViewController(pageController : MasterPageController) -> ([String],[UIViewController])
    func willMoveToViewController(pageController : MasterPageController,index : Int,viewController : UIViewController)
    func didMoveToViewController(pageController : MasterPageController,index : Int,viewController : UIViewController)
}
class MasterPageController: UIView {

    public var datasource1: MasterPageControllerDataSource?
    private var selectionView : MasterPageSelectionView?
    @IBOutlet public var datasource: AnyObject? {
        get { return datasource1 as AnyObject }
        set { datasource1 = newValue as? MasterPageControllerDataSource }
    }
    private var numberOfVC : Int = 0
    private var currentPageIndex : Int = 0
    
    var arrOfTitles : [String] = []
    var arrOfVC : [UIViewController] = []
    private var currentViewController : UIViewController?
    @IBInspectable var underLineColor: UIColor = UIColor.black
    @IBInspectable var selectedIndexFontColor: UIColor = UIColor.black
    @IBInspectable var unSelectedIndexFontColor: UIColor = UIColor.lightGray
    @IBInspectable var topBarBackGroundColor: UIColor = UIColor.white
    private var mainScrollView : UIScrollView = UIScrollView()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.reloadData()
    }
    func viewControllerAtIndex(index : Int) -> UIViewController {
        datasource1?.willMoveToViewController(pageController: self, index: index, viewController: arrOfVC[index])
        return arrOfVC[index]
    }
    
    func reloadData()  {
        arrOfVC = datasource1!.numberOfViewController(pageController: self).1
        arrOfTitles = (datasource1?.numberOfViewController(pageController: self).0)!
        
        if arrOfVC.count != arrOfTitles.count {
            print("Number of viewcontrollers should be equal to title")
            return;
        }else{
            numberOfVC = arrOfVC.count
        }
        selectionView = MasterPageSelectionView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 40))
        selectionView?.selectedIndexFontColor = self.selectedIndexFontColor
        selectionView?.unSelectedIndexFontColor = self.unSelectedIndexFontColor
        selectionView?.collectionView?.backgroundColor = self.topBarBackGroundColor
        selectionView?.underLineBackGroundColor = self.underLineColor
        self.addSubview(selectionView!)
        self.mainScrollView.frame = CGRect(x: 0, y: (selectionView?.frame.size.height)!, width: self.frame.size.width, height: self.frame.size.height - (selectionView?.frame.size.height)!)
        self.mainScrollView.isPagingEnabled = true
        
        
        
        self.addSubview(self.mainScrollView)
        
        selectionView?.titles = arrOfTitles
        selectionView?.selectMasterCellAtIndex(index: currentPageIndex)
        
        let vc = self.viewControllerAtIndex(index: currentPageIndex)
        vc.view.tag = currentPageIndex
        self.currentViewController = vc
        
        self.selectionView?.selectedIndex = {
            value in
            
            if value != self.currentViewController?.view.tag {
                self.selectionView?.selectMasterCellAtIndex(index: value)
                let vc = self.viewControllerAtIndex(index: value)
                vc.view.tag = value
                
                if vc.view.tag < (self.currentViewController?.view.tag)!  {
                    
                
                }else{
                    
                    
                }
                self.currentViewController = vc
            }
            
            
        }
        
        
    }

}
