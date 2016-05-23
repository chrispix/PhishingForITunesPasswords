
import UIKit

class ViewController: UIViewController {

    private var emailAddress: String?
    private var password: String?

    let email = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor()

        let stackView = UIStackView()
        stackView.axis = .Vertical
        stackView.alignment = .Leading
        stackView.distribution = .EqualSpacing
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        for (attribute, constant) in [(NSLayoutAttribute.Left, CGFloat(50)),(NSLayoutAttribute.Top, CGFloat(50)),(NSLayoutAttribute.Right, CGFloat(-50))/*,(NSLayoutAttribute.Bottom, CGFloat(-50))*/] {
            let constraint = NSLayoutConstraint(item: stackView,
                                                attribute: attribute,
                                                relatedBy: .Equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: constant)
            constraint.active = true
        }

        let label = UILabel()
        label.text = "Welcome to Phish. You'll be schooled in no time. Just enter your email address to get started."
        label.numberOfLines = 0
        stackView.addArrangedSubview(label)

        email.placeholder = "Enter your email address"
        email.autocapitalizationType = .None
        email.autocorrectionType = .No
        email.keyboardType = .EmailAddress
        email.returnKeyType = .Go
        email.borderStyle = .RoundedRect
        email.delegate = self
        stackView.addArrangedSubview(email)

        let button = UIButton(type: .System)
        button.setTitle("Get started!", forState: .Normal)
        button.addTarget(self, action: #selector(ViewController.saveEmail), forControlEvents: .TouchUpInside)
        stackView.addArrangedSubview(button)

        email.becomeFirstResponder()
    }

    func saveEmail() {
        emailAddress = email.text
        promptForItunes()
    }

    func promptForItunes() {
        let alert = UIAlertController(title: "Sign In to iTunes Store", message: "Enter the password for your\nApple ID\n\"\(emailAddress!)\".", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler({ textField in
            textField.secureTextEntry = true
        })
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { action in
            self.password = alert.textFields![0].text
            self.showPassword()
        })
        alert.addAction(cancel)
        alert.addAction(ok)
        presentViewController(alert, animated: true, completion: nil)
    }

    func showPassword() {
        let alert = UIAlertController(title: "Thanks!", message: "Your iTunes password is \(password!)", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        saveEmail()
        return false
    }
}

