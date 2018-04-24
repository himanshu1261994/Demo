    //
//  MasterPageControllerTitleCell.swift
//  LawyerApp
//
//  Created by indianic on 17/05/17.
//  Copyright © 2017 Indianic. All rights reserved.
//

import UIKit

class MasterPageControllerTitleCell: UICollectionViewCell {
 
    var titleLabel: UILabel = UILabel()
    var bottomView : UIView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        titleLabel.frame = CGRect.zero
        
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textAlignment = .center
        
        self.contentView.addSubview(titleLabel)
        bottomView.frame = CGRect(x: 0, y: titleLabel.frame.size.height, width: frame.size.width, height: 5)
        bottomView.backgroundColor = UIColor.red
        self.contentView.addSubview(bottomView)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.sizeToFit()
        titleLabel.frame.origin.x = 0
        titleLabel.frame.origin.y = 10
        bottomView.frame = CGRect(x: 0, y: titleLabel.frame.size.height+titleLabel.frame.origin.y, width: titleLabel.frame.size.width, height: 5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
