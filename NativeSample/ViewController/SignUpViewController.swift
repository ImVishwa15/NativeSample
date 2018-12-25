//
//  SignUpViewController.swift
//  NativeSample
//
//  Created by Vishwajeet K on 12/25/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

private enum SignUp: Int, CaseIterable {
    case fields
    case buttons
    
    static var sections: Int {
        return SignUp.allCases.count
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
        case name = 100
        case email
        case password
        case confirmPassword
        case gender
        case dob
        
        func details() -> (title: String?, placeholder: String?) {
            switch self {
            case .name:
                return (nameTitle, namePlaceholder)
            case .email:
                return  (emailTitle, emailPlaceholer)
            case .password:
                return (passwordTitle, passwordPlaceholer)
            case .confirmPassword:
                return (confirmPasswordTitle, passwordPlaceholer)
            case .dob:
                return (dobTitle, dobPlaceholder)
            case .gender:
                return (genderTitle, genderPlaceholder)
            }
        }
        
        func value(_ user: User) -> Any? {
            switch self {
            case .name:
                return user.username
            case .email:
                return user.email
            case .password:
                return user.password
            case .confirmPassword:
                return user.confirmPassword
            case .gender:
                return user.gender
            case .dob:
                return user.dob
            }
        }
    }
    
    // enum for buttons
    enum Buttons: Int, CaseIterable {
        case signUp = 1
        
        var title: String? {
            switch self {
            case .signUp:
                return signUpTitle
            }
        }
    }
}

class SignUpViewController: UITableViewController {
    
    private var user = User()
    
    //MARK:  Identifier
    static var identifier: String {
        return "SignUpViewController"
    }
    
