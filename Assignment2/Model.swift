//
//  Model.swift
//  Assignment2
//
//  Created by Nick on 21/11/2015.
//  Copyright (c) 2015 University of South Australia. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Model {

    var segueArray = [String]()
    var segueDictionary = [String: UIImage]()
    //var itemsArray = [UIImage]()
    
    var itemsArray = [Item]() //recepies
    
    var carts: [Item] {
        get {
            var selected = [Item]()
            
            if (itemsArray.count > 0)
            {
                for count in 0...itemsArray.count - 1
                {
                    if itemsArray[count].inCart
                    {
                        selected.append(itemsArray[count])
                    }
                }
            }
            
            return selected
        }
    }
    
    var cartStore = [Item]() // favourites
    
    var NSCartOther = [NSManagedObject]()
    var NSCart = [NSManagedObject]()
    var NSJsonStore = [NSManagedObject]()
    static let sharedModel = Model()
    
    init(){
    
        segueDictionary = ["Home": UIImage(named: "home.png")!, "Search": UIImage(named: "search.png")!, "Menu": UIImage(named:"menu.png")!, "Cart": UIImage(named: "cart.png")!, "Finder": UIImage(named: "finder.png")!, "Checkout": UIImage(named: "checkout.png")!]
        //itemsArray = [UIImage(named: "home.png")!,UIImage(named: "search.png")!,UIImage(named: "menu.png")!, UIImage(named: "product.png")!, UIImage(named: "product.png")!, UIImage(named: "product.png")!]
        segueArray = segueDictionary.keys.array.reverse()
       
        
        //MARK -- load the products stored in Core Data
        loadProducts()
        
        //if Core Data is empty, refresh the products list
        if (NSJsonStore.count < 1){
            refreshItems()
            println("ran item refresh")
        }
        
        getCartItems()
        
        //println(itemsArray[1].price)
        //refreshCartItems()
    }
    
    func getCartItems(){

        if (itemsArray.count > 0)
        {
            for count in 0...itemsArray.count - 1
            {
                if itemsArray[count].inCart
                {
                    
                    if(searchCartForItem(itemsArray[count]) == -1){
                        cartStore.append(itemsArray[count])
                    } else {
                        println("already in cart -- didn't add")
                    }
                    
                    
                
                } else { //if the cart item needs deleting
                    var indexToDelete = searchCartForItem(itemsArray[count])
                    
                    if indexToDelete != -1 {
                    
                        cartStore.removeAtIndex(indexToDelete)
                    }
                
                }
            }
        }
        //debug
        if (cartStore.count > 0) {
        
            for count in 0...cartStore.count - 1 {
                
                println("--- Cart Items --- ")
                println("CURRENT ITEM : ")
                println(cartStore[count].name)
                println(cartStore[count].inCart)
            }
        }

    }
    
    
    func addItemToProducts(newProduct: Item!, imageURL: String){
        
        if (searchForExistingItem(newProduct) == -1) {
            
            //grab the image from the online database
            var newImage = getUrlImage(imageURL)
            newProduct.image = newImage
            let picture = UIImagePNGRepresentation(newImage)
            
            //add the product
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            var originalPicture = UIImage(named: "checkout.png")
            //println(originalPicture)
            //let picture = UIImagePNGRepresentation(originalPicture)
            //println(picture)
            let entity = NSEntityDescription.entityForName("Products", inManagedObjectContext: managedContext!)
            
            let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            item.setValue(picture, forKey: "image")
            item.setValue(newProduct.name, forKey: "name")
            item.setValue(newProduct.about, forKey: "about")
            item.setValue(newProduct.category, forKey: "category")
            item.setValue(newProduct.price, forKey: "price")
            item.setValue(newProduct.uid, forKey: "uid")
            item.setValue(newProduct.inCart, forKey: "inCart")
            
        
            var error : NSError?
            if(managedContext!.save(&error) ) {
                println(error?.localizedDescription)
            }
            
            
            
            NSJsonStore.append(item)
            itemsArray.append(newProduct)
            //println(itemsArray)
            
        }
        else {
           println("FAIL -- addItemToProducts")
        }
    }
    
    func getUrlImage(imageURL: String) -> UIImage {
        
        var image: UIImage!
        
        if let url = NSURL(string: imageURL){
            if let data = NSData(contentsOfURL: url){
                image = UIImage(data: data)
            }
        }
        return image!
    }
    
    

    

    
    func loadProducts() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Products")
        
        let results = managedContext?.executeFetchRequest(fetchRequest, error: nil)
        
        NSJsonStore = results as! [NSManagedObject]
        
        if (NSJsonStore.count > 0)
        {
            for index in 0 ... NSJsonStore.count - 1
            {
                let loadedItem = Item()
                
                let binaryData = NSJsonStore[index].valueForKey("image") as! NSData
                
                loadedItem.image = UIImage(data: binaryData)
                loadedItem.about = NSJsonStore[index].valueForKey("about") as! String
                loadedItem.name = NSJsonStore[index].valueForKey("name") as! String
                loadedItem.uid = NSJsonStore[index].valueForKey("uid") as! String
                loadedItem.inCart = NSJsonStore[index].valueForKey("inCart") as! Bool
                loadedItem.category = NSJsonStore[index].valueForKey("category") as! String
                loadedItem.price = NSJsonStore[index].valueForKey("price") as! String
                
                itemsArray.append(loadedItem)
            }
        }
    }
    
    func clearItemsArray(){
        
        itemsArray.removeAll(keepCapacity: false)
        
    }
    
    func searchArray(arrayToSearch: [Item], target: String) -> Int {
        var targetIndex = -1
        
        if (arrayToSearch.count > 0) {
            for index in 0 ... arrayToSearch.count - 1 {
                if (arrayToSearch[index].uid.isEqual(target)) {
                    targetIndex = index
                }
            }
        }
        
        return targetIndex
    }
    
    func searchForExistingItem(searchItem: Item) -> Int {
        var targetIndex = -1
        
        if (itemsArray.count > 0) {
            for index in 0 ... itemsArray.count - 1 {
                if (itemsArray[index].uid.isEqual(searchItem.uid)) {
                    targetIndex = index
                }
            }
        }
        
        return targetIndex
    }
    
    func searchCartForItem(searchItem: Item) -> Int {
        var targetIndex = -1
        
        println("CARTSTORE COUNT")
        println(cartStore.count)
        
        if (cartStore.count > 0) {
            for index in 0 ... cartStore.count - 1 {
                if (cartStore[index].uid.isEqual(searchItem.uid)) {
                    targetIndex = index
                }
            }
        }
        
        println("CART INDEX IS :")
        println("")
        println(targetIndex)
        
        return targetIndex
    
    }
    
    func isInCart(item: Item) -> Bool{
        if item.inCart == true{
            return true
        } else {
            return false
        }
    }
    
    func refreshItems(){
        var url = NSURL(string: "http://www.partiklezoo.com/products")
        //print(url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!,
            completionHandler:
            { (data, response, error) in
                //...work with data..
                let json = JSON(data: data)
                
                for count in 0 ... json.count - 1 {
                    //print(json[count]["name"].string)
                    var newProduct = Item()
                    newProduct.name = json[count]["name"].string
                    newProduct.uid = json[count]["uid"].string
                    newProduct.about = json[count]["description"].string
                    newProduct.category = json[count]["category"].string
                    newProduct.price = json[count]["price"].string
                    
                    //check if item is already in cart
                    //if (self.searchForExistingItem(newProduct) == -1) {
                    newProduct.inCart = false
                    //} else {
                        //newProduct.inCart = true
                    //}
                    
                    var imageurl = json[count]["image"].string
//                    println(newProduct.name)
//                    println(newProduct.about)
                    
                    self.addItemToProducts(newProduct, imageURL: imageurl!)
                }
                
            })
        task.resume()
        
    }
    
    func updateItemCartValue(newItem: Item!, inCart: Bool!) {
    
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        var fetchRequest = NSFetchRequest(entityName: "Products")
        
        fetchRequest.predicate = NSPredicate(format: "uid = %@", newItem.uid)
        
        if let fetchResults = appDelegate.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [NSManagedObject] {
            
            println("-- FETCHED RESULTS --")
            println(fetchResults)
            
            if fetchResults.count != 0 {
            
                var managedObject = fetchResults[0]
                managedObject.setValue(inCart, forKey: "inCart")
                managedContext!.save(nil)
                println("-- MANAGED OBJECT --")
                println(managedObject)
                
                clearItemsArray()
                loadProducts()
                
                
            }
            
        }
       
        
    }
    
    
    //    func refreshCartItems(){
    //
    //        if (itemsArray.count > 0){
    //
    //            for count in 0...itemsArray.count - 1 {
    //
    //                println("--- refreshCartItems --- ")
    //                println("CURRENT ITEM : ")
    //                println(itemsArray[count].name)
    //                println(itemsArray[count].inCart)
    //
    //                //if item should be in cart
    //                if itemsArray[count].inCart{
    //
    //
    //
    //                    //if item is not already in the cartStore array
    //                    if (searchCartForItem(itemsArray[count])) == -1 {
    //
    //                        println(itemsArray[count].name)
    //                        println("NOT FOUND IN CART -- ADDING TO CART NOW...")
    //
    //                        println("OLD CARTSTORE COUNT IS...")
    //                        println(cartStore.count)
    //
    //                        cartStore.append(itemsArray[count])
    //
    //
    //                        println("NEW CARTSTORE COUNT IS...")
    //                        println(cartStore.count)
    //                    }
    //
    //                //else if item shouldn't be in cart and is -- remove it
    //                } else if (searchCartForItem(itemsArray[count])) != -1 {
    //
    //                    println(itemsArray[count].name)
    //                    println("WAS FOUND IN CART BUT INCART IS FALSE -- DELETING FROM CART NOW...")
    //
    //                    println("OLD CARTSTORE COUNT IS...")
    //                    println(cartStore.count)
    //
    //                    cartStore.removeAtIndex(searchCartForItem(itemsArray[count]))
    //
    //                    println("NEW CARTSTORE COUNT IS...")
    //                    println(cartStore.count)
    //                }
    //            }
    //        }
    //    
    //    }
    
    
