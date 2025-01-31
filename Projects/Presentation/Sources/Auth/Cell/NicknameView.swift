//import UIKit
//import SnapKit
//
//class NicknameView: UIView, UITextFieldDelegate {
//
//    var previousEmail: String?
//    var previousPassword: String?
//    var previousPhoneNumber: String?
//
//    let backButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("뒤로", for: .normal)
//        return button
//    }()
//
//    let nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "닉네임을 정해주세요"
//        label.textColor = .black
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        return label
//    }()
//
//    let nicknameField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "@첼시는강등이딱이야"
//        return textField
//    }()
//
//    let nextButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("다음", for: .normal)
//        button.backgroundColor = .systemIndigo
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 10
//        return button
//    }()
//
//    let activityIndicator: ActivityIndicator = {
//        let indicator = ActivityIndicator(style: .large)
//        return indicator
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//        nicknameField.delegate = self
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupUI()
//    }
//
//    private func setupUI() {
//        self.backgroundColor = .white
//
//        addSubview(backButton)
//        backButton.snp.makeConstraints { make in
//            make.top.equalTo(safeAreaLayoutGuide).offset(20)
//            make.leading.equalTo(self).offset(20)
//        }
//        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//
//        addSubview(nameLabel)
//        nameLabel.snp.makeConstraints { make in
//            make.top.equalTo(backButton.snp.bottom).offset(20)
//            make.leading.trailing.equalTo(self)
//        }
//
//        addSubview(nicknameField)
//        nicknameField.snp.makeConstraints { make in
//            make.top.equalTo(nameLabel.snp.bottom).offset(50)
//            make.leading.equalTo(self).offset(20)
//            make.trailing.equalTo(self).offset(-20)
//            make.height.equalTo(40)
//        }
//
//        addSubview(nextButton)
//        nextButton.snp.makeConstraints { make in
//            make.centerX.equalTo(self)
//            make.leading.equalTo(self).offset(20)
//            make.height.equalTo(50)
//            make.bottom.equalTo(safeAreaLayoutGuide).offset(-40)
//        }
//        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        addBottomLine(to: nicknameField)
//    }
//
//    private func addBottomLine(to textField: UITextField) {
//        let bottomLine = CAShapeLayer()
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0.0, y: textField.bounds.size.height - 1))
//        path.addLine(to: CGPoint(x: textField.bounds.size.width, y: textField.bounds.size.height - 1))
//        bottomLine.path = path.cgPath
//        bottomLine.strokeColor = UIColor.lightGray.cgColor
//        textField.layer.addSublayer(bottomLine)
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        setBottomLineColor(of: textField, to: .systemIndigo)
//        setBottomLineProperties(of: textField, with: 1.2)
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        setBottomLineColor(of: textField, to: .systemGray5)
//    }
//
//    func setBottomLineProperties(of textField: UITextField, with thickness: CGFloat) {
//        if let bottomLine = textField.layer.sublayers?.first as? CAShapeLayer {
//            bottomLine.lineWidth = thickness
//        }
//    }
//
//    private func setBottomLineColor(of textField: UITextField, to color: UIColor) {
//        if let bottomLine = textField.layer.sublayers?.first as? CAShapeLayer {
//            bottomLine.strokeColor = color.cgColor
//        }
//    }
//
//    @objc private func backButtonTapped() {
//        guard let phonenumberView = PhonenumberView(frame: frame) as? PhonenumberView else { return }
//        phonenumberView.emailTextField.text = previousEmail
//        phonenumberView.passwordTextField.text = previousPassword
//        phonenumberView.phoneNumberField.text = previousPhoneNumber
//
//        superview?.addSubview(phonenumberView)
//        removeFromSuperview()
//    }
//
//    private func showAlert(title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
//
//        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
//            rootViewController.present(alert, animated: true, completion: nil)
//        }
//    }
//
//    @objc private func nextButtonTapped() {
//        // 로딩 표시 시작
//        nextButton.setTitle("", for: .normal)
//        nextButton.isEnabled = false // 버튼 중복 입력 방지
//        
//        activityIndicator.start(on: self)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {            
//            // 로딩 표시 중지
//            self.activityIndicator.stopAnimating()
//            self.nextButton.isEnabled = true // 버튼 상태 복원
//            self.nextButton.setTitle("다음", for: .normal) // 텍스트 복원
//
//            if let nickname = self.nicknameField.text, !nickname.isEmpty {
//                let selectTeamView = SelectTeamView(frame: self.frame ?? CGRect.zero)
//                selectTeamView.previousEmail = self.previousEmail
//                selectTeamView.previousPassword = self.previousPassword
//                selectTeamView.previousPhoneNumber = self.previousPhoneNumber
//                selectTeamView.previousNickname = nickname
//
//                self.subviews.forEach { $0.removeFromSuperview() }
//                self.addSubview(selectTeamView)
//            } else {
//                self.showAlert(title: "닉네임 입력", message: "닉네임을 입력해주세요.")
//            }
//        }
//    }
//}
