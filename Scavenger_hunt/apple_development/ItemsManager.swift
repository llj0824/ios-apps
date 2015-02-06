//
//  ItemsManager.swift
//  apple_development
//
//  Created by Leo Jiang on 9/24/14.
//  Copyright (c) 2014 Leo Jiang. All rights reserved.
//

import Foundation

class ItemsManager {
    var items = [ScavengerHuntItem]()
    
    //only runs code once, and never ran twice
    lazy private var archivePath: String = {
        let fileManager = NSFileManager.defaultManager()
        let documentDirectoryURLs = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as [NSURL]
        let archiveURL = documentDirectoryURLs.first!.URLByAppendingPathComponent("ScavengerHuntItems", isDirectory: false)
        return archiveURL.path!
    }()
    
    func save() {
        NSKeyedArchiver.archiveRootObject(items, toFile: archivePath)
    }
    
    private func unarchiveSavedItems(){
        if NSFileManager.defaultManager().fileExistsAtPath(archivePath){
            let savedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(archivePath) as [ScavengerHuntItem]
            items = savedItems

        }
    }
    init() {
        unarchiveSavedItems()
    }
}
