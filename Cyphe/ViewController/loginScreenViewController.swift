
import Foundation
import UIKit

class loginScreenViewController: UIViewController {
    
    //Varibles
    var logedIn = 0
    var loginInforCorrect = 0
    var usernameForm: String!
    var passwordForm: String!
    
    //IBOutlets
    @IBOutlet weak var loginErrorMessage: UILabel!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    //IBFunctions
    @IBAction func LoginPressed(sender: AnyObject) {
        if loginInforCorrect == 0{
            print("Logged In")
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
    
    }
    
    //Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //loginSegue
        if segue.identifier == "loginButtonSegue" {
            let loginPressed = segue.destinationViewController as! findSpotViewController
            loginPressed.logedIn = 1
            
            
        }
        //registerSegue
        if segue.identifier == "registerButtonSegue" {
            let registerPressed = segue.destinationViewController as! registerViewController
            registerPressed.delegate = self
        }
    }
    
}

extension loginScreenViewController: registerDelagate {
    func fillInForm() {
        //usernameInput.text = "\(usernameForm)"
        //passwordInput.text = "\(passwordForm)"
        print("geahea")
    }
}