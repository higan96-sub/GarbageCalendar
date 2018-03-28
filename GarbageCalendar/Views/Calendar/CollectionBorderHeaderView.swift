//
//  CollectionBorderHeaderView.swift
//  garbage_calendar
//
//  Created by Norihiko Oba on 2018/02/21.
//  Copyright © 2018年 Norihiko Oba. All rights reserved.
//

import UIKit

class CollectionBorderHeaderView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .bgGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
