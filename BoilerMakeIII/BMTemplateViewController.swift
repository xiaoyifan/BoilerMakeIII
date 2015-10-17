//
//  BMTemplateViewController.swift
//  BoilerMakeIII
//
//  Created by Yi Qin on 10/17/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import UIKit

class BMTemplateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        if let arr = loadData() {
            for var i = 0; i < arr.count; i++ {
                let dict = arr.objectAtIndex(i) as! NSDictionary
                let frame = rectFromDict(dict)
                
                switch dict["type"] as! NSString {
                case BMComponentType.Label.rawValue:
                    let label = BMLabel(frame: frame, dict: dict)
                    self.view.addSubview(label)
                    print(label.dictionary)
                    break
                case BMComponentType.Button.rawValue:
                    let button = BMButton(frame: frame, dict: dict)
                    self.view.addSubview(button)
                    print(button.dictionary)
                    break;
                case BMComponentType.ImageView.rawValue:
                    let imageView = BMImageView(frame: frame, dict: dict)
                    self.view.addSubview(imageView)
                    break;
                default:
                    break
                }
            }
            
        } else {
            print("WARNING: Couldn't create dictionary from UIData.plist! Default values will be used!")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Helper Functions
    
    func rectFromDict(dict: NSDictionary) -> CGRect {
        let x: CGFloat = dict["x"] as! CGFloat * screenWidth
        let y: CGFloat = dict["y"] as! CGFloat * screenHeight
        let width: CGFloat = dict["width"] as! CGFloat * screenWidth
        let height: CGFloat = dict["height"] as! CGFloat * screenHeight
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    // MARK: Data Load/Save
    
    func loadData() -> NSArray? {
        // getting path to UIData.plist
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("UIData.plist")
        print(path)
        let resultArray = NSArray(contentsOfFile: path)
        print("Loaded UIData.plist file is --> \(resultArray)")
        let myArr = NSArray(contentsOfFile: path)
        return myArr
    }
    
    

}