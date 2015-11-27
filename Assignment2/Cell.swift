//
//  Cell.swift
//  Assignment2
//
//  Created by Nick on 20/11/2015.
//  Copyright (c) 2015 University of South Australia. All rights reserved.
//

import Foundation
import UIKit

class Cell: UICollectionViewCell {
    let cellImageView = UIImageView()

    
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var priceL: UILabel!

    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)

        cellImageView.frame = CGRectMake(0, 0, 64, 64)
        cellImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        contentView.addSubview(cellImageView)
    }
}