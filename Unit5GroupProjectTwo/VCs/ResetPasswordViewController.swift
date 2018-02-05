//
//  ResetPasswordViewController.swift
//  Unit5GroupProjectTwo
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

/*User clicks button -> Segues to this view controller -> User enters email and clicks button -> A pop up displays saying email was sent to them -> User clicks okay and is sent back to login view controller */

class ResetPasswordViewController: UIViewController {

    let resetView = ResetPasswordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(resetView)
        setUpResetView()
        resetView.submitButton.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
       
    }

    private func setUpResetView() {
        resetView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
    }
    
    @objc private func resetPassword() {
        let email = getEmail()
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error == nil && email != "" {
                
                //Present Alert
                let ac = UIAlertController(title: "Email Sent", message: "An email with reset instructions has been sent.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: {_ in self.dimissSelf() })
                ac.addAction(okAction)
                print("Password reset email sent")
                self.present(ac, animated: true)
            }
            else {
                 if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    var message = ""
                    switch errorCode{
                    case .missingEmail:
                        message = "Please enter an email."
                    case .invalidEmail:
                        message = "Please enter a valid email."
                    case .userNotFound:
                        message = "There is no record of an account with this email. Please check that your email is correct."
                    default:
                        break
                    }
                    let ac = UIAlertController(title: "Problem Resetting Password", message: message, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    ac.addAction(okAction)
                    self.present(ac, animated: true, completion: nil)
                }
                print("Error in trying to reset passsword: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    func dimissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func getEmail() -> (String) {
        let email = resetView.emailTextField.text!
        return email
    }

}