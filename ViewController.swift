//
//  ViewController.swift
//  PruebaJSON
//
//  Created by Joaquín Jiménez García on 28/12/17.
//  Copyright © 2017 Joaquín Jiménez García. All rights reserved.
//

import UIKit

// Make classes to match with the JSON properties schema
// Must extends from Decodable to use JSONDecoder easily
struct WebsiteDescription: Decodable {
    let name: String
    let description: String
    let courses: [Course]
}

struct Course: Decodable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Take the url of the json with data in a string
        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
        // Cast it into a URL object
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) {
            (data, response, err) in
            // Make sure than data exists
            guard let data = data else {return}
            
            do {
                // Decode the json given in the url into the object(s) of the classes
                // created before
                let webSite = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                // Get the name of the first course
                print(webSite.courses[0].name)
            } catch _ {
                
            }
            
            
        }.resume() // Finish the connection
    }
}

