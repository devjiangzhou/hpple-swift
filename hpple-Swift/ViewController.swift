//
//  ViewController.swift
//  hpple-Swift
//
//  Created by Jiangzhou on 14/6/9.
//  Copyright (c) 2014年 Petta.mobi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
                            
    var stillImageOutput:AVCaptureStillImageOutput?
    var session:AVCaptureSession?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        session = AVCaptureSession()
//        previewView.session = session
        
        stillImageOutput = AVCaptureStillImageOutput()
       ( stillImageOutput?.outputSettings as  NSMutableDictionary)[AVVideoPixelAspectRatioKey] = AVVideoCodecJPEG
 
        session?.addOutput(stillImageOutput)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        session?.startRunning()
    }
    
    
    @IBAction func actionTakePhotos(sender : AnyObject)
    {
        var connection = stillImageOutput?.connectionWithMediaType(AVMediaTypeVideo)
        var error = NSError()
    stillImageOutput?.captureStillImageAsynchronouslyFromConnection(connection, nil)
//        stillImageOutput?.captureStillImageAsynchronouslyFromConnection(connection, handler: { (buffer : CMSampleBuffer , error:NSError) -> Void in
        stillImageOutput?.captureStillImageAsynchronouslyFromConnection(connection, completionHandler: {(CMSampleBuffer, error) -> Void in
            
            })
        
    }


}

