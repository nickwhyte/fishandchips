//
//  ItemViewController.swift
//  Assignment2
//
//  Created by Nick on 21/11/2015.
//  Copyright (c) 2015 University of South Australia. All rights reserved.
//

import Foundation
import UIKit

class ItemViewController : DetailViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var about: UITextView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var categoryL: UILabel!
    @IBOutlet weak var priceL: UILabel!

    
    var model = Model.sharedModel
    
    override var detailItem: AnyObject? {
        didSet {
            // Update the view.
        }
    }
    
    override func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            
            imageView.image = (detail as! Item).image! as UIImage
            about.text = (detail as! Item).about!
            nameL.text = (detail as! Item).name!
            priceL.text = (detail as! Item).price!
            categoryL.text = (detail as! Item).category!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    @IBAction func addToCart(sender: UIBarButtonItem) {
        
        //if its not in the cart
        if(model.searchCartForItem(detailItem as! Item) == -1){
            model.updateItemCartValue(detailItem as! Item, inCart: true)
            model.getCartItems()
        } else { // if its already in the cart
            println("cart item deleted")
            model.updateItemCartValue(detailItem as! Item, inCart: false)
            model.getCartItems()
        }
        
//        model.updateItemCartValue(detailItem as! Item, inCart: true)
//        model.getCartItems()
        

//        if (model.isInCart(detailItem as! Item) == true) {
        
            
            
            
            // delete item from cart
            
//            println("ITEM WAS ALREADY IN CART ---  item deleted from both cart stores")
//            
//            model.updateItemCartValue(detailItem as! Item, inCart: false)
//            println("----------------- PRINTING NEW ITEMS ARRAY -------------------")
//            for number in 0 ... model.itemsArray.count - 1 {
//                
//                println(model.itemsArray[number].name)
//                println(model.itemsArray[number].inCart)
//                
//                
//            }
//            model.refreshCartItems()
            //viewWillAppear(true)
            
            //model.deleteItemFromCart(detailItem as! Item)
            
//            
//        } else {
//            //put item in cart
//            
//            println("ITEM WAS NOT IN CART ---  putting item in cart")
//            
//            model.updateItemCartValue(detailItem as! Item, inCart: true)
//            println("----------------- PRINTING NEW ITEMS ARRAY -------------------")
//            for number in 0 ... model.itemsArray.count - 1 {
//                
//                println(model.itemsArray[number].name)
//                println(model.itemsArray[number].inCart)
//                
//                
//            }
//            model.refreshCartItems()
            //viewWillAppear(true)
            
            //model.addItemToCart(detailItem as! Item)
            
//        }
        
//        if ((detailItem as! UIImage) == -1) {
//            model.addItemToCartStore(detailItem as! UIImage)
//        }
//        else {
//            model.deleteItemFromCart(detailItem as! UIImage)
//       }
    }
    
}

