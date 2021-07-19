//
//  AppleFirebaseLoginManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 30.04.2021.
//

import UIKit
import CryptoKit
import FirebaseUI
import AuthenticationServices

class AppleFirebaseLoginManager: NSObject, LoginManagerProtocol {
    
    var delegate: AuthResultDelegate?
    var currentNonce: String?
    
    func logIn() -> () {
        let request = createAppleIdREquest()
        let logInVC = ASAuthorizationController(authorizationRequests: [request])
        
        logInVC.delegate = self
        
        logInVC.performRequests()
    }
    
    
    func logOut() {
        
    }
    
    
    func createAppleIdREquest() -> ASAuthorizationAppleIDRequest {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request       = appleProvider.createRequest()
        let nonce         = randomNonceString()
        
        
        request.requestedScopes = [.email, .fullName]
        request.nonce = sha256(nonce)
        
        currentNonce = nonce
        
        return request
    }
    
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result                    = ""
        var remainingLength           = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                
                var random: UInt8  = 0
                let errorCode      = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                
                return random
            }
            
            
            randoms.forEach { random in
                if remainingLength == 0 { return }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    private func sha256(_ input: String) -> String {
        let inputData  = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap { return String(format: "%02x", $0) }.joined()
        
        return hashString
    }
}

extension AppleFirebaseLoginManager: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            guard let nonce = currentNonce else {
                delegate?.getAuthResult(result: .failure(FirebaseError.unableToCreateNonceForAppleSignIn))
                return
            }
            
            guard let appleIdToken = appleIDCredential.identityToken else {
                delegate?.getAuthResult(result: .failure(FirebaseError.unableToGetAppleIdTokenToSignIn))
                return
            }
            
            guard let idTokenString = String(data: appleIdToken, encoding: .utf8) else {
                print("Unable to decode Apple token")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            
            
            Auth.auth().signIn(with: credential) { [weak self] result, error in
                guard error == nil else {
                    self?.delegate?.getAuthResult(result: .failure(error!))
                    return
                }
                
                
                self?.delegate?.getAuthResult(result: .success(true))
            }
        }
    }
    
}
