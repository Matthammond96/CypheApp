
import Foundation
import UIKit

class registerViewController: UIViewController {
    //varibles
    
    //form IB

    @IBOutlet weak var UsernameForm: UITextField!
    @IBOutlet weak var passwordForm: UITextField!
    @IBOutlet weak var passwordForm2: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func registerButton(sender: AnyObject) {
        if UsernameForm.text == "" && passwordForm.text == "" && passwordForm2.text == "" {
            errorLabel.text = "Please fill in the required information (*)"
        } else {
            if passwordForm.text == passwordForm2.text {
                print(UsernameForm.text)
                print(passwordForm.text)
                performSegueWithIdentifier("registerFormFilled", sender: self)
            } else {
               errorLabel.text = "Passowrds Do Not Match"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "registerFormFilled" {
            let registeredButton = segue.destinationViewController as! loginScreenViewController
            registeredButton.usernameForm = UsernameForm.text
            registeredButton.passwordForm = passwordForm.text
        }
    }
}