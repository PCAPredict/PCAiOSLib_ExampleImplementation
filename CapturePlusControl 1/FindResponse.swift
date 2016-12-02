//
//  FindResponse.swift
//  CapturePlusControl 1
//
//  Created by Henry Thomas on 22/11/2016.
//  Copyright © 2016 Henry Thomas. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class FindResponse: Mappable {
    var Items: [FindResponseItem]?;
    
    required init(map: Map) {
        
    }
    
    init(){
        self.Items = [];
    }
    
    func mapping(map: Map) {
        Items <- map["Items"];
    }
    
}
