
import UIKit

class TextField: UITextField {

    enum TextFieldType {
        case username
        case email
        case password
    }

    private let authFieldType: TextFieldType

    init(fieldType: TextFieldType) {
        self.authFieldType = fieldType
        super.init(frame: .zero)

        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10

        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none

        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))

        switch fieldType {
        case .username:
            self.placeholder = "사용자 이름"
        case .email:
            self.placeholder = "이메일"
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress

        case .password:
            self.placeholder = "비밀번호"
            self.textContentType = .oneTimeCode
            self.isSecureTextEntry = true
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}