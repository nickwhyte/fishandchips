//
//  DetailViewController.swift
//  test3
//
//  Created by Nick on 20/11/2015.
//  Copyright (c) 2015 University of South Australia. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailDescription: UILabel!
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
        }
    }
    
    func configureView() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

//class DetailViewController: UIViewController{
//    
//    @IBOutlet weak var detailDescriptionLabel: UILabel!
//    
//    @IBOutlet weak var detailImageView: UIImageView!
//
//    
//    var model = Model()
//    var detailItem: String?
//    
//    // MARK - UICollectionView Data Source Methods
//    
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
//        return model.menu.count
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
//        
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! Cell
//        cell.cellImageView.image = model.menu[indexPath.row]
//        return cell
//    }
//    
//    // MARK - UICollectionView -user response- -empty-
//    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
//    {}
//    
//    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath)
//    {}
//    
//    //Update user interface for the image item that needs to display
//    
//    func configureImageView(){
//    
//        detailImageView.image = model.segueDictionary[detailItem!]
//    }
//    
//    func configureCollection(){
//    
//        collectionView!.dataSource = self
//        collectionView!.delegate = self
//    }
//    
////    var detailItem: AnyObject? {
////        didSet {
////            // Update the view.
////            self.configureView()
////        }
////    }
//    
////    func configureView() {
////        // Update the user interface for the detail item.
////        if let detail: AnyObject = self.detailItem {
////            if let label = self.detailDescriptionLabel {
////                label.text = detail.description
////                detailImageView.image = detail as! UIImage
////            }
////        }
////    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        
//        if detailItem == "Home" {
//            configureImageView()
//        } else if detailItem == "Search"{
//            configureImageView()
//        } else if detailItem == "Menu" {
//            configureCollection()
//        } else if detailItem == "Checkout" {
//            configureImageView()
//        } else if detailItem == "Finder" {
//            configureImageView()
//        } else if detailItem == "Cart" {
//            configureCollection()
//        }
//        
//        
////        if detailItem == "Home" || detailItem == "Search" {
////            configureImageView()
////        } else if detailItem == "Menu"{
////            configureCollectionView()
////        }
//        
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    
//}

