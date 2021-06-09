//
//  ResultVC.swift
//  SCMP_TestingApp
//
//  Created by 黃恩祐 on 2021/6/9.
//

import UIKit

class ResultVC: UIViewController {
    
    weak var lbToken: UILabel?
    
    var viewModel: ResultVMInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Result"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.initView()
    }
    
    deinit {
        print("ResultVC deinit")
    }
}

extension ResultVC {
    
    func initView() {
        let label = UILabel(frame: CGRect(x: 10, y: 150, width: self.view.frame.width - 20, height: 30))
        label.textAlignment = .center
        label.text = "123123"
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        self.view.addSubview(label)
        self.lbToken = label
        
        self.subscriptVM()
    }
    
    private func subscriptVM() {
        self.viewModel = ResultVM()
        
        self.viewModel?.getLoginToken(completion: { [weak self] token in
            self?.lbToken?.text = token
        })
    }
}
