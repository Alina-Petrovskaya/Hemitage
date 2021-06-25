//
//  FireStoreUserManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 24.06.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

protocol FireStoreUserManagerProtocol {
    
    func isUserOnline() -> Bool
    func updateProfileInfo(with model: ProfileModel)
    func getUserData(completion: @escaping (ProfileModel) -> ())
    
}


class FireStoreUserManager: FireStoreUserManagerProtocol {
  
    private let db = Firestore.firestore()
    private let collectionName = FireStoreCollectionName.users.rawValue
   
    
    func isUserOnline() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    
    func updateProfileInfo(with model: ProfileModel) {
        
        if let id = model.id {
            do {
                try db.collection(collectionName).document(id).setData(from: model)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func getUserData(completion: @escaping (ProfileModel) -> ()) {
        guard let userID = Auth.auth().currentUser?.uid
        else {
            print("Can't get current user id")
            return
        }
        
        db.collection(collectionName)
            .document(userID)
            .addSnapshotListener(includeMetadataChanges: true) { [weak self] documentSnapshot, error in
                
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                guard let model = try? documentSnapshot?.data(as: ProfileModel.self)
                
                else {
                    let user  = Auth.auth().currentUser
                    let image = user?.photoURL
                    let name  = user?.displayName
                    let model = ProfileModel(id: userID, image: image, name: name ?? "", subscriptionID: "", subscriptionExpirationDate: Date())
                    
                    self?.updateProfileInfo(with: model)
                    completion(model)
                    
                    return
                }
                
                completion(model)
            }
        
    }
    
    
    
}
