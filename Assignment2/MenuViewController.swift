//
//  MenuViewController.swift
//  Assignment2
//
//  Created by Nick on 21/11/2015.
//  Copyright (c) 2015 University of South Australia. All rights reserved.

import UIKit
import Foundation

class MenuViewController: DetailViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    var model = Model.sharedModel
    var count = 0
    
    var filteredData = [Item]()
    
    override var detailItem: AnyObject? {
        didSet {
            // Update the view.
        }
    }
    
    override func configureView() {
        collectionView!.dataSource = self
        collectionView!.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredData = model.itemsArray
        
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath = sender as! NSIndexPath
        let object = filteredData[indexPath.row]
        
        let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
        
        controller.detailItem = object
    }
    
    // MARK: UICollectionView Data Source
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! Cell
        cell.backgroundColor = UIColor.whiteColor()
        cell.cellImageView.image = filteredData[indexPath.row].image
        cell.nameL.text = filteredData[indexPath.row].name
        cell.priceL.text = filteredData[indexPath.row].price
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("showDetail", sender: indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (!searchText.isEmpty){
            
            if (model.itemsArray.count > 0){
                for index in 0 ... model.itemsArray.count - 1{
                    
                    //if text match in items array is found
                    if (model.itemsArray[index].name.lowercaseString.rangeOfString(searchText) != nil) {
                        //if that match doesn't already exist
                        if (model.searchArray(filteredData, target: model.itemsArray[index].uid) == -1){
                            filteredData.append(model.itemsArray[index])
                        }
                    //if no match is found
                    } else {
                        // if an item needs deleting because it no longer matches
                        if (model.searchArray(filteredData, target: model.itemsArray[index].uid) != -1){
                            filteredData.removeAtIndex(model.searchArray(filteredData, target: model.itemsArray[index].uid))
                        }
                        
                    }
                }
            }
        } else {
            //filteredData.removeAll(keepCapacity: false)
            filteredData = model.itemsArray
        }
        
        println("FILTERED DATA CONTAINS...")
        if (filteredData.count > 0){
            for i in 0 ... filteredData.count - 1 {
                println(filteredData[i].name)
            }
        }
        
        collectionView.reloadData()
        
    }
    
    
    
    @IBAction func cancelSearch(sender: UIButton) {
        searchBarOutlet.text = ""
        filteredData = model.itemsArray
        collectionView.reloadData()
        
        searchBarOutlet.translucent = false
        
    }

    
}
