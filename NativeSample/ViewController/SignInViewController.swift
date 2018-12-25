//
//  LoginViewController.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/27/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

private enum SignIn: Int, CaseIterable {
    case fields
    case buttons
    
    static var sections: Int {
        return SignIn.allCases.count
    }
    
    var rows: Int {
        switch self {
        case .fields:
            return Fields.allCases.count
        case .buttons:
            return Buttons.allCases.count
        }
    }
    
    // enum for fields
    enum Fields: Int, CaseIterable {
        case email = 100
        case password
        case message
        
        func details() -> (title: String?, placeholder: String?) {
            switch self {
            case .email:
                return  (emailTitle, emailPlaceholer)
            case .password:
                return (passwordTitle, passwordPlaceholer)
            case .message:
                return (signInComment, nil)
            }
        }
    }
    
    // enum for buttons
    enum Buttons: Int, CaseIterable {
        case signIn = 1
        case forgotPassword
        case signUp
        
        var title: String? {
            switch self {
            case .signIn:
                return signInTitle
            case .signUp:
                return signUpTitle
            case .forgotPassword:
                return forgetPasswordTitle
            }
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
        
        if let cell = self.tableView.cellForRow(at: IndexPath.init(row: SignIn.Fields.email.rawValue - textFieldTag, section: SignIn.fields.rawValue)) as? TextFieldCell  {
            cell.textField.becomeFirstResponder()
        }
    }
    
    // MARK:  Button Action
    @objc private func buttonAction(_ button: DownloadingButton) {
        if let buttonType = SignIn.Buttons(rawValue: button.tag) {
            switch buttonType {
            case .signIn:
                signInButtonAction(button)
            case .forgotPassword:
                self.navigationController?.pushViewController(forgetPasswordVC(), animated: true)
            case .signUp:
                self.navigationController?.pushViewController(signUpVC(), animated: true)
            }
        }
    }
    
    private func signInButtonAction(_ button: DownloadingButton) {
        var emailCell: TextFieldCell? = nil
        var passwordCell: TextFieldCell? = nil
        
        if let cell = self.tableView.cellForRow(at: IndexPath.init(row: SignIn.Fields.email.rawValue - textFieldTag, section: SignIn.fields.rawValue)) as? TextFieldCell  {
            emailCell = cell
        }
        if let cell = self.tableView.cellForRow(at: IndexPath.init(row: SignIn.Fields.password.rawValue - textFieldTag, section: SignIn.fields.rawValue)) as? TextFieldCell  {
            passwordCell = cell
        }
        guard let emailField =  emailCell?.textField, isValidRequest(.email, emailField) else {
            emailCell?.highlighted()
            emailCell?.textField.becomeFirstResponder()
            return
        }
        guard let passwordField =  passwordCell?.textField, isValidRequest(.password, passwordField) else {
            passwordCell?.highlighted()
            passwordCell?.textField.becomeFirstResponder()
            return
        }
        button.setLoadingMode()
        emailField.isEnabled = false
        passwordField.isEnabled = false
        
        // Call API
        
        KAppDelegate.navigateToHomeController()
        button.unsetLoadingMode()
    }
    
    // MARK:  Check Validation
    private func isValidRequest(_ field: SignIn.Fields, _ textField: UITextField) -> Bool {
        switch field {
        case .email:
            if textField.isEmpty || textField.text?.count == 0 {
                UIAlertController.show(self, KAlertTitle, enterEmailAddress)
                return false
            }
            if !(textField.text!.isValidEmail)  {
                UIAlertController.show(self, KAlertTitle, enterValidEmailAddress)
                return false
            }
        case .password:
            if textField.isEmpty || textField.text?.count == 0 {
                UIAlertController.show(self, KAlertTitle, enterPassword)
                return false
            }
        case .message:
            break
        }
        return true
    }
    
    // MARK:  Initialization
    private func initialization() {
        
        func setUpNavigationBar() {
            self.navigationController?.isNavigationBarHidden = false
            
            if #available(iOS 11.0, *) {
                self.navigationController?.navigationBar.prefersLargeTitles = true
                self.navigationItem.largeTitleDisplayMode = .always
            }
            self.navigationItem.title = signInTitle
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
        return SignIn.sections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SignIn.allCases[section].rows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var labelWidth: CGFloat = 0
        for text in [emailTitle, passwordTitle] {
            let font = UIFont.system(.regular, 17)
            let fontAttributes = [NSAttributedString.Key.font: font]
            let calculatedSize = NSString.init(string: text).size(withAttributes: fontAttributes)
            labelWidth.setIfFewer(when: calculatedSize.width + 1)
        }
        switch SignIn.allCases[indexPath.section] {
        case .fields:
            if SignIn.Fields.allCases[indexPath.row] == .message {
                let cell: TextLabelCell = tableView.dequeueReusableCell(for: indexPath)
                cell.label.text = SignIn.Fields.allCases[indexPath.row].details().title
                cell.separatorInset.left = 0
                return cell
            }
            else {
                let cell: TextFieldCell = tableView.dequeueReusableCell(for: indexPath)
                cell.label.text = SignIn.Fields.allCases[indexPath.row].details().title
                cell.textField.placeholder = SignIn.Fields.allCases[indexPath.row].details().placeholder
                cell.textField.delegate = self
                cell.textField.tag = SignIn.Fields.allCases[indexPath.row].rawValue
                cell.fixWidthLabel = labelWidth
                if SignIn.Fields.allCases[indexPath.row] == .password {
                    cell.textField.isSecureTextEntry = true
                    cell.separatorInset.left = 0
                }
                return cell
            }
        case .buttons:
            let cell: ButtonCell = tableView.dequeueReusableCell(for: indexPath)
            cell.button.setTitle(SignIn.Buttons.allCases[indexPath.row].title, for: .normal)
            cell.separatorInset.left = 0
            cell.button.tag = SignIn.Buttons.allCases[indexPath.row].rawValue
            cell.button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    
    // MARK:  Text field delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
