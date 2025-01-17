//
//  FolderDetail.swift
//  Amogh
//
//  Created by Amogh on 13/06/2020.
//  Copyright © 2020 Amogh. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
import AVKit
import MediaPlayer
import MediaWatermark

class FolderDetailViewController: BaseViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
        
    var folder:Folder?
       var videosArr  = [AVAsset]()
       var thumbnailsArr  = [UIImage]()
       var identifiersArr = [String]()
     @IBOutlet weak var assetsCollectionView:UICollectionView!
    
    
     override func viewDidLoad() {
            super.viewDidLoad()
            
            self.title = folder?.folderName ?? ""
            
            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
            longPressGesture.delegate = self
            self.assetsCollectionView.addGestureRecognizer(longPressGesture)

            videosArr.removeAll()
            thumbnailsArr.removeAll()
                    
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            if self.isBeingPresented || self.isMovingToParent {
                if folder?.videos?.count ?? 0 > 0{
                         setUpCollectionView(assets: folder!.videos!)
                     }
            }
         
        }
        
        
        
        func setUpCollectionView(assets:[String]){
         //   let dispatchGroup = DispatchGroup()
            self.videosArr.removeAll()
            self.thumbnailsArr.removeAll()
            self.showProgressHUD(title: "Loading Videos")
            var totalCount = 0;
            let fetchedResults = PHAsset.fetchAssets(withLocalIdentifiers: assets, options: nil)
            fetchedResults.enumerateObjects { (asset:PHAsset , count:Int, stop:UnsafeMutablePointer<ObjCBool>) in
                let assetConverter = PHAssetConverter()
                assetConverter.getAVAsset(asset) { (videoAsset, thumbnail) in
                        self.videosArr.append(videoAsset)
                        self.thumbnailsArr.append(thumbnail)
                        totalCount = totalCount + 1;
                        
                    if totalCount == fetchedResults.count{
                        DispatchQueue.main.async {
                            self.reloadCollectionView()
                        }
                        
                    }
                    
                    
                    }
            }
            
        }
        
        func reloadCollectionView(){
            hideProgressHUD()
            assetsCollectionView.reloadData()
        }
        
        
        
        @IBAction func addVideos(){
            let imagePicker = ImagePickerController()
            imagePicker.settings.selection.max = 10
            imagePicker.settings.theme.selectionStyle = .numbered
            imagePicker.settings.fetch.assets.supportedMediaTypes = [.video]
            
            presentImagePicker(imagePicker, select: { (asset) in
            }, deselect: { (asset) in
            }, cancel: { (assets) in
            }, finish: { (assets) in
                self.addToCoreData(assets: assets)
            })
            
        }
        
        
        @IBAction func playSlideShow(){
            
         //   self.showAlertForLoop(videoAssets: videosArr , image: nil, title: kTitle, message: kMultipleVideosMessage)
            
            playAllVideos(loopVideos: false, assets: videosArr)
            
        }
        
        
        
        
        //Collection view methods
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return videosArr.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AssetCell
            let thumbnail = thumbnailsArr[indexPath.row]
            cell.tag = indexPath.row
            cell.assetImageView.image = thumbnail
            return cell
            
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let cellWidth = floor(screenWidth / 2.0) - 1
        let size = CGSize(width: cellWidth, height: cellWidth)
        return size
            
    }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 1
        }

        func collectionView(_ collectionView: UICollectionView, layout
                    collectionViewLayout: UICollectionViewLayout,
                                    minimumLineSpacingForSectionAt section: Int) -> CGFloat {

         return 1
        }
    


        
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let asset = videosArr[indexPath.row]
            showAlertForLoop(videoAssets: [asset], image: nil, title: kTitle, message: kSingleVideoMessage)
        }
        
        
        //User declared
        
        func addToCoreData(assets:[PHAsset]){
            
            var newArr = [String]()
            
            if self.folder?.videos != nil {
                newArr = self.folder!.videos!
                for asset in assets {
                    if !self.folder!.videos!.contains(asset.localIdentifier){
                        newArr.append(asset.localIdentifier)
                    }
                }
            }else{
                for asset in assets {
                        newArr.append(asset.localIdentifier)
                }
            }
           
           
            
            
            self.folder?.videos = newArr
            
            
            if dataContext!.hasChanges{
                do{
                    try dataContext!.save()
                }catch{
                    print("Error: \(error)\nCould not save Core Data context.")
                }
            }
            
          //  self.assetsCollectionView.reloadData()
            self.setUpCollectionView(assets: newArr)
            
        }
        
        @objc func handleLongPress(gestureRecognizer:UILongPressGestureRecognizer){

              
              guard gestureRecognizer.state == .ended else{
                  return
              }
              
              let pointInScreen = gestureRecognizer.location(in: self.assetsCollectionView)
              let indexPath = self.assetsCollectionView.indexPathForItem(at: pointInScreen)
              if indexPath != nil{
                  let cell = self.collectionView(assetsCollectionView, cellForItemAt: indexPath!) as! AssetCell
                  showMoreOptionsForCell(cell: cell)
              }
              
          }
          
          @IBAction func showMoreOptionsForCell(cell:AssetCell){
              
              let alert = UIAlertController(title: "Choose Action", message: nil , preferredStyle: .actionSheet)

              alert.addAction(UIAlertAction(title: "Delete Video", style: .default, handler: { _ in
                self.folder!.videos?.remove(at: cell.tag)
                if dataContext!.hasChanges{
                  do{
                         try dataContext!.save()
                     }catch{
                         print("Error: \(error)\nCould not save Core Data context.")
                     }
                }
                            
                self.videosArr.remove(at: cell.tag)
                self.thumbnailsArr.remove(at: cell.tag)

                  self.assetsCollectionView.reloadData()
                  
              }))
            
            
    //        alert.addAction(UIAlertAction(title: "Play video with overlay", style: .default, handler: { _ in
    //
    //            self.showOverlay(forall: false, cell: cell)
    //
    //        }))
    //
    //
    //        alert.addAction(UIAlertAction(title: "Play all with overlay", style: .default, handler: { _ in
    //            self.showOverlay(forall: true, cell: cell)
    //           }))
    //
              
              
                  alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
              
              if let presenter = alert.popoverPresentationController {
                  presenter.sourceView = self.view
                  presenter.sourceRect = cell.frame
                 }
              

                  self.present(alert, animated: true, completion: nil)
              
          }
        
        //MARK: - image picker related
        
