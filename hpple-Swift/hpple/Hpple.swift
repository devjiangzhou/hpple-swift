//
//  Hpple.swift
//  hpple-Swift
//
//  Created by Jiangzhou on 14/6/9.
//  Copyright (c) 2014 Petta.mobi. All rights reserved.
//

import Foundation

class Hpple : NSObject {
    var data  : NSData
    var isXML : ObjCBool
    
    init(_data:NSData , _isXML:ObjCBool) {
        data  = _data
        isXML = _isXML
    }
    convenience init(htmlData:NSData){
       self.init(_data: htmlData,_isXML: false)
    }
    convenience init(xmlData:NSData){
         self.init(_data: xmlData,_isXML: false)
    }
    class func hppleWithData(data:NSData,isXML:ObjCBool) -> Hpple{
        return Hpple(_data:data,_isXML:isXML);
    }
    
    class func hppleWithHTMLData(htmlData:NSData) -> Hpple{
        return Hpple(_data:htmlData,_isXML: false);
    }
    class func hppleWithXMLData(xmlData:NSData) -> Hpple{
        return Hpple(_data:xmlData,_isXML: true);
    }
}


var data :NSData=NSData()
var hpple=Hpple(xmlData:data)
var hpple1=Hpple(htmlData:data)