    // MARK:  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let cell = self.tableView.cellForRow(at: IndexPath.init(row: SignUp.Fields.name.rawValue - textFieldTag, section: SignUp.fields.rawValue)) as? TextFieldCell  {
            cell.textField.becomeFirstResponder()
        }
    }
    
    // MARK:  Button Action
    @objc private func signUpButtonAction(_ button: DownloadingButton) {
        
        var nameCell: TextFieldCell? = nil
        var emailCell: TextFieldCell? = nil
        var passwordCell: TextFieldCell? = nil
        var confirmPasswordCell: TextFieldCell? = nil
        var genderCell: DropDownCell? = nil
        var dobCell: DropDownCell? = nil
        
        if let cell = self.tableView.cellForRow(at: IndexPath.init(row: SignUp.Fields.name.rawValue - textFieldTag, section: SignUp.fields.rawValue)) as? TextFieldCell  {
            nameCell = cell
        }
        if let cell = self.tableView.cellForRow(at: IndexPath.init(row: SignUp.Fields.email.rawValue - textFieldTag, section: SignUp.fields.rawValue)) as? TextFieldCell  {
            emailCell = cell
        }
        if let cell = self.tableView.cellForRow(at: IndexPath.init(row: SignUp.Fields.password.rawValue - textFieldTag, section: SignUp.fields.rawValue)) as? TextFieldCell  {
            passwordCell = cell
        }
        if let cell = self.tableView.cellForRow(at: IndexPath.init(row: SignUp.Fields.confirmPassword.rawValue - textFieldTag, section: SignUp.fields.rawValue)) as? TextFieldCell  {
            confirmPasswordCell = cell
        }
        if let cell = self.tableView.cellForRow(at: IndexPath.init(row: SignUp.Fields.gender.rawValue - textFieldTag, section: SignUp.fields.rawValue)) as? DropDownCell  {
            genderCell = cell
        }
        if let cell = self.tableView.cellForRow(at: IndexPath.init(row: SignUp.Fields.dob.rawValue - textFieldTag, section: SignUp.fields.rawValue)) as? DropDownCell  {
            dobCell = cell
        }
        
        guard let nameField =  nameCell?.textField, isValidRequest(.name, nameField) else {
            nameCell?.highlighted()
            nameCell?.textField.becomeFirstResponder()
            return
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
        guard let confirmPasswordField =  confirmPasswordCell?.textField, isValidRequest(.confirmPassword, confirmPasswordField) else {
            confirmPasswordCell?.highlighted()
            confirmPasswordCell?.textField.becomeFirstResponder()
            return
        }
        guard let genderField =  genderCell?.textField, isValidRequest(.gender, genderField) else {
            genderCell?.highlighted()
            genderCell?.textField.becomeFirstResponder()
            return
        }
        guard let dobField =  dobCell?.textField, isValidRequest(.dob, dobField) else {
            dobCell?.highlighted()
            dobCell?.textField.becomeFirstResponder()
            return
        }
        
        button.setLoadingMode()
        nameField.isEnabled = false
        emailField.isEnabled = false
        passwordField.isEnabled = false
        confirmPasswordField.isEnabled = false
        genderField.isEnabled = false
        dobField.isEnabled = false
        // Call API
        
    }
    
    // MARK:  Check Validation
    private func isValidRequest(_ field: SignUp.Fields, _ textField: UITextField) -> Bool {
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
        case .name:
            if textField.isEmpty || textField.text?.count == 0 {
                UIAlertController.show(self, KAlertTitle, enterName)
                return false
            }
        case .confirmPassword:
            if textField.isEmpty || textField.text?.count == 0 {
                UIAlertController.show(self, KAlertTitle, enterConfirmPassword)
                return false
            }
            if (textField.text != self.user!.password!) {
                UIAlertController.show(self, KAlertTitle, confirmPasswordNotMatched)
                return false
            }
        case .dob:
            if textField.isEmpty || textField.text?.count == 0 {
                UIAlertController.show(self, KAlertTitle, enterDOB)
                return false
            }
        case .gender:
            if textField.isEmpty || textField.text?.count == 0 {
                UIAlertController.show(self, KAlertTitle, selectGender)
                return false
            }
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
            self.navigationItem.title = signUpTitle
        }
        
        func registerCell() {
            self.tableView.registerCell(ofType: TextFieldCell.self)
            self.tableView.registerCell(ofType: TextLabelCell.self)
            self.tableView.registerCell(ofType: ButtonCell.self)
            self.tableView.registerCell(ofType: DropDownCell.self)
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

extension SignUpViewController {
    
    // MARK:  Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SignUp.sections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SignUp.allCases[section].rows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var labelWidth: CGFloat = 0
        for text in [nameTitle, emailTitle, passwordTitle, confirmPasswordTitle, dobTitle] {
            let font = UIFont.system(.regular, 17)
            let fontAttributes = [NSAttributedString.Key.font: font]
            let calculatedSize = NSString.init(string: text).size(withAttributes: fontAttributes)
            labelWidth.setIfFewer(when: calculatedSize.width + 1)
        }
        switch SignUp.allCases[indexPath.section] {
        case .fields:
            if SignUp.Fields.allCases[indexPath.row] == .gender ||  SignUp.Fields.allCases[indexPath.row] == .dob {
                let cell: DropDownCell = tableView.dequeueReusableCell(for: indexPath)
                if  SignUp.Fields.allCases[indexPath.row] == .gender {
                    cell.textField.dropDownMode = IQDropDownMode.textPicker
                    cell.textField.isOptionalDropDown = true
                    cell.textField.itemList = [male, female]
                }
                else {
                    cell.separatorInset.left = 0
                    cell.textField.dropDownMode = IQDropDownMode.datePicker
                    cell.textField.dropDownDateFormatter.dateFormat = DateFormat.MM_d_yyyy
                    cell.textField.maximumDate  = Date()
                }
                cell.textField.iqDelegate = self
                cell.textField.delegate = self
                cell.label.text = SignUp.Fields.allCases[indexPath.row].details().title
                cell.fixWidthLabel = labelWidth
                cell.textField.placeholder = SignUp.Fields.allCases[indexPath.row].details().placeholder
                cell.textField.tag = SignUp.Fields.allCases[indexPath.row].rawValue
                cell.textField.text = SignUp.Fields.allCases[indexPath.row].value(self.user!) as? String
                return cell
            }
            else {
                let cell: TextFieldCell = tableView.dequeueReusableCell(for: indexPath)
                cell.label.text = SignUp.Fields.allCases[indexPath.row].details().title
                cell.fixWidthLabel = labelWidth
                cell.textField.placeholder = SignUp.Fields.allCases[indexPath.row].details().placeholder
                cell.textField.delegate = self
                cell.textField.tag = SignUp.Fields.allCases[indexPath.row].rawValue
                if SignUp.Fields.allCases[indexPath.row] == .password || SignUp.Fields.allCases[indexPath.row] == .confirmPassword {
                    cell.textField.isSecureTextEntry = true
                }
                cell.textField.text = SignUp.Fields.allCases[indexPath.row].value(self.user!) as? String
                return cell
            }
        case .buttons:
            let cell: ButtonCell = tableView.dequeueReusableCell(for: indexPath)
            cell.button.setTitle(SignUp.Buttons.allCases[indexPath.row].title, for: .normal)
            cell.separatorInset.left = 0
            cell.button.tag = indexPath.row
            cell.button.addTarget(self, action: #selector(signUpButtonAction(_:)), for: .touchUpInside)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension SignUpViewController: UITextFieldDelegate, IQDropDownTextFieldDelegate {

    // MARK:  IQDropDownTextFieldDelegate
    func textField(_ textField: IQDropDownTextField, didSelectItem item: String?) {
    
    }
    
    // MARK:  Text field delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let cell = self.tableView.cellForRow(at: IndexPath.init(row: SignUp.Fields.dob.rawValue - textFieldTag, section: SignUp.fields.rawValue)) as? DropDownCell  {
            if textField == cell.textField {
                if cell.textField.isEmpty == true {
                    cell.textField.text = Date().string(DateFormat.MM_d_yyyy) as String
                }
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let field = SignUp.Fields(rawValue: textField.tag) {
            switch field {
            case .name:
                self.user?.username = textField.text
            case .email:
                self.user?.email = textField.text
            case .password:
                self.user?.password = textField.text
            case .confirmPassword:
                self.user?.confirmPassword = textField.text
            case .dob:
                self.user?.dob = textField.text
            case .gender:
                self.user?.gender = textField.text
            }
        }
    }
}
