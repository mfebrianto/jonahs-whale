//
//  GalleryViewController.swift
//  JonahsWhale
//
//  Created by michael febrianto on 12/09/2016.
//  Copyright © 2016 mfebrianto. All rights reserved.
//

import Foundation
import UIKit
import RAReorderableLayout

//RAReorderableLayoutDelegate, RAReorderableLayoutDataSource

class GalleryViewController: UIViewController, RAReorderableLayoutDelegate, RAReorderableLayoutDataSource {
    
    @IBOutlet var galleryCollectionView: UICollectionView!
    
    var label0: [String] = []
    var label1: [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "galleryCollectionCell", bundle: nil)
        galleryCollectionView.registerNib(nib, forCellWithReuseIdentifier: "cell")
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
        for index in 0..<10 {
            let label = "Test 0"+String(index)
            label0.append(label)
        }
        for index in 10..<20 {
            let label = UILabel()
            label.text = "Test 1"+String(index)
            label1.append(label)
        }
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        /*
         * add margin on the top of the subview
         */
        galleryCollectionView.contentInset = UIEdgeInsetsMake(topLayoutGuide.length, 0, 0, 0)
    }
    
    /*
     * method delegation
     */
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let screenWidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
//        let threePiecesWidth = floor(screenWidth / 3.0 - ((2.0 / 3) * 2))
//        let twoPiecesWidth = floor(screenWidth / 2.0 - (2.0 / 2))
////        if indexPath.section == 0 {
//            return CGSizeMake(threePiecesWidth, threePiecesWidth)
////        }else {
////            return CGSizeMake(twoPiecesWidth, twoPiecesWidth)
////        }
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
//        return 2.0
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
//        return 2.0
//    }
    
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 2
//    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0 {
//            
//            print(">>>>section>>0>>>"+String(label0.count))
//            
//            return label0.count
//        }else {
//            
//            print(">>>>section>>1>>>"+String(label1.count))
//            
//            return label1.count
//        }
        return self.label0.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("galleryCollectionCell", forIndexPath: indexPath) as! GalleryViewCell
        
//        if indexPath.section == 0 {
//            
//            print(">>>>>>>>>index>>0>>"+String(indexPath.item))
//            
//            cell.label = label0[indexPath.item]
//        }else {
//            
//            print(">>>>>>>>>index>>1>>"+String(indexPath.item))
//            
//            cell.label = label1[indexPath.item]
//        }
        
        print(">>>>>>>>>"+label0[indexPath.item])
        
        cell.dummyLabel.text = label0[indexPath.item]
        
        return cell
    }
}