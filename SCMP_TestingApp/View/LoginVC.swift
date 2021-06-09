//
//  ViewController.swift
//  SCMP_TestingApp
//
//  Created by 黃恩祐 on 2021/6/9.
//

import UIKit

class LoginVC: UIViewController {
    
    weak var textAccount: UITextField?
    weak var textPassword: UITextField?
    weak var btnSubmit: UIButton?
    weak var viewLoading: UIView?
    weak var activityIndicator: UIActivityIndicatorView?
    
    var viewModel: LoginVMInterface?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.initView()
        self.autoToHideKeyboard()
        self.subscriptVM()
    }

}

extension LoginVC {
    
    private func initView() {
        
        let textAccount = UITextField(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width - 100, height: 60)))
        textAccount.borderStyle = .roundedRect
        textAccount.autocorrectionType = .no
        textAccount.keyboardType = .emailAddress
        textAccount.clearButtonMode = .whileEditing
        textAccount.placeholder = "your email"
        textAccount.returnKeyType = .next
        textAccount.delegate = self
        self.textAccount = textAccount
        
        let textPassword = UITextField(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width - 100, height: 60)))
        textPassword.borderStyle = .roundedRect
        textPassword.autocorrectionType = .no
        textPassword.keyboardType = .default
        textPassword.clearButtonMode = .whileEditing
        textPassword.isSecureTextEntry = true
        textPassword.placeholder = "password"
        textPassword.returnKeyType = .next
        textPassword.delegate = self
        self.textPassword = textPassword

        
        let stackView = UIStackView(arrangedSubviews: [textAccount, textPassword])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 100)
        ])
        
        let btnSubmit = UIButton(type: .custom)
        let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        btnSubmit.frame = CGRect(x: 50,
                                 y: self.view.frame.maxY - bottomPadding - 90,
                                 width: self.view.frame.width - 100,
                                 height: 60)
        btnSubmit.layer.cornerRadius = 30
        btnSubmit.layer.masksToBounds = true
        btnSubmit.clipsToBounds = true
        btnSubmit.setTitle("Login", for: .normal)
        btnSubmit.backgroundColor = .black
        btnSubmit.setBackgroundImage(UIImage(color: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)), for: .normal)
        btnSubmit.addTarget(self, action: #selector(self.onClickSubmitButton(_:)), for: .touchUpInside)
        self.btnSubmit = btnSubmit
        self.view.addSubview(btnSubmit)
        
        
    }
    
    @objc private func onClickSubmitButton(_ button: UIButton) {
        self.showLoading()
//        self.viewModel?.login(account: "peter@klaven.com", password: "cityslicka123") { [weak self] token in
        self.viewModel?.login(account: self.textAccount?.text ?? "", password: self.textPassword?.text ?? "") { [weak self] token in
            self?.showLoading(false)
            let resultVC = ResultVC()
            self?.navigationController?.pushViewController(resultVC, animated: true)
        }
    }
    
    private func autoToHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func subscriptVM() {
        self.viewModel = LoginVM()
        
        self.viewModel?.apiFaildSubject.bind({ [weak self] _message in
            guard let message = _message else { return }
            DispatchQueue.main.async {
                self?.showLoading(false)
                let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    private func showLoading(_ show: Bool = true) {
        if !show {
            self.activityIndicator?.removeFromSuperview()
            self.activityIndicator = nil
            self.viewLoading?.removeFromSuperview()
            self.viewLoading = nil
        }else if self.viewLoading == nil{
            let loadingView = UIView(frame: self.view.frame)
            loadingView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            let activityIndicator = UIActivityIndicatorView()
            self.activityIndicator = activityIndicator
            self.activityIndicator?.style = .white
            self.activityIndicator?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            self.activityIndicator?.center = loadingView.center
            self.activityIndicator?.startAnimating()
            self.viewLoading = loadingView
            self.viewLoading?.addSubview(activityIndicator)
            self.view.addSubview(loadingView)
        }
    }
}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.textAccount:
            self.textPassword?.becomeFirstResponder()
        case self.textPassword:
            textField.resignFirstResponder()
        default:
            print("something error")
        }
        return true
    }
}
