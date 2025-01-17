//
//  ViewController.swift
//  Amogh
//
//  Created by Amogh on 13/06/2020.
//  Copyright © 2020 Amogh. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: BaseViewController ,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {

       @IBOutlet weak var folderCollectionView:UICollectionView!
        var foldersArr:[Folder]?

        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
                 fetchFolders { (true) in
                   //Do Nothing
                   //TODO :- Need to pass nil to a completion handler withut an error
               }
            
            
            
            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
            longPressGesture.delegate = self
            self.folderCollectionView.addGestureRecognizer(longPressGesture)
        
        }
        
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }
        
        
        //CollectionView methods
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return foldersArr?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FolderCell
            let folder = foldersArr![indexPath.row]
            cell.tag = indexPath.row
            cell.folderTitle.text = folder.folderName
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let screenRect = UIScreen.main.bounds
            let screenWidth = screenRect.size.width
            let cellWidth = floor(screenWidth / 3.0) -  20
            let size = CGSize(width: cellWidth, height: cellWidth)
            return size;
        }
        

        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            performSegue(withIdentifier: "ShowFolderDetail", sender: foldersArr![indexPath.row])
        }
        

        
        //user defined actions.
        
       @IBAction func addFolder(){
        
            let alert = UIAlertController(title: "Create Folder", message: "Enter folder name", preferredStyle: .alert)

            alert.addTextField { (textField) in
                textField.placeholder = "Eg: Latest Videos"
            }

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let folderTitle = alert?.textFields![0].text
                if folderTitle != ""{
                    self.createFolder(folderName: folderTitle!)
                }
            }))
        
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            self.present(alert, animated: true, completion: nil)
        
            
        }
        
        
        func createFolder(folderName:String){
            
            let folder = Folder(context:dataContext!)
            folder.folderName = folderName
            
                do{
                       try dataContext!.save()
                   }catch{
                       print("Error: \(error)\nCould not save Core Data context.")
                   }
            
            fetchFolders { (true) in
                //Do Nothing
                //TODO :- Need to pass nil to a completion handler withut an error
            }
            
        }
        
        func alertToEditFolderName(cell:FolderCell){
            
             let alert = UIAlertController(title: "New Title", message: "Enter folder name", preferredStyle: .alert)

             alert.addTextField { (textField) in
                textField.text = cell.folderTitle.text
             }

             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                 let folderTitle = alert?.textFields![0].text
                    if folderTitle != ""{
                        cell.folderTitle.text = folderTitle
                        let folder = self.foldersArr![cell.tag]
                        folder.folderName = folderTitle
                        do{
                            try  dataContext!.save()
                        }catch{
                            print("Error: \(error)\nCould not save Core Data context.")
                        }
                        
                        self.folderCollectionView.reloadData()
                        
                    }
             }))
         
             alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

             self.present(alert, animated: true, completion: nil)

            
        }
        
        

        @objc func handleLongPress(gestureRecognizer:UILongPressGestureRecognizer){

            
            guard gestureRecognizer.state == .ended else{
                return
            }
            
            let pointInScreen = gestureRecognizer.location(in: self.folderCollectionView)
            let indexPath = self.folderCollectionView.indexPathForItem(at: pointInScreen)
            if indexPath != nil{
                let cell = self.collectionView(folderCollectionView, cellForItemAt: indexPath!) as! FolderCell
                showMoreOptionsForCell(cell: cell)
            }
        }
    
        
        func showMoreOptionsForCell(cell:FolderCell){
            
            let alert = UIAlertController(title: "Choose Action", message: nil , preferredStyle: .actionSheet)

            alert.addAction(UIAlertAction(title: "Delete Folder", style: .default, handler: { _ in
                
                dataContext?.delete(self.foldersArr![cell.tag])
                do{
                       try dataContext!.save()
                   }catch{
                       print("Error: \(error)\nCould not save Core Data context.")
                   }
                self.foldersArr?.remove(at: cell.tag)
                self.folderCollectionView.reloadData()
                
            }))
            
            alert.addAction(UIAlertAction(title: "Edit Folder Name", style: .default, handler: { _ in
                
                self.alertToEditFolderName(cell: cell)
                    
            }))
            
            
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            if let presenter = alert.popoverPresentationController {
                presenter.sourceView = self.view
                presenter.sourceRect = cell.frame
               }
            

                self.present(alert, animated: true, completion: nil)
            
        }


        
        //CoreData
            
        func fetchFolders(completionHandler:(_ success:Bool) -> Void) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<Folder>(entityName: "Folder")
            do {
                
                let fetchedResults = try context.fetch(fetchRequest)
                self.foldersArr = fetchedResults
                self.folderCollectionView.reloadData()
                completionHandler(true)
                
            }catch let error as NSError {
                print(error.description)
                completionHandler(false)
            }
        }

        
        //Navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destinationViewController = segue.destination as! FolderDetailViewController
            let folder = sender as! Folder
            destinationViewController.folder = folder
        }
        
        
       
        
      
        


}

