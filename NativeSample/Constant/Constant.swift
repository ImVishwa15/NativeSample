//
//  Constant.swift
//  NativeSample
//
//  Created by Vishwajeet K on 11/29/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

//  Message  

public let homeTitle: String = "Home"
public let signInTitle: String = "Sign In"
public let forgetPasswordTitle: String = "Forget Password"
public let signUpTitle: String = "Sign Up"
public let nameTitle: String = "Username"
public let namePlaceholder: String = "abc"
public let male: String = "Male"
public let female: String = "Female"
public let genderTitle: String = "Gender"
public let genderPlaceholder: String = "Male"
public let dobTitle: String = "Date of Birth"
public let dobPlaceholder: String = "dd/mm/yyyy"
public let emailTitle: String = "Email"
public let emailPlaceholer: String = "example@icloud.com"
public let passwordTitle: String = "Password"
public let passwordPlaceholer: String = "required"
public let confirmPasswordTitle: String = "Confirm Password"
public let enterEmailAddress: String = "Please enter email address"
public let enterValidEmailAddress: String = "Enter valid email address"
public let enterPassword: String = "Please enter Password"
public let enterDOB: String = "Please enter date of birth"
public let enterName: String = "Please enter name"
public let selectGender: String = "Please select Gender"
public let enterConfirmPassword: String = "Please confirm password"
public let confirmPasswordNotMatched: String = "Password and confirm password does not matched"
public let signInComment: String = "Please enter a pair of login and password"
public let forgetPasswordComment: String = "Please enter your registered email address to send reset password instruction"
public let logoutConfirmation: String = "Do you want to logout?"
public let logoutTitle: String = "Logout"


//  Constant  

let KAppDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

let textFieldTag = 100
let buttonTag = 1


//  Enumeration  

public struct CustomColor {
    static let red = UIColor("FF3B30")
    static let orange = UIColor("FF9500")
    static let yellow = UIColor("FFCC00")
    static let green = UIColor("4CD964")
    static let tealBlue = UIColor("5AC8FA")
    static let blue = UIColor("007AFF")
    static let purple = UIColor("5856D6")
    static let pink = UIColor("FF2D55")
    static let white = UIColor("FFFFFF")
    static let lightGray = UIColor("E5E5EA")
    static let lightGray2 = UIColor("D1D1D6")
    static let midGray = UIColor("C7C7CC")
    static let gray = UIColor("8E8E93")
    static let black = UIColor("000000")
    static let darkGray = UIColor("6D6D72")
    static let customGray = UIColor("EFEFF4")
}


//  ColorType
public enum ColorType: Int {
    case white
    case black
    case lightGray
    case blue
    case red
    
    var color: UIColor {
        switch self {
        case .white:
            return .white
        case .black:
            return .black
        case .lightGray:
            return .gray
        case .blue:
            return .blue
        case .red:
            return .red
        }
    }
}

//  GradientColor
public enum GradientColor: Int {
    case white
    case blue
    case green
    case orange
    
    var colors: [UIColor] {
        switch self {
        case .white:
            return [UIColor.white]
        case .blue:
            return [CustomColor.blue, CustomColor.purple]
        case .green:
            return [CustomColor.green, CustomColor.gray]
        case .orange:
            return [CustomColor.orange, CustomColor.yellow]
        }
    }
}
