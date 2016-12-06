//
//  FindResponseItem.swift
//  CapturePlusControl 1
//
//  Created by Henry Thomas on 22/11/2016.
//  Copyright © 2016 Henry Thomas. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class FindResponseItem: NSObject, Mappable {
    var
    Id: String?,
    ItemType: String?,
    Text: String?,
    Highlight: String?,
    Description: String?;
    
    required init(map: Map) {
        
    }
    
    override init(){
        self.Id = "";
        self.ItemType = "";
        self.Text = "";
        self.Highlight = "";
        self.Description = "";
    }
    
    func mapping(map: Map) {
        Id <- map["Id"];
        ItemType <- map["Type"];
        Text <- map["Text"];
        Highlight <- map["Highlight"];
        Description <- map["Description"];
    }
    
}
