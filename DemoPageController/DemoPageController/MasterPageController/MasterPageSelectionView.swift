//
//  MasterPageSelectionView.swift
//  LawyerApp
//
//  Created by indianic on 16/05/17.
//  Copyright © 2017 Indianic. All rights reserved.
//

import UIKit

class MasterPageSelectionView: UIView,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate {

   
    var titles : [String] = []
    
    private var selectedCell: Int = 0
    var collectionView : UICollectionView?
    var selectedIndex : (Int) -> () = {_ in}
    
    var selectedIndexFontColor : UIColor = UIColor.black
    var unSelectedIndexFontColor : UIColor = UIColor.lightGray
    var underLineBackGroundColor : UIColor = UIColor.black
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.selectedIndex(selectedCell)
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.size.width-50, height: frame.size.height), collectionViewLayout: layout)
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.register(MasterPageControllerTitleCell.classForCoder(), forCellWithReuseIdentifier: "MasterPageControllerTitleCell")
        collectionView?.backgroundColor = UIColor.white
    
        self.addSubview(collectionView!)
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MasterPageControllerTitleCell", for: indexPath) as!MasterPageControllerTitleCell
        
        cell.titleLabel.text = titles[indexPath.row]
        cell.bottomView.backgroundColor = underLineBackGroundColor
        if indexPath.row == selectedCell {
            cell.bottomView.isHidden = false
            cell.titleLabel.textColor = selectedIndexFontColor
        }else{
        cell.bottomView.isHidden = true
            cell.titleLabel.textColor = unSelectedIndexFontColor
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title : String = titles[indexPath.row]
        
        let width : CGFloat = title.widthOfString(usingFont: UIFont.systemFont(ofSize: 17))
       
        return CGSize(width: width+20, height: frame.size.height)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex(indexPath.row)
    }
    func selectMasterCellAtIndex(index : Int)  {
        
        selectedCell = index
        
        let indexPath : IndexPath = IndexPath(item: selectedCell, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView?.reloadData() 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.height
    }
}
