//
//  UniversitiesClass.swift
//  CollegeNames15
//
//  Created by Gabriel Querbes on 11/17/15.
//  Copyright © 2015 The Modern Tech. All rights reserved.
//

import Foundation


class UniversitiesClass{
    
    var name: String = ""
    var address: String = ""
    var URL: String = ""
    var studentCount = 0
    var imageUrl = ""
    var Id = 0
    
    
    //initializer (constructor) for univiersities
    init(name: String, address: String, URL:String, studentCount:Int, imageUrl: String, id: Int){
        self.name = name;
        self.address = address;
        self.URL = URL;
        self.studentCount = studentCount
        self.imageUrl = imageUrl
        self.Id = id
    }
    
    
    
    
}