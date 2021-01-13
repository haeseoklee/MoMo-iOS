//
//  DiaryViewController.swift
//  MoMo
//
//  Created by Haeseok Lee on 2021/01/12.
//

import UIKit

struct DiaryInfo {
    var date: String
    var mood: Mood
    var depth: Depth
    var sentence: Sentence
    var diary: String
}

class DiaryViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var moodImage: UIImageView!
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var depthImage: UIImageView!
    @IBOutlet weak var depthLabel: UILabel!
    @IBOutlet weak var sentenceLabel: UILabel!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var diaryLabel: UILabel!
    @IBOutlet weak var blurView: UIView!
    
    var diaryWriteViewController: DiaryWriteViewController?
    var currentDepth: Depth?
    var menuView: MenuView?
    var alertModalView: AlertModalView?
    var menuToggleFlag: Bool = false
    var diaryInfo: DiaryInfo?
    
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "icSubtab"), style: .done, target: self, action: #selector(buttonPressed(sender:)))
        button.tag = 1
        button.tintColor = UIColor.white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getDiaryFromAPI(completion: updateValues(diaryInfo:))
        
        self.addBlurEffectOnBlurView(view: self.blurView)
        
        self.navigationItem.rightBarButtonItem = self.rightButton
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.menuView = MenuView.instantiate()
        self.alertModalView = AlertModalView.instantiate(
            alertLabelText: "소중한 일기가 삭제됩니다.\n정말 삭제하시겠어요?",
            leftButtonTitle: "취소",
            rightButtonTitle: "삭제"
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setBackgroundColorByDepth(depth: self.currentDepth)
    }
    
    func getDiaryFromAPI(completion: @escaping (DiaryInfo?) -> Void) {
        
        // MARK: - 이전뷰에서 받아오거나 네트워크에서 받아야 할 부분
        let defaultDiaryInfo: DiaryInfo = DiaryInfo(
            date: "2020. 12. 26. 토요일",
            mood: Mood.love,
            depth: Depth.depth300m,
            sentence: Sentence(
                author: "모모",
                bookTitle: "모모책",
                publisher: "모모출판사",
                sentence: "모모사랑해"
            ),
            diary:
                """
                오늘 새벽엔 눈이 내렸다. 창문을 열어 창문을 열어 흰 눈이 내린다. 그럼에도 어김없이 오피스로 출근을 했다.
                벌써 연말이 다가왔다는 것을 느낀다.

                집에 들어와서 물을 한 잔 마시고 다시 침대에 누워서 왓챠를 틀고 보던 미드를 이어서 보기 시작했다. 오늘은 계속 크리스마스란 참 좋다 오늘 새벽엔 눈이 내렸다. 창문을 열어 창문을 열어 흰 눈이 내린다. 그럼에도 어김없이 오피스로 출근을 했다.
                벌써 연말이 다가왔다는 것을 느낀다.

                집에 들어와서 물을 한 잔 마시고 다시 침대에 누워서 왓챠를 틀고 보던 미드를 이어서 보기 시작했다. 오늘은 계속 크리스마스란 참 좋다오늘 새벽엔 눈이 내렸다. 창문을 열어 창문을 열어 흰 눈이 내린다. 그럼에도 어김없이 오피스로 출근을 했다.
                벌써 연말이 다가왔다는 것을 느낀다.

                집에 들어와서 물을 한 잔 마시고 다시 침대에 누워서 왓챠를 틀고 보던 미드를 이어서 보기 시작했다. 오늘은 계속 크리스마스란 참 좋다

                집에 들어와서 물을 한 잔 마시고 다시 침대에 누워서 왓챠를 틀고 보던 미드를 이어서 보기 시작했다. 오늘은 계속 크리스마스란 참 좋다

                집에 들어와서 물을 한 잔 마시고 다시 침대에 누워서 왓챠를 틀고 보던 미드를 이어서 보기 시작했다. 오늘은 계속 크리스마스란 참 좋다

                집에 들어와서 물을 한 잔 마시고 다시 침대에 누워서 왓챠를 틀고 보던 미드를 이어서 보기 시작했다. 오늘은 계속 크리스마스란 참 좋다

                집에 들어와서 물을 한 잔 마시고 다시 침대에 누워서 왓챠를 틀고 보던 미드를 이어서 보기 시작했다. 오늘은 계속 크리스마스란 참 좋다
                """
        )
        
        self.diaryInfo = defaultDiaryInfo
        
        DispatchQueue.main.async {
            completion(self.diaryInfo)
        }
    }
    
    func updateValues(diaryInfo: DiaryInfo?) {
        self.currentDepth = diaryInfo?.depth
        self.dateLabel.text = diaryInfo?.date
        self.moodImage.image = diaryInfo?.mood.toWhiteIcon()
        self.moodLabel.text = diaryInfo?.mood.toString()
        self.depthLabel.text = diaryInfo?.depth.toString()
        self.sentenceLabel.text = diaryInfo?.sentence.sentence
        self.authorLabel.text = diaryInfo?.sentence.author
        self.bookTitleLabel.text = diaryInfo?.sentence.bookTitle
        self.authorLabel.text = diaryInfo?.sentence.author
        self.publisherLabel.text = diaryInfo?.sentence.publisher
        self.diaryLabel.text = diaryInfo?.diary
    }
    
    func attachMenuView() {
        if let menuView = self.menuView {
            self.addBlurEffectOnMenuView(view: menuView.menuContainerView)
            menuView.menuDelegate = self
            self.view.addSubview(menuView)
        }
    }
    
    func attachAlertModalView() {
        if let alertModalView = self.alertModalView {
            alertModalView.alertModalDelegate = self
            self.view.insertSubview(alertModalView, aboveSubview: self.view)
            alertModalView.setConstraints(view: alertModalView, superView: self.view)
        }
    }
    
    func addBlurEffectOnBlurView(view: UIView) {
        self.addBlurEffectOnView(view: view, cornerRadius: 17, blurStyle: UIBlurEffect.Style.light)
    }
    
    func addBlurEffectOnMenuView(view: UIView) {
        self.addBlurEffectOnView(view: view, cornerRadius: 16, blurStyle: UIBlurEffect.Style.systemThinMaterialLight)
    }
    
    func addBlurEffectOnView(view: UIView, cornerRadius: CGFloat?, blurStyle: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: blurStyle)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = cornerRadius ?? 0
        blurEffectView.clipsToBounds = true
        view.insertSubview(blurEffectView, at: 0)
    }
    
    func setBackgroundColorByDepth(depth: Depth?) {
        let gradientView = UIView(frame: self.view.frame)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = depth?.toGradientColor()
        gradientView.layer.addSublayer(gradientLayer)
        self.view.insertSubview(gradientView, at: 0)
    }
    
    @objc private func buttonPressed(sender: Any) {
        if let button = sender as? UIBarButtonItem {
            switch button.tag {
            case 1:
                if self.menuToggleFlag {
                    self.menuView?.removeFromSuperview()
                } else {
                    self.attachMenuView()
                }
                self.menuToggleFlag.toggle()
            default:
                print("error")
            }
        }
    }
    
}

