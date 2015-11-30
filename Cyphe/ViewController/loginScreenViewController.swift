

import Foundation
import UIKit

class loginScreenViewController: UIViewController {
    
    //Varibles
    var logedIn = 0
    var loginInforCorrect = 0
    var usernameForm: String!
    var passwordForm: String!
    var username = ["Matt", "Max", "Cam", "Cain"]
    var password = ["abc", "password", "123"]
    
    //IBOutlets
    @IBOutlet weak var loginErrorMessage: UILabel!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //IBFunctions
    @IBAction func LoginPressed(sender: AnyObject) {

        if username.contains(usernameInput.text!) && password.contains(passwordInput.text!) {
            print("Logged In")
            UserInfo.userName = usernameInput.text!
            performSegueWithIdentifier("loginButtonSegue", sender: self)
        } else {
            loginErrorMessage.text = "Incorrect Username/Password, Please Try Again!"
        }
    }
    
    @IBAction func registerPressed(sender: AnyObject) {
        performSegueWithIdentifier("registerButtonSegue", sender: self)
    }
    
    @IBAction func anonymousLogin(sender: AnyObject) {
        performSegueWithIdentifier("loginButtonSegue", sender: self)
    }
    
    
    //ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if usernameForm != nil {
            usernameInput.text = "\(usernameForm)"
            passwordInput.text = "\(passwordForm)"
        }
        
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    
    }
    
    //Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //loginSegue
        if segue.identifier == "loginButtonSegue" {
            let loginPressed = segue.destinationViewController as! SWRevealViewController
            //loginPressed.logedIn = 1
        }
        //registerSegue
        if segue.identifier == "registerButtonSegue" {
            segue.destinationViewController as! registerViewController
        }
    }
}

extension loginScreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            if username.contains(usernameInput.text!) && password.contains(passwordInput.text!) {
                print("Logged In")
                performSegueWithIdentifier("loginButtonSegue", sender: self)
            } else {
                loginErrorMessage.text = "Incorrect Username/Password, Please Try Again!"
                view.endEditing(true)
            }
        }
        
        return true
    }
}