//        func showOverlay(forall:Bool, cell:AssetCell){
//
//                imageManager.pickImage(self){ image in
//
//                    if forall == true{
//
//                      //  self.showAlertForLoop(videoAssets: self.videosArr, image: image, title: kTitle, message: kMultipleVideosMessage)
//                        self.playVideo(with: self.videosArr, loop: true, withOverlay: image)
//
//                    }else{
//
//                        let asset = self.videosArr[cell.tag]
//                     //   self.showAlertForLoop(videoAssets: [asset], image: image, title: kTitle, message: kSingleVideoMessage)
//                        self.playVideo(with: [asset], loop: true, withOverlay: image)
//                    }
//
//
//               }
//
//        }
        
        
        

        
        
        //MARK: - Player related
        
        func showAlertForLoop(videoAssets:[AVAsset] , image:UIImage? , title:String, message:String){
            
           
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                   
                   let loopAction = UIAlertAction(title: "YES", style: .default) { (action) in
                    self.playVideo(with: videoAssets, loop: true, withOverlay: image)
                   }
                   alertController.addAction(loopAction)
                   
                   let noLoopAction = UIAlertAction(title: "NO", style: .default) { (action) in
                    self.playVideo(with: videoAssets, loop: false, withOverlay: image)
                   }
                   alertController.addAction(noLoopAction)
                   
                   let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                         }
                         alertController.addAction(cancelAction)

                   self.present(alertController, animated: true, completion: nil)
            
        }
        
        
        
        func playVideo(with videoAssets:[AVAsset], loop:Bool,withOverlay  overlayImage:UIImage?){
            
            if videoAssets.count == 0{
                     return
            }
            
            if videoAssets.count == 1{
                let playableAsset = videoAssets.first!
                playOneVideo(loopVideo: loop, asset:playableAsset)
                
            }else {
                
                playAllVideos(loopVideos: loop, assets: videoAssets)
            
        }
    }
        
                
        

        func playOneVideo(loopVideo : Bool , asset:AVAsset){

            let looper = SingleVideoLooper(asset: asset)
            looper.start(in: self, andloop: loopVideo)
            
       }
        
        func playAllVideos(loopVideos : Bool , assets:[AVAsset]){
            
            let looper = MultipleVideoLooper(assetItems: assets)
            looper.start(in: self, and: false)
         }
        

        



}
