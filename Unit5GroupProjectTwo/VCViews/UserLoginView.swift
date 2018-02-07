//
//  UserLoginView.swift
//  Unit5GroupProjectTwo
//
//  Created by C4Q on 1/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit


class UserLoginView: UIView {
    
    //    lazy var appNameLabel: UILabel = {
    //        let lab = UILabel()
    //        return lab
    //    }()
    
    
    lazy var emailTextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Email"
//        txt.backgroundColor = .red
        txt.autocapitalizationType = .none
        txt.borderStyle = .none
        return txt
    }()
    
    lazy var passWordField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Password"
//        txt.backgroundColor = .red
        txt.borderStyle = .none
        txt.isSecureTextEntry = true
        txt.autocapitalizationType = .none
        return txt
    }()
    
    lazy var submitInfoButton: UIButton = {
        let butt = UIButton()
        butt.backgroundColor = .orange
        butt.setTitle("Login", for: .normal)
        return butt
    }()
    
    lazy var forgotPWButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("Forgot Password", for: .normal)
        butt.backgroundColor = .orange
        return butt
    }()
    
    
    //    lazy var offerRegisterLabel: UILabel = {
    //        let lab = UILabel()
    //        return lab
    //    }()
    //
    //    lazy var registerButton: UIButton = {
    //        let butt = UIButton()
    //        return butt
    //    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
      backgroundColor = .white
        setupViews()
        setUpUserNameTF()
        setUpPWTF()
        setUpSubmitButt()
        setUpForgotPWB()

    }
    
    private func setupViews() {
        let views = [emailTextField, passWordField, submitInfoButton, forgotPWButton] as [UIView]
        views.forEach { addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
    
    }
    
    private func setUpUserNameTF () {
        emailTextField.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self).multipliedBy(0.9)
            make.height.equalTo(self).multipliedBy(0.1)
            make.top.equalTo(self).offset(50)
            make.centerX.equalTo(self)
        }
    }
    
    private func setUpPWTF () {
        passWordField.snp.makeConstraints { (make) -> Void in 
            make.width.equalTo(self).multipliedBy(0.9)
            make.height.equalTo(self).multipliedBy(0.1)
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self)
        }
    }
    
    private func setUpSubmitButt () {
        submitInfoButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self).multipliedBy(0.3)
            make.height.equalTo(self).multipliedBy(0.1)
            make.top.equalTo(passWordField.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            
            submitInfoButton.layer.cornerRadius = 10
            submitInfoButton.layer.masksToBounds = true
        }
        
    }
    
    private func setUpForgotPWB() {
        forgotPWButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self).multipliedBy(0.45)
            make.height.equalTo(self).multipliedBy(0.1)
            make.top.equalTo(submitInfoButton.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            
            forgotPWButton.layer.cornerRadius = 10
        forgotPWButton.layer.masksToBounds = true
        }
    }
    
    func underlined(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

//extension UITextView {
//    func underlined(){
//        let border = CALayer()
//        let width = CGFloat(1.0)
//        border.borderColor = UIColor.lightGray.cgColor
//        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
//        border.borderWidth = width
//        self.layer.addSublayer(border)
//        self.layer.masksToBounds = true
//    }
//}

