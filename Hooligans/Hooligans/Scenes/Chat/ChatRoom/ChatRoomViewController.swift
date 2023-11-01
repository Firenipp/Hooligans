//
//  ChatListViewController.swift
//  Hooligans
//
//  Created by 정명곤 on 2023/10/01.
//

import UIKit
import SnapKit
import StompClientLib
import Combine

protocol ChatRoomDisplayLogic {
    func displayChatMessage(viewModel: ChatRoomModels.ChatMessage.ViewModel)
}

class ChatRoomViewController: UIViewController {
    var interactor: (ChatRoomBusinessLogic & ChatRoomDataStore)?
    
//    private let stomp: StompManager?
    private var cancellables = Set<AnyCancellable>()
    
    private var chatRoom: ChatRoom!
    var messages: [Message] = []

    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor =  UIColor(red: 0.2549, green: 0.2706, blue: 0.3176, alpha: 1.0)
        return view
    }()

    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.frame = CGRect(origin: .zero, size: .zero)
        //table.backgroundColor = .white
        table.backgroundColor =  UIColor(red: 0.2549, green: 0.2706, blue: 0.3176, alpha: 1.0)
        return table
    }()

    private let chatTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        textView.layer.cornerRadius = 20
        textView.layer.masksToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(systemName: "paperplane.circle.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 35))
            .withRenderingMode(.alwaysTemplate)
        button.backgroundColor = .clear
        button.setImage(buttonImage, for: .normal)
        button.tintColor = UIColor(red: 0.1529, green: 0.1804, blue: 0.498, alpha: 1.0)
        button.transform = CGAffineTransform(rotationAngle: .pi / 4)

        return button
    }()

    init(chatRoom: ChatRoom) {
        super.init(nibName: nil, bundle: nil)
        self.chatRoom = chatRoom
        StompManager.shard.connect(chatRoom: chatRoom, delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerCell()
        tableView.delegate = self
        tableView.dataSource = self
        chatTextView.delegate = self

        let backButton = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = backButton
        backButton.tintColor = .black

        teamNameLabel.text = "Selected Team Name"

        let teamNameItem = UIBarButtonItem(customView: teamNameLabel)
        navigationItem.rightBarButtonItem = teamNameItem
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        StompManager.shard.disconnect()
    }

    private func setup() {
        let viewController = self
        let interactor = ChatRoomInteractor()
        let presenter = ChatRoomPresenter()
//        let router = ChatRoomRouter()
        viewController.interactor = interactor
//        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
//        router.viewController = viewController
//        router.dataStore = interactor
    }
        
    private func registerCell() {
        tableView.register(ChatBubbleCell.self, forCellReuseIdentifier: ChatBubbleCell.identifier)
        tableView.register(MyChatBubbleCell.self, forCellReuseIdentifier: MyChatBubbleCell.identifier)
    }
}

extension ChatRoomViewController {
    private func setupView() {
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(sendButton)
        
        sendButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-5)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-5)
            make.height.width.equalTo(40)
        }

        sendButton.addTarget(self, action: #selector(sendMessageSTOMP), for: .touchUpInside)


        self.view.addSubview(chatTextView)
        chatTextView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-5)
            make.height.equalTo(40)
            make.width.equalTo(330)
        }

//        
        self.view.addSubview(headerView)

        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(10)
        }

        
//        self.headerView.addTarget(self, action: #selector(subscribeSTOMP), for: .touchUpInside)
        
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(chatTextView.snp.top).offset(-5)
        }
        
    }
    
    @objc func sendMessageSTOMP() {
        StompManager.shard.sendMessage(type: "TALK", roomId: chatRoom.roomId, message: "hi")
    }

    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }
}

extension ChatRoomViewController: ChatRoomDisplayLogic {
    func displayChatMessage(viewModel: ChatRoomModels.ChatMessage.ViewModel) {
        DispatchQueue.main.async {
            self.messages.append(viewModel.message)
            self.tableView.reloadData()
        }
    }
    
}

extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 45
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if messages[indexPath.row].sender == "m" {
            guard let mycell = tableView.dequeueReusableCell(withIdentifier: MyChatBubbleCell.identifier, for: indexPath) as? MyChatBubbleCell else { return UITableViewCell() }
            mycell.chatRoomLabel.text = self.messages[indexPath.row].message
            
            return mycell
        }
        
        guard let usercell = tableView.dequeueReusableCell(withIdentifier: ChatBubbleCell.identifier, for: indexPath) as? ChatBubbleCell else { return UITableViewCell() }
        usercell.chatRoomLabel.text = self.messages[indexPath.row].message
        
        return usercell
    }
    
}

extension ChatRoomViewController: UITextFieldDelegate {
    
}

extension ChatRoomViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)

        textView.snp.updateConstraints { make in
        // 텍스트뷰 높이 동적으로 변경
        make.height.equalTo(estimatedSize.height)
        }
    }
}

extension ChatRoomViewController: StompClientLibDelegate {
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        guard let response = stringBody?.data(using: .utf8) else { return }
        
        Just(response)
            .decode(type: Message.self, decoder: JSONDecoder())
            .sink { result in
                switch result {
                case .finished:
                    print("Decode Message Finished")
                case .failure(_):
                    print("Decode Fail")
                }
            } receiveValue: { message in
                self.messages.append(message)
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
//        self.interactor?.getChatMessage(message: response)
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Stomp socket is disconnected")
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        print("Stomp socket is connected")
        
        StompManager.shard.subscribe(chatRoom: chatRoom)
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("Receipt: \(receiptId)")
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("Error send: " + description)
        
//        stomp.disconnect()
//        registerSocket()
   
    }
    
    func serverDidSendPing() {
        print("Server ping")
    }
}

