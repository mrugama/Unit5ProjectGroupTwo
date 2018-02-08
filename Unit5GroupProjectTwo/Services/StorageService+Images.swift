//
//  StorageService+Images.swift
//  Unit5GroupProjectTwo
//
//  Created by C4Q on 2/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

extension StorageService {
    public func storeImage(image: UIImage, postId: String?, userId: String?) {
        guard let data = UIImageJPEGRepresentation(image, 1.0) else { print("image is nil"); return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let uploadTask = StorageService.manager.getImagesRef().child(postId ?? userId!).putData(data, metadata: metadata) { (storageMetadata, error) in
            if let error = error {
                print("uploadTask error: \(error)")
            } else if let storageMetadata = storageMetadata {
                print("storageMetadata: \(storageMetadata)")
            }
        }
        
        // Listen for state changes, errors, and completion of the upload.
        uploadTask.observe(.resume) { snapshot in
            // Upload resumed, also fires when the upload starts
        }
        
        uploadTask.observe(.pause) { snapshot in
            // Upload paused
        }
        
        uploadTask.observe(.progress) { snapshot in
            // Upload reported progress
            let percentProgress = 100.0 * Double(snapshot.progress!.completedUnitCount)
                / Double(snapshot.progress!.totalUnitCount)
            print(percentProgress)
        }
        
        uploadTask.observe(.success) { snapshot in
            // Upload completed successfully
            
            // set job's imageURL
            let imageURL = String(describing: snapshot.metadata!.downloadURL()!)
            if let postId = postId, let _ = userId {
                UserService.manager.getUsersRef().child("\(postId)/imageURL").setValue(imageURL)
            } else if let postId = postId {
                PostService.manager.getPostsRef().child("\(postId)/imageURL").setValue(imageURL)
                
            }
            
            //DBService.manager.getJobs().child("\(jobId)/imageURL").setValue(imageURL)
            
            //DBService.manager.getJobs().child("\(jobId)").updateChildValues(["imageURL" :  imageURL])
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as NSError? {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    // File doesn't exist
                    break
                case .unauthorized:
                    // User doesn't have permission to access file
                    break
                case .cancelled:
                    // User canceled the upload
                    break
                    
                    /* ... */
                    
                case .unknown:
                    // Unknown error occurred, inspect the server response
                    break
                default:
                    // A separate error occurred. This is a good place to retry the upload.
                    break
                }
            }
        }
    }
}