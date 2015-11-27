//
//  HomeViewController.swift
//  Assignment2
//
//  Created by Nick on 21/11/2015.
//  Copyright (c) 2015 University of South Australia. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: DetailViewController {
    
    override var detailItem: AnyObject? {
        didSet {
            // Update the view.
        }
    }
    
    override func configureView() {
        
        detailImageView.image = UIImage(named: "logo.png")
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