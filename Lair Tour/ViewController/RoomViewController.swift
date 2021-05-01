//
//  DoorwayViewController.swift
//  Lair Tour
//
//  Created by Jamie Chen on 2021-04-30.
//

import UIKit

class RoomViewController: UIViewController {
    
    private(set) var roomNode: RoomNodeType
    private var nextRooms: [RoomNodeType] = []
    lazy var roomImageView: UIImageView = {
        let img = UIImage(named: roomNode.imageName)
        let imgV = UIImageView(image: img)
        imgV.contentMode = .scaleAspectFit
        imgV.translatesAutoresizingMaskIntoConstraints = false
        return imgV
    }()
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(roomNode: RoomNodeType) {
        self.roomNode = roomNode
        
        if let nextRooms = roomNode.nextRoom {
            self.nextRooms = nextRooms
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        setupView()
        layoutView()
    }
    
    private func setupView() {
        self.view.addSubview(self.roomImageView)
        
        for room in nextRooms {
            let button = UIButton(type: .system)
            button.setTitle(room.rawValue, for: .normal)
            button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
            buttonStackView.addArrangedSubview(button)
        }
        self.view.addSubview(self.buttonStackView)
    }
    
    private func layoutView() {
        let safeArea = self.view.safeAreaLayoutGuide
        self.roomImageView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        self.roomImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        self.roomImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        self.roomImageView.bottomAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        
        self.buttonStackView.topAnchor.constraint(equalTo: self.roomImageView.bottomAnchor).isActive = true
        self.buttonStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        self.buttonStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        self.buttonStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    @objc func buttonPressed(sender: UIButton) {
        guard
            let title = sender.titleLabel?.text,
            let nextRoom = RoomNodeType(rawValue: title)
        else { return }
        
        let nextRoomVC = RoomViewController(roomNode: nextRoom)
        nextRoomVC.title = nextRoom.rawValue
        self.navigationController?.pushViewController(nextRoomVC, animated: true)
    }
}