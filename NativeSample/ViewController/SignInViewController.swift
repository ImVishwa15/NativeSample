//
//  LoginViewController.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/27/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

private struct SignInContent {
    static let title: String = "Sign In"
    static let signInTitle: String = "Sign In"
    static var commentTitle: String = "Please enter a pair of login and password"
    static var emailTitle: String = "Email"
    static var loginPlaceholder: String = "example@icloud.com"
    static var passwordTitle: String = "Password"
    static var emailPlaceholer: String = "example@icloud.com"
    static var passwordPlaceholer: String = "required"
    static var signUpTitle: String = "Sign Up"
}

private enum SignInOptions:Int {
    
    case textFields, messageLabel, buttons
    
    static let allCases: [SignInOptions] = [.textFields,.messageLabel,.buttons]//allValues(SignInOptions.self)
    
    static var sections: Int {
        return SignInOptions.allCases.count
    }
    static func totalCount() -> Int {
        return SignInOptions.allCases.count
    }
    var rowCount: Int {
        switch self {
        case .textFields:
            return SignInFields.allCases.count
        case .messageLabel:
            return 1
        case .buttons:
            return SignInButtons.allCases.count
        }
    }
}

private enum SignInButtons: Int {
    
    case signIn = 1
    case signUp
    
    static let allCases: [SignInButtons] = [.signIn]//allValues(SignInButtons.self)
    
    static var count: Int {
        return SignInFields.allCases.count
    }
    
    var title: String? {
        switch self {
        case .signIn:
            return SignInContent.signInTitle
        case .signUp:
            return SignInContent.signUpTitle
        }
    }
}

private enum SignInFields: Int {
    case email = 100
    case password
    
    static let allCases: [SignInFields] = [.email,.password]//allValues(SignInFields.self)
    
    static var count: Int {
        return SignInFields.allCases.count
    }
    
    func field() -> (title: String?, placeholder: String?) {
        switch self {
        case .email:
            return  (SignInContent.emailTitle,SignInContent.emailPlaceholer)
        case .password:
            return (SignInContent.passwordTitle,SignInContent.passwordPlaceholer)
        }
    }
}

class SignInViewController: UITableViewController {
    
    //MARK:  Identifier
    static var identifier: String {
        return "SignInViewController"
    }
    
    // MARK:  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let cell = self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as? TextFieldCell  {
            cell.textField.becomeFirstResponder()
        }
    }
    
    // MARK:  Button Action
    @objc private func signIn(_ button: DownloadingButton) {
        
        var emailCell: TextFieldCell? = nil
        var passwordCell: TextFieldCell? = nil
        
        if let cell = self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as? TextFieldCell  {
            emailCell = cell
        }
        if let cell = self.tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as? TextFieldCell  {
            passwordCell = cell
        }
        
        if emailCell?.textField.isEmpty ?? false {
            emailCell?.highlighted()
            return
        }
        
        if passwordCell?.textField.isEmpty ?? false {
            passwordCell?.highlighted()
            return
        }
        button.setLoadingMode()
        emailCell?.textField.isEnabled = false
        passwordCell?.textField.isEnabled = false

        // Call API
    }
    
    // MARK:  Initialization
    private func initialization() {
        
        func setUpNavigationBar() {
            self.navigationController?.isNavigationBarHidden = false
            
            if #available(iOS 11.0, *) {
                self.navigationController?.navigationBar.prefersLargeTitles = true
                self.navigationItem.largeTitleDisplayMode = .always
            }
            self.navigationItem.title = SignInContent.title
        }
        
        func registerCell() {
            self.tableView.registerCell(ofType: TextFieldCell.self)
            self.tableView.registerCell(ofType: TextLabelCell.self)
            self.tableView.registerCell(ofType: ButtonCell.self)
        }
        
        func setUpTableView() {
            self.tableView.backgroundColor = CustomColor.customGray
            self.tableView.delaysContentTouches = false
            self.tableView.allowsSelection = false
            self.tableView.estimatedRowHeight = UITableView.automaticDimension
            self.tableView.rowHeight = UITableView.automaticDimension
            self.tableView.tableHeaderView = UIView()
            self.tableView.tableFooterView = UIView()
        }
        setUpNavigationBar()
        registerCell()
        setUpTableView()
    }
}

extension SignInViewController {
    
    // MARK:  Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SignInOptions.totalCount()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SignInOptions.allCases[section].rowCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var labelWidth: CGFloat = 0
        for text in [SignInContent.emailTitle, SignInContent.passwordTitle] {
            let font = UIFont.system(.regular, 17)
            let fontAttributes = [NSAttributedString.Key.font: font]
            let calculatedSize = NSString.init(string: text).size(withAttributes: fontAttributes)
            labelWidth.setIfFewer(when: calculatedSize.width + 1)
        }
        switch SignInOptions.allCases[indexPath.section] {
        case .textFields:
            let cell: TextFieldCell = tableView.dequeueReusableCell(for: indexPath)
            cell.label.text = SignInFields.allCases[indexPath.row].field().title
            cell.textField.placeholder = SignInFields.allCases[indexPath.row].field().placeholder
            cell.textField.delegate = self
            cell.textField.tag = SignInFields.allCases[indexPath.row].rawValue
            cell.fixWidthLabel = labelWidth
            if SignInFields.allCases[indexPath.row] == .password {
                cell.textField.isSecureTextEntry = true
                cell.separatorInset.left = 0
            }
            return cell
        case .buttons:
            let cell: ButtonCell = tableView.dequeueReusableCell(for: indexPath)
            cell.button.setTitle(SignInButtons.allCases[indexPath.row].title, for: .normal)
            cell.separatorInset.left = 0
            cell.button.tag = SignInButtons.allCases[indexPath.row].rawValue
            cell.button.addTarget(self, action: #selector(signIn(_:)), for: .touchUpInside)
            return cell
        default:
            let cell: TextLabelCell = tableView.dequeueReusableCell(for: indexPath)
            cell.label.text = SignInContent.commentTitle
            cell.separatorInset.left = 0
            return cell
        }
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return UIView()
//    }

}

extension SignInViewController: UITextFieldDelegate {
    
    // MARK:  Text field delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
