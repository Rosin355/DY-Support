//
//  DatabaseService.swift
//  Telar
//
//  Created by Romesh Singhabahu on 10/08/22.
//

import Foundation
import Contacts
import Firebase
import FirebaseStorage 
import UIKit

class DatabaseService {
    
    func getPlatformUsers(localContacts: [CNContact], completion: @escaping ([User]) -> Void) {
        
        // The array where we're storing fetched platform users
        var platformUsers = [User]()
        
        // Construct an array of string phone numbers to look up
        var lookupPhoneNumbers = localContacts.map { contact in
            
            // Turn the contact into a phone number as a string
            return TextHelper.sanitizePhoneNumber(contact.phoneNumbers.first?.value.stringValue ?? "")
        }
        
        // Make sure that there are lookup numbers
        guard lookupPhoneNumbers.count > 0 else {
            
            // Callback
            completion(platformUsers)
            return
        }
        
        // Query the database for these phone numbers
        let db = Firestore.firestore()
        
        // Perform queries while we still have phone numbers to look up
        while !lookupPhoneNumbers.isEmpty {
            
            // Get the first < 10 phone numbers to look up
            let tenPhoneNumbers = Array(lookupPhoneNumbers.prefix(10))
            
            // Remove the < 10 that we're looking up
            lookupPhoneNumbers = Array(lookupPhoneNumbers.dropFirst(10))
            
            let query2 = db.collection("users")
            query2.getDocuments { snapshot, error in
                
                if error == nil && snapshot != nil {
                    
                    // Create a for loop to iterate through all the documents in the 'users' collection
                    for doc in snapshot!.documents {
                        
                        // Create a reference to the users
                        let userRef = db.collection("users").document(doc.documentID)
                        userRef.getDocument { document, error in
                            
                            // Check if the document exists
                            if let document = document, document.exists {
                                let data = document.data()
                                
                                // Create a for loop to iterate through the users
                                for (key, value) in data! {
                                    if key == "phone" {
                                        
                                        if tenPhoneNumbers.contains(value as! String) {
                                            if let user = try? document.data(as: User.self) {
                                                
                                                // Append to the platform users array
                                                platformUsers.append(user)
                                            }
                                        }
                                    }
                                }
                            } else {
                                print("Document does not exist")
                            }
                            
                            // Check if we have anymore phone numbers to look up
                            // If not, we can call the completion block and we're done
                            if lookupPhoneNumbers.isEmpty {
                                
                                // Return these users
                                completion(platformUsers)
                            }
                        }
                    }
                }
            }
            
            
            /*
            // Look up the first 10
            let query = db.collection("users").whereField("phone", in: tenPhoneNumbers)
        
            // Retrieve the users that are on the platform
            query.getDocuments { snapshot, error in

                // Check for errors
                if error == nil && snapshot != nil {

                    // For each doc that was fetched, create a user
                    for doc in snapshot!.documents {

                        if let user = try? doc.data(as: User.self) {

                            // Append to the platform users array
                            platformUsers.append(user)
                        }
                    }

                    // Check if we have anymore phone numbers to look up
                    // If not, we can call the completion block and we're done
                    if lookupPhoneNumbers.isEmpty {
                        // Return these users
                        completion(platformUsers)
                    }
                }
            } */
        }
    }
    
    func setUserProfile(firstName: String, lastName: String, image: UIImage?, completion: @escaping (Bool) -> Void) {
        
        // Ensure that the user is logged in
        guard AuthViewModel.isUserLoggedIn() != false else {
            // User is not logged in
            return
        }
        
        // Get user's phone number
        let userPhone = TextHelper.sanitizePhoneNumber(AuthViewModel.getLoggedUserPhone())
        
        // Get a reference to Firestore
        let db = Firestore.firestore()
        
        // Set the profile data
        let doc = db.collection("users").document(AuthViewModel.getLoggedInUserId())
        doc.setData(["firstname": firstName,
                     "lastname": lastName,
                     "phone": userPhone])
        
        // Check if an image is passed through
        if let image = image {
        
            // Create storage reference
            let storageRef = Storage.storage().reference()
            
            // Turn our image into data
            let imageData = image.jpegData(compressionQuality: 0.8)
            
            // Check that we were able to convert it to data
            guard imageData != nil else {
                return
            }
            
            // Specify the file path and name
            let path = "images/\(UUID().uuidString).jpg"
            let fileRef = storageRef.child(path)
            
            let uploadTask = fileRef.putData(imageData!, metadata: nil) { meta, error in
                
                if error == nil && meta != nil
                {
                    // Get full url to image
                    fileRef.downloadURL { url, error in
                        
                        // Check for errors
                        if url != nil && error == nil {
                            
                            // Set that image path to the profile
                            doc.setData(["photo": url!.absoluteString], merge: true) { error in
                                
                                if error == nil {
                                    // Success, notify caller
                                    completion(true)
                                }
                            }
                            
                        }
                        else {
                            // Wasn't successful in getting download url for photo
                            completion(false)
                        }
                    }
                    
                    
                }
                else {
                    
                    // Upload wasn't successful, notify caller
                    completion(false)
                }
            }
            
            
        }
        else {
            // No image was set
            completion(true)
        }
        
    }
    
    func checkUserProfile(completion: @escaping (Bool) -> Void) {
        
        // Check that the user is logged
        guard AuthViewModel.isUserLoggedIn() != false else {
            return
        }
        
        // Create firebase ref
        let db = Firestore.firestore()
        
        db.collection("users").document(AuthViewModel.getLoggedInUserId()).getDocument { snapshot, error in
            
            // TODO: Keep the users profile data
            if snapshot != nil && error == nil {
                
                // Notify that profile exists
                completion(snapshot!.exists)
            }
            else {
                // TODO: Look into using Result type to indicate failure vs profile exists
                completion(false)
            }
            
        }
        
    }
}
