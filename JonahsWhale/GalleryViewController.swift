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
    
    var label0: [UILabel] = []
    var label1: [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "galleryCollectionCell", bundle: nil)
        galleryCollectionView.registerNib(nib, forCellWithReuseIdentifier: "cell")
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
        for index in 0..<10 {
            let label = UILabel()
            label.text = "Test 0"+String(index)
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
        galleryCollectionView.contentInset = UIEdgeInsetsMake(topLayoutGuide.length, 0, 0, 0)
    }
    
    /*
     * method delegation
     */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenWidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
        let threePiecesWidth = floor(screenWidth / 3.0 - ((2.0 / 3) * 2))
        let twoPiecesWidth = floor(screenWidth / 2.0 - (2.0 / 2))
        if indexPath.section == 0 {
            return CGSizeMake(threePiecesWidth, threePiecesWidth)
        }else {
            return CGSizeMake(twoPiecesWidth, twoPiecesWidth)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2.0
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 2.0, 0)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 10
        }else {
            return 10
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("galleryCollectionCell", forIndexPath: indexPath) as! GalleryViewCell
        
        if indexPath.section == 0 {
            cell.label = label0[indexPath.item]
        }else {
            cell.label = label1[indexPath.item]
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, allowMoveAtIndexPath indexPath: NSIndexPath) -> Bool {
        if collectionView.numberOfItemsInSection(indexPath.section) <= 1 {
            return false
        }
        return true
    }
    
    func collectionView(collectionView: UICollectionView, atIndexPath: NSIndexPath, didMoveToIndexPath toIndexPath: NSIndexPath) {
        var label: UILabel
        if atIndexPath.section == 0 {
            label = label0.removeAtIndex(atIndexPath.item)
        }else {
            label = label1.removeAtIndex(atIndexPath.item)
        }
        
        if toIndexPath.section == 0 {
            label0.insert(label, atIndex: toIndexPath.item)
        }else {
            label1.insert(label, atIndex: toIndexPath.item)
        }
    }
    
    func scrollTrigerEdgeInsetsInCollectionView(collectionView: UICollectionView) -> UIEdgeInsets {
        return UIEdgeInsetsMake(100.0, 100.0, 100.0, 100.0)
    }
    
    func collectionView(collectionView: UICollectionView, reorderingItemAlphaInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else {
            return 0.3
        }
    }
    
    func scrollTrigerPaddingInCollectionView(collectionView: UICollectionView) -> UIEdgeInsets {
        return UIEdgeInsetsMake(collectionView.contentInset.top, 0, collectionView.contentInset.bottom, 0)
    }
    
}