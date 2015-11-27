//
//  CheckoutViewController.swift
//  Assignment2
//
//  Created by Nick on 23/11/2015.
//  Copyright (c) 2015 University of South Australia. All rights reserved.
//

import Foundation
import UIKit

class CheckoutViewController : DetailViewController, UITableViewDelegate, UITableViewDataSource {
    
    var model = Model.sharedModel
    
    var totalPrice = ""
    //var quantityDictionary = [String(): Item()]
    var quantityDictionary = Dictionary<String, String>();
    
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func configureView() {
        tableView!.dataSource = self
        tableView!.delegate = self
        costLabel.text = "0.0"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        self.automaticallyAdjustsScrollViewInsets = false
        
        populateArrays()
        //println(quantityDictionary)
        
        findTotal()
        

        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.cartStore.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCellWithIdentifier("CheckoutCell") as! CheckoutCell
        
        cell.cellUid = model.cartStore[indexPath.row].uid
        
        cell.imageview.image = model.cartStore[indexPath.row].image
        cell.nameLabel.text = model.cartStore[indexPath.row].name

        var cellItemPrice = model.cartStore[indexPath.row].price
        
        //priceArray!.append(model.cartStore[indexPath.row].price)

        //addToRunningTotal(getCellTotal(cellItemPrice, quantity: cell.getQuantity()))
        
        

        
        return cell
    }
    
    func populateArrays(){
        
        quantityDictionary.removeAll(keepCapacity: true)
        
        for count in 0...model.cartStore.count - 1{
            
            quantityDictionary.updateValue("1" , forKey: model.cartStore[count].uid)
            
        }
        
    }
    
    @IBAction func confirmPurchase(sender: UIButton) {
        
    
        var url = NSURL(string: "http://www.partiklezoo.com/products/?")!
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        var bodyData = "action=purchase&u0001=2&total=1990"
        //var bodyData2 = "action=purchase&coord1-34.9290&coord2138.6010"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithRequest(request, completionHandler:
            {(data, response, error) in
                
                
                let json = JSON(data: data)
                println(json)
                
        })
        task.resume()
    
    }
    
    func checkoutDetails(currentItem: Item) {
    

        
        
        
    }
    
    
    func getCellTotal(price: String, quantity: Int) -> Double {
    
//        var convertedPrice = (price as NSString).doubleValue
//        
//        var cellTotalPrice = Double(quantity) * convertedPrice
        
        return 1.0
    }
    
    func findTotal() {
        
        //loop through all cartStore
        
        //at each item --- find uid in dictionary -- get quantity value
        
        //convert price to double, times by quantity
        //add to total

        var grandTotal = "$"
        var currentPrice = ""
        var currentQuantity = ""
        var currentTotal = 0.0
        var runningTotal = 0.0
        
        
        for (uid, quantity) in quantityDictionary {
            
            
        
            for count in 0...model.cartStore.count - 1 {
                
                if (model.cartStore[count].uid == uid){
                    
                    currentPrice = model.cartStore[count].price
                    currentQuantity = quantity
                    
                }
                
                var dubConversion = (currentPrice as NSString).doubleValue
                var intConversion = (quantity as NSString).doubleValue
                
                
                currentTotal = (dubConversion * intConversion)
                
                runningTotal = runningTotal + currentTotal
            }

        }
        let s = NSString(format: "%.2", runningTotal)
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        let s2 = nf.stringFromNumber(runningTotal)
        
        
        //var runningOutput = runningTotal as String
        
        grandTotal = grandTotal + s2!
        totalPrice = grandTotal
        print(totalPrice)
        print(grandTotal)
        
        if let label = costLabel {
            costLabel.text = totalPrice
        }
        
        //costLabel.text = totalPrice
        
    }
    
//        for itemId in quantityDictionary.values {
//            
//            var price = model.cartStore
//        
//        }
        
//        for count in 0...model.cartStore.count - 1 {
//            
//            //let item1 = model.cartStore[count]
//            
//            for uid in quantityDictionary.keys {
//            
//                if uid == item1.uid
//                
//            }
//
//            
//        }
        
        //            var floatConversion = (priceS as NSString).doubleValue
        //            total += floatConversion
        
//        totalPrice! += price
//        
//        let s = NSString(format: "%.2", totalPrice!)
//        let nf = NSNumberFormatter()
//        nf.numberStyle = .DecimalStyle
//        let s2 = nf.stringFromNumber(totalPrice!)
//        grandTotal += s2!
//        
//        costLabel.text = grandTotal
        
    
        
//        var request = NSMutableURLRequest(URL: NSURL(string: "http://www.partiklezoo.com/products/")!)
//        var session = NSURLSession.sharedSession()
//        request.HTTPMethod = "POST"
//        
//        var stringToPass = "?&u0001=2&total=1990"
//        
//        var err: NSError?
//        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(stringToPass, options: nil, error: &err)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //var task2 = session.dataTaskWithRequest(request, completionHandler: {data, response, error)
        
//        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            println("Response: \(response)")
//            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
//            println("Body: \(strData)")
//            var err: NSError?
//            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSString
//            
//            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
//            if(err != nil) {
//                println(err!.localizedDescription)
//                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
//                println("Error could not parse JSON: '\(jsonStr)'")
//            }
//            else {
//                // The JSONObjectWithData constructor didn't return an error. But, we should still
//                // check and make sure that json has a value using optional binding.
//                if let parseJSON = json {
//                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
//                    //var success = parseJSON["success"] as? Int
//                    var success = parseJSON["success"] as? String
//                    println("Success: \(success)")
//                    
//                    
//                }
//                else {
//                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
//                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
//                    println("Error could not parse JSON: \(jsonStr)")
//                }
//            }
//        })
        
//        var jsonerror:NSError?
//        var postData = "?&u0001=2&total=1990"
//        let json = JSON(postData)
//        var url = NSURL(string: "http://www.partiklezoo.com/products/")
//        var post:NSData = json.rawData()!;
//        var postLength:NSString = String(post.length)
//        
//        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url!)
//        request.HTTPMethod = "POST"
//        request.HTTPBody = post
//        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        
//        if let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil) {
//            println(data)
//        }
        
//        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithURL(url!, completionHandler:
//            { (data, response, error)  in
//                
        
//        })        
        
        
        
        
    
//    }
}