//
//  ListViewController.swift
//  apple_development
//
//  Created by Leo Jiang on 9/24/14.
//  Copyright (c) 2014 Leo Jiang. All rights reserved.
//


import UIKit

class CollectionView: UICollectionViewController {
    
    var items = ["1", "2", "3"]
    
    var customLayout = Layout()
    
    override func viewDidLoad() {
        
        let collectionVC = UICollectionViewController() // [[SomeType alloc] initWithStuff:"myStuff"]
        
            let flowLayout = self.collectionViewLayout as Layout
            flowLayout.scrollDirection = .Vertical
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let object = items[indexPath.row]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath) as UICollectionViewCell
        
        // configure cell
        
        return cell
    }
}

class Layout: UICollectionViewFlowLayout {
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        let layoutAttributes = super.layoutAttributesForItemAtIndexPath(indexPath)
        
        let offset = self.collectionView!.contentOffset
        let yOffset = offset.y
        // customize layout attributes
        
        layoutAttributes.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        return layoutAttributes
    }
}

class ListViewController : UITableViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    //is this making an empty class?
   // var itemsList = [itemsManager]()
    var itemsManager = ItemsManager()
    
    //mandatory function-> returns number of rows in table view
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return itemsManager.items.count
    }
    
    
    //return new cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell") as UITableViewCell
        let item = itemsManager.items[indexPath.row]
        cell.textLabel!.text = item.name
        itemsManager.save()
        if (item.isComplete){
            cell.accessoryType = .Checkmark
            cell.imageView!.image = item.photo
        } else {
            cell.accessoryType = .None
            cell.imageView?.image = nil
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //protocol
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
           imagePicker.sourceType = .Camera
        }
        else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let indexPath = tableView.indexPathForSelectedRow()!
        let selectedItem = itemsManager.items[indexPath.row]
        let photo = info[UIImagePickerControllerOriginalImage] as UIImage
        selectedItem.photo = photo
        
        dismissViewControllerAnimated(true, completion:{
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        })
    }
    
    
    
    @IBAction func unwindToList(segue: UIStoryboardSegue){
        if segue.identifier == "DoneItem" {
            //allows you to communicate with previous view= viewController
            let addItemController = segue.sourceViewController as ViewController
            if let newItem = addItemController.createdItem {
                itemsManager.items += [newItem]
                itemsManager.save()
                let indexPath = NSIndexPath(forRow: itemsManager.items.count - 1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath],
                    withRowAnimation: .Automatic)
            }
        }
        
    }
}