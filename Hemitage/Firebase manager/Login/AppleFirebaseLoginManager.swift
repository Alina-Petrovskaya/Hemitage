//
//  AppleFirebaseLoginManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 30.04.2021.
//

import UIKit
import CryptoKit
import FirebaseUI

class AppleFirebaseLoginManager: NSObject, LoginManagerProtocol, FUIAuthDelegate {
    
    fileprivate var currentNonce: String?
    
    func logIn(completion: @escaping (Result<Bool, Error>) -> ()) {
      
    }
    
    private func authApple() {
        let authUI        = FUIAuth.defaultAuthUI()
        authUI?.providers = [FUIOAuth.appleAuthProvider(with: .light)]
        authUI?.delegate  = self
         
        guard let  authController = authUI?.authViewController() else {
            print("Can't get controller for apple sign in")
            return
        }
        
        
    }
    
    private func startSignInWithAppleFlow() {
//      let nonce           = randomNonceString()
//      currentNonce        = nonce
        
//      let appleIDProvider = ASAuthorizationAppleIDProvider()
//      let request         = appleIDProvider.createRequest()
//
//      request.requestedScopes = [.fullName, .email]
//      request.nonce           = sha256(nonce)
//
//      let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//      authorizationController.delegate = self
//      authorizationController.presentationContextProvider = self
//      authorizationController.performRequests()
    }
    
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }

    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}

