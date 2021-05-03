//
//  DoorwayViewController.swift
//  Lair Tour
//
//  Created by Jamie Chen on 2021-04-30.
//

import UIKit

class RoomViewController: UIViewController {
    
    private(set) var roomNode: RoomNodeType
    var roomImageView: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        imgV.translatesAutoresizingMaskIntoConstraints = false
        return imgV
    }()
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(roomNode: RoomNodeType) {
        self.roomNode = roomNode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        // back to gate way button will not be shown in root VC in nav controller
        if self.roomNode != .doorway {
            let backToFirstRoomButton = UIBarButtonItem(title: "To Gate", style: .plain, target: self, action: #selector(backToGate))
            self.navigationItem.rightBarButtonItem = backToFirstRoomButton
        }
        setupView()
        layoutView()
    }
    
    private func setupView() {
        // add image to imageView
        self.roomImageView.image = UIImage(named: self.roomNode.imageName)
        self.view.addSubview(self.roomImageView)
        
        // if there is any next room, add button
        if let nextRooms = self.roomNode.nextRooms {
            self.buttonStackView.addArrangedSubview(UIView())
            for room in nextRooms {
                let button = UIButton(type: .system)
                button.setTitle(room.rawValue, for: .normal)
                button.addTarget(self, action: #selector(toNextRoom(sender:)), for: .touchUpInside)
                self.buttonStackView.addArrangedSubview(button)
            }
            self.buttonStackView.addArrangedSubview(UIView())
        }
        self.view.addSubview(self.buttonStackView)
    }
    
    private func layoutView() {
        let safeArea = self.view.safeAreaLayoutGuide
        self.roomImageView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        self.roomImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        self.roomImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        self.roomImageView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 3/5).isActive = true
        
        self.buttonStackView.topAnchor.constraint(equalTo: self.roomImageView.bottomAnchor).isActive = true
        self.buttonStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        self.buttonStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        self.buttonStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    @objc func toNextRoom(sender: UIButton) {
        guard
            let title = sender.titleLabel?.text,
            let nextRoom = RoomNodeType(rawValue: title)
        else { return }
        
        let nextRoomVC = RoomViewController(roomNode: nextRoom)
        nextRoomVC.title = nextRoom.rawValue
        self.navigationController?.pushViewController(nextRoomVC, animated: true)
    }
    
    @objc func backToGate() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
