//
//  CheckoutCell.swift
//  Assignment2
//
//  Created by Nick on 23/11/2015.
//  Copyright (c) 2015 University of South Australia. All rights reserved.
//

import Foundation
import UIKit

class CheckoutCell: UITableViewCell {
    
    //let checkOutClass = CheckoutViewController()
    let checkOut = CheckoutViewController()
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var cellUid = ""
    
    @IBOutlet weak var quantityInput: UITextField!
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        
    }
    
    
    @IBAction func changeQuantity(sender: UITextField) {
        
        checkOut.populateArrays()
        
        checkOut.quantityDictionary.updateValue(quantityInput.text, forKey: cellUid)
        
        checkOut.findTotal()
        
        println("BALLS")
        println("BALLS")
        println("BALLS")
        println("BALLS")
        println("BALLS")
        println("BALLS")
        
        
    }
    
//    func getQuantity() -> Int {
//        
//        var quantity = quantityInput.text.toInt()
//
//        return quantity!
//    }
//    

    
}