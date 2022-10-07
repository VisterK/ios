//
//  ViewController.swift
//  hw4
//
//  Created by Egor Kapustin on 25.09.2022.
//

import UIKit

final class WelcomeViewController: UIViewController {
    private let commentLabel = UILabel()
    private let valueLabel = UILabel()
    private let incrementButton = UIButton()
    private let colorPaletteView = ColorPaletteView()
    private let notesViewContrller = NotesViewController()
    private var commentView = UIView()
    private var value: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"

        self.view.addSubview(valueLabel)
        valueLabel.pinBottom(to: incrementButton.topAnchor, 16)
        valueLabel.pinCenter(to: self.view.centerXAnchor)
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemGray6
        commentView = setupCommentView()
        
        setupIncrementButton()
        setupValueLabel()
        
        let buttonsSV = setupMenuButtons()
        setupColorControlSV(buttonsSV: buttonsSV)
        
        colorPaletteView.addTarget(self, action: #selector(changeColor), for: .touchDragInside)
    }
    
    private func setupIncrementButton() {
        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        self.view.addSubview(incrementButton)
        incrementButton.setHeight(to: 48)
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pin(to: self.view, [.left: 24, .right: 24])
        incrementButton.addTarget(self, action: #selector(incrementButtonPressed), for: .touchUpInside)
    }
                                            
    @objc
    private func incrementButtonPressed() {
        value += 1
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        UIView.animate(withDuration: 10) {
            self.valueLabel.text = String(self.value)
            self.updateCommentLabel(value: self.value)
        }
    }
    private func setupCommentView() -> UIView {
        let commentView = UIView()
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12

        self.view.addSubview(commentView)
        commentView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pin(to: self.view, [.left: 24, .right: 24])

        commentLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        commentLabel.text = "0"

        commentView.addSubview(commentLabel)
        commentLabel.pin(to: commentView, [.top: 16, .left: 16, .bottom: 16, .right: 16])

        return commentView
    }
    
    private func updateCommentLabel(value: Int) {
        switch value {
        case 0...10:
            commentLabel.text = "1"
        case 10...20:
            commentLabel.text = "2"
        case 20...30:
            commentLabel.text = "3"

        case 30...40:
            commentLabel.text = "4"
        case 40...50:
            commentLabel.text = "! ! ! ! ! ! ! ! ! "
        case 50...60:
            commentLabel.text = "big boy"

        case 60...70:
            commentLabel.text = "70 70 70 moreeeee"
        case 70...80:
            commentLabel.text = "⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ "
        case 80...90:
            commentLabel.text = "80+\n go higher!"

        case 90...100:
            commentLabel.text = "100!! to the moon!!"
        default:
            break
        }
    }
    
    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }
    
    private func setupColorControlSV(buttonsSV: UIStackView) {
        colorPaletteView.isHidden = true
        view.addSubview(colorPaletteView)
        colorPaletteView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                colorPaletteView.topAnchor.constraint(equalTo: incrementButton.bottomAnchor, constant: 8),
                colorPaletteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
                colorPaletteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
                colorPaletteView.bottomAnchor.constraint(equalTo: buttonsSV.topAnchor, constant: -8),
            ]
        )
    }
    
    @objc
    private func notesButtonPressed() {
        present(UINavigationController(rootViewController: notesViewContrller), animated: true)
    }
    
    private func setupMenuButtons() -> UIStackView {
        let colorsButton = makeMenuButton(title: "color ")
        colorsButton.addTarget(self, action: #selector(paletteButtonPressed), for: .touchUpInside)
        
        let notesButton = makeMenuButton(title: "notes")
        notesButton.addTarget(self, action: #selector(notesButtonPressed), for: .touchUpInside)
        let newsButton = makeMenuButton(title: "3 ")
        
        let buttonsSV = UIStackView(arrangedSubviews: [colorsButton, notesButton, newsButton])
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually

        self.view.addSubview(buttonsSV)
        buttonsSV.pin(to: self.view, [.left: 24, .right: 24])
        buttonsSV.pinBottom(to: self.view.safeAreaLayoutGuide.bottomAnchor, 24)
        return buttonsSV
    }
    
    @objc
    private func paletteButtonPressed() {
        colorPaletteView.isHidden.toggle()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    @objc
    private func changeColor(_ slider: ColorPaletteView) {
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = slider.chosenColor
        }
    }
}

