//
//  RegisterView.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/26.
//

import UIKit

class RegisterView: UIView {

    // MARK: Public
    
    public var loginTapCb: BlockNoParams?
    public var enterHomeCb: BlockNoParams?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadView()
        loadLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadView() {
        addSubview(usernameIconImgView)
        addSubview(usernameTextField)
        addSubview(usernameLineView)
        
        addSubview(passwordIconImgView)
        addSubview(passwordTextField)
        addSubview(passwordLineView)
        
        addSubview(conirmPasswordIconImgView)
        addSubview(conirmPasswordTextField)
        addSubview(conirmPasswordLineView)
        
        addSubview(registerButton)
        addSubview(loginButton)
    }
    
    func loadLayout() {
        usernameIconImgView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(Scale(50))
            make.top.equalTo(self).offset(Scale(20))
            make.size.equalTo(CGSize(width: Scale(25), height: Scale(25)))
        }
        
        usernameTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self.usernameIconImgView.snp.right).offset(Scale(15))
            make.centerY.equalTo(self.usernameIconImgView)
            make.height.equalTo(Scale(30))
            make.right.equalTo(self).offset((Scale(-50)))
        }
        
        usernameLineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(Scale(40))
            make.right.equalTo(self).offset(Scale(-40))
            make.height.equalTo(1)
            make.top.equalTo(self.usernameTextField.snp.bottom).offset(Scale(5))
        }
        
        passwordIconImgView.snp.makeConstraints { (make) in
            make.left.size.equalTo(self.usernameIconImgView)
            make.top.equalTo(self.usernameLineView).offset(Scale(20))
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(self.usernameTextField)
            make.centerY.equalTo(self.passwordIconImgView)
        }
        
        passwordLineView.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(self.usernameLineView)
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(Scale(5))
        }
        
        
        conirmPasswordIconImgView.snp.makeConstraints { (make) in
            make.left.size.equalTo(self.usernameIconImgView)
            make.top.equalTo(self.passwordLineView).offset(Scale(20))
        }
        
        conirmPasswordTextField.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(self.usernameTextField)
            make.centerY.equalTo(self.conirmPasswordIconImgView)
        }
        
        conirmPasswordLineView.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(self.usernameLineView)
            make.top.equalTo(self.conirmPasswordTextField.snp.bottom).offset(Scale(5))
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.conirmPasswordLineView)
            make.top.equalTo(self.conirmPasswordLineView).offset(Scale(40))
            make.height.equalTo(Scale(44))
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: Scale(80), height: Scale(30)))
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(Scale(-20))
        }
    }
    
    // MARK: Action
    @objc func loginButtonClick() {
        guard let cb = self.loginTapCb else {
            return
        }
        cb()
    }
    
    @objc func registerButtonClick() {
        guard let username = usernameTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        guard let confirmPassword = conirmPasswordTextField.text else {
            return
        }
        
        if username.count == 0 {
            showToast("请输入用户名")
            return
        }
        if password.count == 0 {
            showToast("请输入密码")
            return
        }
        if confirmPassword.count == 0 {
            showToast("请再次输入密码")
            return
        }
        
        if username.count < 2 || username.count > 20 {
            showToast("用户名只能在2-20个字符之间")
            return
        }
        
        if password.count < 6 || confirmPassword.count < 6 {
            showToast("密码不能小于6个字符")
            return
        }
        
        if password != confirmPassword {
            showToast("两次密码输入不一致")
            return
        }
        
        // 开始注册
        guard let cb = self.enterHomeCb else {
            return
        }
        cb()
    }
    
    // 用户名小图标
    lazy var usernameIconImgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "username_pic")
        return view
    }()
    
    // 用户名输入框
    lazy var usernameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "请输入用户名"
        view.clearButtonMode = .always
        return view
    }()
    
    // 用户名下横线
    lazy var usernameLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    // 密码小图标
    lazy var passwordIconImgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "password_pic")
        return view
    }()

    // 密码输入框
    lazy var passwordTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "请输入密码"
        view.isSecureTextEntry = true
        view.clearButtonMode = .always
        return view
    }()
    
    // 密码下横线
    lazy var passwordLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    // 确认密码小图标
    lazy var conirmPasswordIconImgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "password_pic")
        return view
    }()

    // 确认密码输入框
    lazy var conirmPasswordTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "请再次输入密码"
        view.isSecureTextEntry = true
        view.clearButtonMode = .always
        return view
    }()
    
    // 确认密码下横线
    lazy var conirmPasswordLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    // 注册按钮
    lazy var registerButton: UIButton = {
        let button = UIButton.button("注册", .white, TextSystemFont(17), self, #selector(registerButtonClick))
        button.backgroundColor = MainColor
        button.layer.cornerRadius = Scale(22)
        button.clipsToBounds = true
        return button
    }()
    
    // 登陆按钮
    lazy var loginButton: UIButton = {
        let button = UIButton.button("登录 >", TextGrayColor, TextSystemFont(17), self, #selector(loginButtonClick))
        return button
    }()

}