// MARK: - MenuDelegate

extension DiaryViewController: MenuDelegate {
    
    func dateMenuButtonTouchUp(sender: UIButton) {
        print("날짜 수정 모달 팝업")
    }
    
    func depthMenuButtonTouchUp(sender: UIButton) {
        self.pushToDeepViewController()
    }
    
    func diaryMenuButtonTouchUp(sender: UIButton) {
        self.pushToDiaryWriteController()
    }
    
    func deleteMenubuttonTouchUp(sender: UIButton) {
        self.attachAlertModalView()
    }
    
    func pushToDeepViewController() {
        let onboardingStoryboard = UIStoryboard(name: Constants.Name.onboardingStoryboard, bundle: nil)
        guard let deepViewController = onboardingStoryboard.instantiateViewController(identifier: Constants.Identifier.deepViewController) as? DeepViewController else { return }
        
        deepViewController.initialDepth = self.currentDepth
        
        self.navigationController?.pushViewController(deepViewController, animated: true)
        
    }
    
    func pushToDiaryWriteController() {
        let diaryWriteStoryboard = UIStoryboard(name: Constants.Name.diaryWriteStoryboard, bundle: nil)
        guard let diaryWriteViewController = diaryWriteStoryboard.instantiateViewController(identifier: Constants.Identifier.diaryWriteViewController) as? DiaryWriteViewController else { return }
        
        self.diaryWriteViewController = diaryWriteViewController
        self.diaryWriteViewController?.diaryWriteViewControllerDelegate = self
        
        diaryWriteViewController.diaryInfo = self.diaryInfo
        diaryWriteViewController.isFromDiary = true
        
        self.navigationController?.pushViewController(diaryWriteViewController, animated: true)
        
    }
}

// MARK: - AlertModalDelegate

extension DiaryViewController: AlertModalDelegate {
    
    func leftButtonTouchUp(button: UIButton) {
        self.alertModalView?.removeFromSuperview()
        self.menuView?.removeFromSuperview()
    }
    
    func rightButtonTouchUp(button: UIButton) {
        
        self.postDeleteDiaryWithAPI(completion: {
            self.alertModalView?.removeFromSuperview()
            self.menuView?.removeFromSuperview()
        })
    }
    
    func postDeleteDiaryWithAPI(completion: @escaping () -> Void) {

        // TODO: - 삭제요청
        print("일기삭제")
        
        // TODO: - 삭제끝
        DispatchQueue.main.async {
            completion()
        }
    }
}

// MARK: - DiaryWriteViewControllerDelegate

extension DiaryViewController: DiaryWriteViewControllerDelegate {
    func popDiaryWirteViewController(data: DiaryInfo) {
        self.updateValues(diaryInfo: data)
        self.menuView?.removeFromSuperview()
    }
    
}