//    func cart(){
//        
//        NSCart.removeAll(keepCapacity: false)
//        
//        //var selectedItems = [Item]()
//            
//        if (itemsArray.count > 0)
//        {
//            for count in 0...itemsArray.count - 1
//            {
//                if itemsArray[count].inCart
//                {
//                    //selectedItems.append(itemsArray[count])
//                    NSCart[count].append(itemsArray[count])
//                }
//            }
//        }
//            
//        
//        
//        
//    }
//
//   func reloadFavourites() {
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//    
//        let managedContext = appDelegate.managedObjectContext
//    
//        let fetchRequest = NSFetchRequest(entityName: "Products")
//        
//        fetchRequest.predicate = NSPredicate(format: "inCart = %@", "true")
//    
//        if let fetchResults = appDelegate.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [NSManagedObject] {
//        
//            if fetchResults.count != 0 {
//                
//                for i in 0 ... fetchResults.count - 1 {
//                    var managedObject = fetchResults[i]
//                    if ()
//                }
//                
//                
//            }
//        
//        }
    
//    func fav(){
//    
//        NSCart.removeAll(keepCapacity: false)
//    
//
//        
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let managedContext = appDelegate.managedObjectContext
//        
//        let entity =  NSEntityDescription.entityForName("Products", inManagedObjectContext:managedContext!)
//        
//        let cartItem = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
//        
//        if (itemsArray.count > 0)
//        {
//            for count in 0...itemsArray.count - 1
//            {
//                if itemsArray[count].inCart
//                {
//                    
//                    NSCart.append(cartItem)
//                }
//            }
//        }
//        
//        
//    }
    
    //        if (cartStore.count > 0) {
    //
    //            for index in 0 ... NSCart.count - 1 {
    //
    //                let binaryData = NSCart[index].valueForKey("image") as! NSData
    //
    //                let image = UIImage(data: binaryData)
    //
    //                cartStore.append(N)
    //            }
    //        }
    
    
    //    func deleteItemFromCart(deleteItem: Item!) {
    //        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    //
    //        let managedContext = appDelegate.managedObjectContext
    //
    //        // Find which one we need to delete
    //        var targetIndex = self.searchCartForItem(deleteItem)
    //
    //        if (targetIndex != -1)
    //        {
    //            managedContext?.deleteObject(NSCart[targetIndex])
    //            managedContext?.save(nil)
    //
    //            NSCart.removeAtIndex(targetIndex)
    //            cartStore.removeAtIndex(targetIndex)
    //        }
    //    }
    
    //    func addItemtoCart(newCartItem: Item!){
    //
    //        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    //        let managedContext = appDelegate.managedObjectContext
    //
    //        if (searchForExistingItem(newCartItem) == -1) {
    //
    //            //grab the image from the online database
    //            var newImage = getUrlImage(imageURL)
    //            newProduct.image = newImage
    //            let picture = UIImagePNGRepresentation(newImage)
    //
    //            //add the product
    //            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    //            let managedContext = appDelegate.managedObjectContext
    //            var originalPicture = UIImage(named: "checkout.png")
    //            //println(originalPicture)
    //            //let picture = UIImagePNGRepresentation(originalPicture)
    //            //println(picture)
    //            let entity = NSEntityDescription.entityForName("Products", inManagedObjectContext: managedContext!)
    //
    //            let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
    //
    //            item.setValue(picture, forKey: "image")
    //            item.setValue(newProduct.name, forKey: "name")
    //            item.setValue(newProduct.about, forKey: "about")
    //            item.setValue(newProduct.category, forKey: "category")
    //            item.setValue(newProduct.price, forKey: "price")
    //            item.setValue(newProduct.uid, forKey: "uid")
    //            item.setValue(newProduct.inCart, forKey: "inCart")
    //
    //
    //            var error : NSError?
    //            if(managedContext!.save(&error) ) {
    //                println(error?.localizedDescription)
    //            }
    //
    //
    //
    //            NSJsonStore.append(item)
    //            itemsArray.append(newProduct)
    //            //println(itemsArray)
    //
    //        }
    //        else {
    //            println("FAIL -- addItemToProducts")
    //        }
    //    }
    
    //adds to cartStore and NSCart
    //    func addItemToCart(newItem: Item!) {
    //
    //        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    //        let managedContext = appDelegate.managedObjectContext
    //
    //        let entity =  NSEntityDescription.entityForName("Products", inManagedObjectContext:managedContext!)
    //
    //        let cartItem = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
    //
    //        var newImage = newItem.image
    //        let picture = UIImagePNGRepresentation(newImage)
    //
    //        cartItem.setValue(newItem.name, forKey: "name")
    //        cartItem.setValue(picture, forKey: "image")
    //        cartItem.setValue(newItem.name, forKey: "name")
    //        cartItem.setValue(newItem.about, forKey: "about")
    //        cartItem.setValue(newItem.category, forKey: "category")
    //        cartItem.setValue(newItem.price, forKey: "price")
    //        cartItem.setValue(newItem.uid, forKey: "uid")
    //        cartItem.setValue(newItem.inCart, forKey: "inCart")
    //        
    //        
    //        var error : NSError?
    //        if(managedContext!.save(&error) ) {
    //            println(error?.localizedDescription)
    //        }
    //        
    //        NSCart.append(cartItem)
    //        cartStore.append(newItem)
    //        
    //    }

}