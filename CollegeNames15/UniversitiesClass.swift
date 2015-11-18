//
//  UniversitiesClass.swift
//  CollegeNames15
//
//  Created by Gabriel Querbes on 11/17/15.
//  Copyright © 2015 The Modern Tech. All rights reserved.
//

import Foundation


class UnivsersitiesClass{
    
    var name: String = ""
    var addres: String = ""
    var URL: String = ""
    var studentCount = 0
    
    //initializer (constructor) for univiersities 
    init(name: String, address: String, URL:String, studentCount:Int ){
        self.name = name;
        self.addres = address;
        self.URL = URL;
        self.studentCount = studentCount
    }
    
    
    
    
}