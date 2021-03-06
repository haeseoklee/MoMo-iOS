//
//  OnboardingWrite1ViewController.swift
//  MoMo
//
//  Created by Haeseok Lee on 2021/01/07.
//

import UIKit
import CLTypingLabel

class OnboardingWriteViewController: UIViewController {

    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var sentenceLabel: UILabel!
    @IBOutlet weak var typingLabel: CLTypingLabel!
    @IBOutlet weak var typingCursorLabel: UILabel!
    @IBOutlet weak var featherImage: UIImageView!
    @IBOutlet weak var onboardingCircleSmallImage: UIImageView!
    @IBOutlet weak var onboardingCircleBigImage: UIImageView!
    @IBOutlet weak var sentenceInfoStackView: UIStackView!
    
    // MARK: - Properties
    
    var selectedSentence: AppSentence?
    var selectedMood: AppEmotion?
    private var sentenceWasShown: Bool = false
    private let vspaingInfoLabelFeatherImage: CGFloat = 74
    private let vspaingInfoLabelSentenceInfoStackView: CGFloat = 116
    private let vspaingInfoLabelSentenceLabel: CGFloat = 147
    private let fontSizeSentenceLabelAfterAnimation: CGFloat = 14
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.infoLabel.attributedText = "문장이 감성을 자극하고\n깊이있는 기록을 도와줄 거예요".textSpacing()
        self.hideTypingCursorLabel()
        self.typingLabel.onTypingAnimationFinished = self.showTypingCursorBlinkWithAnimation
        self.updateSentenceLabel()
        self.hideFeatherImage()
        self.hideSentenceLabel()
        self.hideOnboardingCircleSmallImage()
        self.hideOnboardingCircleBigImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.sentenceWasShown {
            self.moveSentenceLabelAndFeatherImage()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showOnboardingCircleSmallImage()
        self.showOnboardingCircleBigImage()
        self.showSentenceLabelAndFeatherImageWithAnimation(
            completion: moveSentenceLabelAndFeatherImageWithAnimation
        )
        self.moveOnboardingCirclesWithAnimation()
    }
}

// MARK: - Functions

extension OnboardingWriteViewController {
    
    func updateSentenceLabel() {
        self.authorLabel.attributedText = self.selectedSentence?.author.textSpacing()
        self.bookTitleLabel.attributedText = self.changeToformattedText("<", self.selectedSentence?.bookTitle, ">").textSpacing()
        self.publisherLabel.attributedText = self.changeToformattedText("(", self.selectedSentence?.publisher, ")").textSpacing()
        self.sentenceLabel.attributedText = self.selectedSentence?.sentence.textSpacing()
        self.publisherLabel.numberOfLines = 1
        self.publisherLabel.lineBreakMode = .byTruncatingTail
    }
    
    func updateTypingLabel() {
        guard let typingText = self.selectedMood?.toTypingLabelText() else { return }
        self.typingLabel.attributedText = typingText.textSpacing()
    }
    
    func changeToformattedText(_ start: String, _ message: String?, _ end: String) -> String {
        guard let safeMessage = message else { return "" }
        return "\(start)\(safeMessage)\(end)"
    }
    
    func hideFeatherImage() {
        self.featherImage.isHidden = true
    }
    
    func hideSentenceLabel() {
        self.authorLabel.isHidden = true
        self.bookTitleLabel.isHidden = true
        self.publisherLabel.isHidden = true
        self.sentenceLabel.isHidden = true
    }
    
    func hideTypingLabel() {
        self.typingLabel.isHidden = true
    }
    
    func hideTypingCursorLabel() {
        self.typingCursorLabel.isHidden = true
    }
    
    func hideOnboardingCircleSmallImage() {
        self.onboardingCircleSmallImage.isHidden = true
    }
    
    func hideOnboardingCircleBigImage() {
        self.onboardingCircleBigImage.isHidden = true
    }
    
    func showFeatherImage() {
        self.featherImage.isHidden = false
    }
    
    func showSentenceLabel() {
        self.authorLabel.isHidden = false
        self.bookTitleLabel.isHidden = false
        self.publisherLabel.isHidden = false
        self.sentenceLabel.isHidden = false
    }
    
    func showTypingLabel() {
        self.typingLabel.isHidden = false
    }
    
    func showTypingCursorLabel() {
        self.typingCursorLabel.isHidden = false
    }
    
    func showOnboardingCircleSmallImage() {
        self.onboardingCircleSmallImage.isHidden = false
    }
    
    func showOnboardingCircleBigImage() {
        self.onboardingCircleBigImage.isHidden = false
    }
    
    func showSentenceLabelAndFeatherImageWithAnimation(completion: @escaping () -> Void) {
        UIView.transition(
            with: self.view,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: {
                self.showFeatherImage()
                self.showSentenceLabel()
            },
            completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(2500), execute: { () -> Void in
                    completion()
                })
                
            }
        )
    }
    
    func showTypingCursorBlinkWithAnimation () {
        self.typingCursorLabel.startBlink()
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + .milliseconds(1500),
            execute: { () -> Void in
                UIView.animate(
                    withDuration: 0.1,
                    delay: 0,
                    animations: {
                        self.typingCursorLabel.stopBlink()
                    },
                    completion: self.pushToDeepViewController(finished:)
                )
            }
        )
    }
    
    func moveOnboardingCirclesWithAnimation() {
        let movedown = CGAffineTransform(translationX: 0, y: 50)
        let moveup = CGAffineTransform(translationX: 0, y: -100)
        UIView.animate(
            withDuration: 2.0,
            delay: 0.5,
            animations: {
                self.onboardingCircleSmallImage.transform = movedown
                self.onboardingCircleBigImage.transform = moveup
            },
            completion: nil
        )
    }
    
    func moveSentenceLabelAndFeatherImageWithAnimation() {
        UIView.animate(
            withDuration: 1.0,
            delay: 0,
            animations: {
                self.moveSentenceLabelAndFeatherImage()
                self.sentenceWasShown = true
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                self.showTypingCursorLabel()
                self.updateTypingLabel()
            }
            
        )
    }
    
    func moveSentenceLabelAndFeatherImage() {
        let infoLabelXpos = self.infoLabel.frame.origin.x
        let infoLabelYpos = self.infoLabel.frame.origin.y
        let infoLabelHeight = self.infoLabel.frame.size.height
        
        self.featherImage.frame.origin.x = infoLabelXpos
        self.featherImage.frame.origin.y = infoLabelYpos + infoLabelHeight + self.vspaingInfoLabelFeatherImage
        
        self.sentenceInfoStackView.frame.origin.x = infoLabelXpos
        self.sentenceInfoStackView.frame.origin.y = infoLabelYpos + infoLabelHeight + self.vspaingInfoLabelSentenceInfoStackView
        
        self.sentenceLabel.frame.origin.x = infoLabelXpos
        self.sentenceLabel.frame.origin.y = infoLabelYpos + infoLabelHeight + self.vspaingInfoLabelSentenceLabel
        
        self.sentenceLabel.textColor = UIColor.Black4
        self.sentenceLabel.font = self.sentenceLabel.font.withSize(self.fontSizeSentenceLabelAfterAnimation)
        self.sentenceLabel.textAlignment = .left
    }
    
    func pushToDeepViewController(finished: Bool) {
        guard let deepViewController = self.storyboard?.instantiateViewController(identifier: Constants.Identifier.deepViewController) as? DeepViewController else { return }
        deepViewController.deepViewUsage = .onboarding
        self.navigationController?.pushViewController(deepViewController, animated: true)
    }
}
