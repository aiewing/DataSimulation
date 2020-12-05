//
//  ViewController.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/11/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadSettings()
        loadUI()
        loadLayout()
    }

    func loadSettings() {
        view.backgroundColor = .white
    }
    
    func loadUI() {
        
        view.addSubview(bgScrollView)
        view.addSubview(logoImgView)
        
        bgScrollView.addSubview(bgImgView)
        
        bgScrollView.addSubview(registerButton)
        bgScrollView.addSubview(loginButton)
        bgScrollView.addSubview(loginScrollView)
        
        loginScrollView.addSubview(registerView)
        loginScrollView.addSubview(loginView)
    }
    
    func loadLayout() {
        
        bgScrollView.frame = view.bounds
        
        bgImgView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - TabbarSafeBottomMargin - Scale(150))
        
        
        logoImgView.frame = CGRect(x: 0, y: 0, width: Scale(150), height: Scale(150))
        logoImgView.centerX = ScreenWidth / 2
        logoImgView.top = NavBarHeight + Scale(80)
        
        registerButton.frame = CGRect(x: Scale(30), y: 0, width: Scale(135), height: Scale(44))
        registerButton.bottom = ScreenHeight - TabbarSafeBottomMargin - Scale(50)
        
        loginButton.frame = registerButton.frame
        loginButton.right = ScreenWidth - Scale(30)

        loginScrollView.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: ScreenHeight - logoImgView.bottom)
        
        
        registerView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: loginScrollView.height)
        loginView.frame = CGRect(x: ScreenWidth, y: 0, width: ScreenWidth, height: loginScrollView.height)
        
        
        bgScrollView.contentSize = CGSize(width: 0, height: ScreenHeight * 2 - logoImgView.bottom)
    }

    
    
    // MARK: Action
    // 登录按钮点击
    @objc func loginButtonClick() {
        loginScrollView.contentOffset = CGPoint(x: ScreenWidth, y: 0)
        startPushAnimation()
    }
    
    // 注册按钮点击
    @objc func registerButtonClick() {
        loginScrollView.contentOffset = CGPoint(x: 0, y: 0)
        startPushAnimation()
    }
    
    func loginViewLoginTap() {
        UIView.animate(withDuration: 0.25) {
            self.loginScrollView.contentOffset = CGPoint(x: ScreenWidth, y: 0)
        }
    }
    
    func loginViewRegisterTap() {
        UIView.animate(withDuration: 0.25) {
            self.loginScrollView.contentOffset = CGPoint(x: 0, y: 0)
        }
    }
    
    func login(_ userName: String, _ password: String) {
        let params = ["name": userName, "password": password]
        Network.request(.login(params)) { [weak self] (json) in
            let loginModel = LoginInfoModel(jsonData: json)
            // 登录成功 存储登录信息
            guard let session = loginModel.session else {
                return
            }
            UserDefaults.LoginInfo.set(value: session, forKey: .session)
            self?.pushToTabBarVC()
        } failure: { (msg) in
            showToast(msg)
        }

    }
    
    func pushToTabBarVC() {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        delegate.pushToTabBarVC()
    }
    
    // MARK Private
    
    func startPushAnimation() {
        self.loginButton.isHidden = true
        self.registerButton.isHidden = true
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.25, initialSpringVelocity: 10) {
            self.bgScrollView.contentOffset.y = ScreenHeight - self.logoImgView.bottom
        }

    }
    
    // 滑动视图
    lazy var bgScrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = false
        return view
    }()
    
    // 登录滑动视图
    lazy var loginScrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = false
        view.contentSize = CGSize(width: ScreenWidth * 2, height: 0)
        return view
    }()
    
    // 背景图片
    lazy var bgImgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "login_bg")
        return view
    }()
    
    // logo
    lazy var logoImgView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.image = UIImage(named: "data_simulation_logo")
        return view
    }()
    
    // 注册按钮
    lazy var registerButton: UIButton = {
        let button = UIButton.button("注册", TextGrayColor, TextSystemFont(17), self, #selector(self.registerButtonClick))
        button.layer.cornerRadius = Scale(22)
        button.layer.borderWidth = 1
        button.layer.borderColor = TextGrayColor.cgColor
        button.clipsToBounds = true
        return button
    }()
    
    // 登陆按钮
    lazy var loginButton: UIButton = {
        let button = UIButton.button("登录", .white, TextSystemFont(17), self, #selector(self.loginButtonClick))
        button.backgroundColor = MainColor
        button.layer.cornerRadius = Scale(22)
        button.clipsToBounds = true
        return button
    }()
    
    // 注销界面
    lazy var registerView: RegisterView = {
        let view = RegisterView()
        view.loginTapCb = { [weak self] in
            self?.loginViewLoginTap()
        }
        view.enterHomeCb = { [weak self] in
            self?.pushToTabBarVC()
        }
        return view
    }()
    
    // 登录界面
    lazy var loginView: LoginView = {
        let view = LoginView()
        view.registerTapCb = { [weak self] in
            self?.loginViewRegisterTap()
        }
        view.enterHomeCb = {[weak self](username, password) in
            self?.login(username, password)
        }

        return view
    }()
}

