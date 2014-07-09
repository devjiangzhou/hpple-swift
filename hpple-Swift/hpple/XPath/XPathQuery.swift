//
//  XPathQuery.swift
//  hpple-Swift
//
//  Created by BaiJiangzhou on 14-6-15.
//  Copyright (c) 2014 Petta.mobi. All rights reserved.
//

import Foundation

class XPathQuery :NSObject  {
    //    class func PerformHTMLXPathQuery(document:NSData,query:String) -> Array{
    //
    //    }
    //
    //    class func PerformXMLXPathQuery(document:NSData,query:String) -> Array{
    //
    //    }
    
    func dictionaryForNode(currentNote:xmlNodePtr, parentResult:NSMutableDictionary?, parentContent:Bool) -> NSMutableDictionary{
        
        var resultForNode : NSMutableDictionary? = NSMutableDictionary()
        
        var node: UnsafePointer<xmlNode> = UnsafePointer<xmlNode>(currentNote) //struct‘s pointer
        //name
        var currentNodeName:UnsafePointer<xmlChar> = UnsafePointer<xmlChar>(node.memory.name) // name xmlchar's pointer
        
        if  currentNodeName  {
            var name:CString? = CString(currentNodeName) as CString  //convert to cstring
            resultForNode!["nodeName"]  = String.fromCString(name!) as String
        }
        
        // content
        var currentNodeContent:UnsafePointer<xmlChar> = UnsafePointer<xmlChar>(node.memory.content) // name xmlchar's pointer
        
        if currentNodeContent && currentNodeContent != UnsafePointer<xmlChar>(-1){
            var content = CString(currentNodeContent) as CString
            var contentStr : String = String.fromCString(content) as String   //convert to cstring
            
            if parentResult?.count > 0 && "text" == parentResult!["nodeName"] as NSString {
                parentResult!["nodeContent"] = contentStr.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                return nil!
            }
            resultForNode!["nodeName"]  = contentStr
        }
        
        var attribute:UnsafePointer<_xmlAttr> = UnsafePointer<_xmlAttr>(node.memory.properties) // name xmlchar's pointer
        
        if attribute {
            var attributeArray :NSMutableDictionary[] = [ ]
            while attribute {
                var attributeDictionary = NSMutableDictionary()
                //name
                var attributeName:UnsafePointer<xmlChar> = UnsafePointer<xmlChar>(attribute.memory.name) // name xmlchar's pointer
                if attributeName {
                    var name:CString? = CString(attributeName) as CString  //convert to cstring
                    attributeDictionary["attributeName"] = String.fromCString(name!) as String
                }
                
                // children
                var children:UnsafePointer<xmlNode> = UnsafePointer<xmlNode>(attribute.memory.children) // name xmlchar's pointer
                if children {
                    var  childrenDictionary : NSMutableDictionary?  = dictionaryForNode(children, parentResult: attributeDictionary, parentContent: false)
                    if childrenDictionary{
                        attributeDictionary["attributeContent"] = childrenDictionary
                    }
                }
                if attributeDictionary.count > 0  {
                    attributeArray.append(attributeDictionary)
                }
                var next:UnsafePointer<_xmlAttr> = UnsafePointer<_xmlAttr>(attribute.memory.next) // name xmlchar's pointer
                attribute = next
            }
            
            if attributeArray.count > 0 {
                resultForNode!["nodeAttributeArray"] = attributeArray
            }
        }
        
        
        var childNode:UnsafePointer<xmlNode> = UnsafePointer<xmlNode>(attribute.memory.children) // name xmlchar's pointer
        if childNode {
            var childContentArray :NSMutableDictionary[] = [ ]
            while childNode {
                var  childDictionary : NSMutableDictionary?  = dictionaryForNode(childNode, parentResult: resultForNode!, parentContent: false)
                if childDictionary{
                    childContentArray.append(childDictionary!)
                }
                
                var next:UnsafePointer<xmlNode> = UnsafePointer<xmlNode>(childNode.memory.next) // name xmlchar's pointer
                childNode = next
            }
            if childContentArray.count > 0 {
                resultForNode!["nodeAttributeArray"] = childContentArray
            }
        }
        
        var buffer : UnsafePointer<xmlBuffer> = UnsafePointer<xmlBuffer>()
        buffer = xmlBufferCreate()
        //      xmlNodeDump(buffer, currentNode->doc, currentNode, 0, 0);
        var doc:UnsafePointer<_xmlDoc> = UnsafePointer<_xmlDoc>(node.memory.doc) // name xmlchar's pointer
        xmlNodeDump(buffer, doc, node, CInt(0),CInt(0))
        
//        AVCaptureVideoPreviewLayer
//        if resultForNode.isKindClass(NSDict)
        
        var rawContent:UnsafePointer<xmlChar> = UnsafePointer<xmlChar>(buffer.memory.content) // name xmlchar's pointer
        if rawContent {
            var  content:CString? = CString(rawContent) as CString  //convert to cstring
            resultForNode!["raw"] = String.fromCString(content!)
        }
        xmlBufferFree(buffer)
        
        return resultForNode!
    }
    
    func PerformXPathQuery(doc : xmlDocPtr , query : String) -> NSMutableArray {
        
        var xpathCtx : UnsafePointer<xmlXPathContext>
        var xpathObj : UnsafePointer<xmlXPathObject>
        
        // affirm string is String Type
        if query.isEmpty {
             return nil!
        }
        
        xpathCtx = xmlXPathNewContext(doc)
        
        if !xpathCtx {
            print("Unable to create XPath context.")
            return nil!
        }
        
        
     var  queryString : CString = query.bridgeToObjectiveC().UTF8String
     var queryPtr : UnsafePointer<xmlChar> = UnsafePointer<xmlChar>(queryString._bytesPtr)
        
     xpathObj = xmlXPathEvalExpression(queryPtr,xpathCtx)
    
        if !xpathObj {
            print("Unable to evaluate XPath.")
            xmlXPathFreeContext(xpathCtx)
            return nil!
        }
        
        
        var nodes:UnsafePointer<xmlNodeSet> = UnsafePointer<xmlNodeSet>(xpathObj.memory.nodesetval) // name xmlchar's pointer
        if !nodes {
            print("Nodes was nil.")
            xmlXPathFreeObject(xpathObj);
            xmlXPathFreeContext(xpathCtx);
            return nil!
        }
        
        
        var resultNodes : NSMutableArray = NSMutableArray()
        
        
        var nodeNr :CInt =  nodes.memory.nodeNr
        
        
        for  index in 0..nodeNr {
            
            var nodePtr = nodes.memory.nodeTab[Int(index)]
            var node : NSMutableDictionary = dictionaryForNode(nodePtr , parentResult: nil , parentContent: false)
            if node != nil {
                resultNodes.addObject(node)
            }
        }
        
//            NSDictionary *nodeDictionary = DictionaryForNode(nodes->nodeTab[i], nil,false);
        
        
        /* Cleanup */
        xmlXPathFreeObject(xpathObj);
        xmlXPathFreeContext(xpathCtx);
        
        return resultNodes
    }
    
}


