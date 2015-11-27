//
//  MasterViewController.swift
//  test3
//
//  Created by Nick on 20/11/2015.
//  Copyright (c) 2015 University of South Australia. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    
    var objects = [AnyObject]()
    
    //var segueArray = [String]()
    //var homeImage = UIImage(named: "home.png")
    ////var menuImage = UIImage(named: "menu.png")
    //var segueDictionary = Dictionary<String, UIImage>();
    
    let model = Model.sharedModel
    
    
//        override func awakeFromNib() {
//            super.awakeFromNib()
//        }
    
    func populateArrays(){
        //segueDictionary = ["Home": homeImage!, "Menu": menuImage!]
        //segueArray = model.segueDictionary.keys.array.reverse()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count - 1].topViewController as? DetailViewController
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let indexPath = self.tableView.indexPathForSelectedRow()
        {
            let controller = segue.destinationViewController.topViewController as! DetailViewController
            
            //println((segue.destinationViewController as! UINavigationController).topViewController)
            
            //controller.detailItem = model.segueArray[indexPath.row]
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }

    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if let indexPath = self.tableView.indexPathForSelectedRow() {
//            let object = model.segueDictionary[segueArray[indexPath.row]]
//            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
//            controller.detailItem = object
//            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
//            controller.navigationItem.leftItemsSupplementBackButton = true
//            
//        }
//        
//    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.segueArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel!.text = model.segueArray[indexPath.row]
        cell.imageView!.image = model.segueDictionary[model.segueArray[indexPath.row]]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        self.performSegueWithIdentifier(model.segueArray[indexPath.row], sender: self)
        
    }
    
}

