//
//  ViewController.swift
//  AppPreferencesInSettingsTask
//
//  Created by Robert Berry on 2/20/18.
//  Copyright © 2018 Robert Berry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var favoriteFoodTextView: UITextView!
    
    @IBOutlet weak var favoriteMovieTextView: UITextView!
    
    @IBOutlet weak var favoriteBookTextView: UITextView!
    
    // Code will deinit property observer. Not needed for iOS9 and above. ARC deals with the observer.
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Register the settings bundle with NSUserDefaults.
    
    func registerSettingsBundle() {
        
        let appDefaults = [String: AnyObject]()
        
        UserDefaults.standard.register(defaults: appDefaults)
    }
    
    // Return app defaults.
    
    func updateDisplayFromDefaults() {
        
        // Get the defaults.
        
        let defaults = UserDefaults.standard
        
        // Read the key-value pairs and assign them to our outlets.
        
        // The string(forKey:) method returns an optional value. The code checks for a nil value and reacts accordingly.
        
        if let favFood = defaults.string(forKey: "FavoriteFood") {
            
            favoriteFoodTextView.text = favFood
            
        } else {
            
            favoriteFoodTextView.text = "Favorite food not available as you have not entered favorite food. Please enter favorite food in app settings."
        }
        
        if let favMovie = defaults.string(forKey: "FavoriteMovie") {
            
            favoriteMovieTextView.text = favMovie
            
        } else {
            
            favoriteMovieTextView.text = "Favorite movie not available as you have not entered favorite movie. Please enter favorite movie in app settings."
        }
        
        if let favBook = defaults.string(forKey: "FavoriteBook") {
            
            favoriteBookTextView.text = favBook
            
        } else {
            
            favoriteBookTextView.text = "Favorite book not available as you have not entered favorite book. Please enter favorite book in app settings."
        }
    }
    
    // Runs when we have a notification that the user defaults have changed.
    
    @objc func defaultsChanged() {
        
        updateDisplayFromDefaults()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        registerSettingsBundle()
        updateDisplayFromDefaults()
        
        // NotificationCenter is an observer that lets us know when the user defaults have changed.
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

