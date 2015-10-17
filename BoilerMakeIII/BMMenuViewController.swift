//
//  BMMenuViewController.swift
//  BoilerMakeIII
//
//  Created by Yifan Xiao on 10/17/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import UIKit


class BMMenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
@IBOutlet weak var menuCollectionView: UICollectionView!
    
    var collectionData: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        let path = NSBundle.mainBundle().pathForResource(deviceFileName, ofType: plistType)
        let dict = NSDictionary(contentsOfFile: path!)
        
        collectionData = dict!.objectForKey("iOSDevice") as! [String]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(mainCellReuseIdentifier, forIndexPath: indexPath) as! BMMenuCollectionViewCell
        
        cell.cellTextLabel.text = collectionData[indexPath.row]
        cell.cellImage.image = UIImage(named: "\(collectionData[indexPath.row]).png")
        
        cell.contentView.layer.cornerRadius = 12.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clearColor().CGColor
        cell.contentView.layer.masksToBounds = true
        
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = (self.view.frame.size.width - 22.0)/2.0
        
     return CGSize(width: width, height: width)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
            let scaleDownAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
            scaleDownAnimation.fromValue = NSValue(CGSize: CGSizeMake(0.95, 0.95))
            scaleDownAnimation.springBounciness = 18;
            scaleDownAnimation.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
            let selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as! BMMenuCollectionViewCell
        
            selectedCell.highlighted = true
            self.view.userInteractionEnabled = false
            selectedCell.cellImage.layer.pop_addAnimation(scaleDownAnimation, forKey: "scaleAnimation")
        
            scaleDownAnimation.completionBlock = {(animation, finished) in

                self.view.userInteractionEnabled = true
                
                self.showOkayCancelAlert(indexPath)
            }
        
    }
    
    func showOkayCancelAlert(_: NSIndexPath) {
        let title = "Select the action"
        let editButtonTitle = "Edit"
        let playButtonTitle = "Play"
        let cancelButtonTitle = "Cancel"
        
        let alertCotroller = DOAlertController(title: title, message: nil, preferredStyle: .Alert)
        
        let editAction = DOAlertAction(title: editButtonTitle, style: .Default) { action in
            
            alertCotroller.dismissViewControllerAnimated(true, completion: { () -> Void in
                
                let vc = BMPanelViewController()
//                UIApplication.sharedApplication().delegate?.window!?.rootViewController?.presentViewController(vc, animated: true, completion: nil)

                self.presentViewController(vc, animated: true, completion: nil)
                
            })
        
            
        }
        
        let playAction = DOAlertAction(title: playButtonTitle, style: .Default) { action in
            
            alertCotroller.dismissViewControllerAnimated(true, completion: { () -> Void in
               
                let vc = BMPanelViewController()
                self.presentViewController(vc, animated: true, completion: nil)

                
                
            })
            
            
        }
        
        let cancelAction = DOAlertAction(title: cancelButtonTitle, style: .Cancel) { action in
            alertCotroller.dismissViewControllerAnimated(true, completion: nil)
        }
        
        // Add the actions.
        alertCotroller.addAction(editAction)
        alertCotroller.addAction(playAction)
        alertCotroller.addAction(cancelAction)
        
        presentViewController(alertCotroller, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
