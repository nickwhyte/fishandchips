//
//  CartViewController.swift
//  Assignment2
//
//  Created by Nick on 21/11/2015.
//  Copyright (c) 2015 University of South Australia. All rights reserved.
//

import Foundation
import UIKit


class CartViewController: DetailViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var priceLabel: UILabel!

    var model = Model.sharedModel
    

    override var detailItem: AnyObject? {
        didSet {
            // Update the view.
        }
    }
    
    override func configureView() {
        collectionView!.dataSource = self
        collectionView!.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.collectionView!.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        priceLabel.text = findTotalCost()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        self.automaticallyAdjustsScrollViewInsets = false
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath = sender as! NSIndexPath
        let object = model.cartStore[indexPath.row]
        
        let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
        
        controller.detailItem = object
    }
    
    // MARK: UICollectionView Data Source
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        println("-- CARTSTORE COUNT --")
//        println(model.cartStore.count)
        return model.cartStore.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! Cell
        cell.backgroundColor = UIColor.whiteColor()
        cell.cellImageView.image = model.cartStore[indexPath.row].image
        cell.nameL.text = model.cartStore[indexPath.row].name
        cell.priceL.text = model.cartStore[indexPath.row].price
        
//        println("-- MADE A CELL FOR --")
//        println(model.cartStore[indexPath.row].name)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetail", sender: indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
    }
    
    func findTotalCost() -> String{
        
        var total = 0.00
        var grandTotal = ""
        
        if (model.cartStore.count > 0){
            for price in 0 ... model.cartStore.count - 1{
                var priceS = model.cartStore[price].price
                
                var floatConversion = (priceS as NSString).doubleValue
                total += floatConversion
            }
            let dollarSign = "$"
            grandTotal += dollarSign
            
            let s = NSString(format: "%.2", total)
            let nf = NSNumberFormatter()
            nf.numberStyle = .DecimalStyle
            let s2 = nf.stringFromNumber(total)
            grandTotal += s2!
            
  
        }
        return grandTotal
    }

}