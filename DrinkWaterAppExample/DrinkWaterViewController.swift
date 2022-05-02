//
//  DrinkWaterViewController.swift
//  DrinkWaterAppExample
//
//  Created by bro on 2022/05/01.
//

import UIKit

enum PlantsImagePercent : Int {
    case ONE = 10
    case TWO = 20
    case THREE = 30
    case FOUR = 40
    case FIVE = 50
    case SIX = 60
    case SEVEN = 70
    case EIGHT = 80
    case NINE = 90
}

class DrinkWaterViewController: UIViewController {

    
    @IBOutlet var discriptLabel1: UILabel!
    @IBOutlet var discriptLabel2: UILabel!
    @IBOutlet var drinkenWaterLabel: UILabel!
    @IBOutlet var dayWaterPercentLabel: UILabel!

    @IBOutlet var plantsImageView: UIImageView!
    @IBOutlet var mlLabel: UILabel!
    
    @IBOutlet var recommandAmountLabel: UILabel!
    @IBOutlet var drinkBtn: UIButton!
    
    @IBOutlet var refreshBtnItem: UIBarButtonItem!
    @IBOutlet var infoBtnItem: UIBarButtonItem!
    
    @IBOutlet var inputStackView: UIStackView!
    @IBOutlet var drinkWaterTextFiel: UITextField!
    
    // backgroundColor
    let backgroundGreenColor: UIColor = UIColor(red: 0, green: 151/255, blue: 111/255, alpha: 1.0)
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUIConfig()
    }
    
    func initUIConfig() {
        setBackgroundColor()
        setNavigationConfig()
        setDiscriptLabelConfig()
        
        setRecommandLabelConfig()
        setBtnUIConfig()
    }
    
    func setBackgroundColor() {
        view.backgroundColor = backgroundGreenColor
    }
    
    func setNavigationConfig() {
        //title 지정
        self.title = "물 마시기"
        
        let appearance = UINavigationBarAppearance()
        let navigationBar = UINavigationBar()
        
        appearance.configureWithOpaqueBackground() //bar appearance객체에 현재 테마에 적절한 opaque color를 지정
        appearance.backgroundColor = backgroundGreenColor //백그라운드 색상 변경
        appearance.configureWithOpaqueBackground() // 투명제거
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] //title color 변경
        navigationBar.tintColor = UIColor.white //Bar Item color 변경
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
    
    func setDiscriptLabelConfig() {
        setLabelConfig(discriptLabel1, "잘하셨어요!", UIColor.white, .center, UIFont.systemFont(ofSize: 24, weight: .semibold))
        setLabelConfig(discriptLabel2, "오늘 마신 양은", UIColor.white, .center, UIFont.systemFont(ofSize: 24, weight: .regular))
        setLabelConfig(drinkenWaterLabel, "1200ml", UIColor.white, .center, UIFont.systemFont(ofSize: 32, weight: .bold))
        setLabelConfig(dayWaterPercentLabel, "목표의 30%", UIColor.white, .center, UIFont.systemFont(ofSize: 17, weight: .regular))
    }
    
    func setRecommandLabelConfig() {
        setLabelConfig(recommandAmountLabel, "안녕하세요님의 하루 물 권장 섭취량은 2.1L 입니다.", .white, .center, UIFont.systemFont(ofSize: 14))
    }
    
    func setBtnUIConfig() {
        setButtonConfig(drinkBtn, "물 마시기", .black, UIFont.systemFont(ofSize: 18, weight: .bold))
    }
    
    func setDrinkWaterTextLabelConfig() {
        setTextFieldConfig(drinkWaterTextFiel, .white, placeHolder: NSAttributedString(string: "200", attributes: [.foregroundColor : UIColor.lightGray]))
    }
    
    func setLabelConfig(_ label : UILabel, _ text : String, _ textColor : UIColor, _ textAlignment : NSTextAlignment,_ font : UIFont) {
        label.text = text
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.font = font
    }
    
    func setButtonConfig(_ button : UIButton, _ text : String, _ textColor : UIColor, _ font : UIFont) {
        
        button.setTitle(text, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = font
    }
    
    func setTextFieldConfig(_ textField : UITextField, _ textColor : UIColor, placeHolder : NSAttributedString) {
        textField.keyboardType = UIKeyboardType.numberPad
        textField.attributedPlaceholder = placeHolder
        textField.textColor = textColor
        
    }
    
    
    
    func showDrinkWaterAlert() {
        let drinkAlert = UIAlertController(title: "물 마시기💦", message: "마신 물 양을 입력해주세요!", preferredStyle: .alert)
        
        drinkAlert.addTextField { (textField) in
            textField.placeholder = "500"
            textField.keyboardType = UIKeyboardType.numberPad
        }
        
        let ok = UIAlertAction(title: "확인", style: .default) { action in
//            if let inputDrink = drinkAlert.textFields?.isEmpty {
//
//            }
        }
        
        drinkAlert.addAction(ok)
    }
    
    
    func changePlantsImage(_ percent : Int) {
        switch (percent) {
        case 0...PlantsImagePercent.ONE.rawValue : plantsImageView.image = UIImage(named: "one")
        case 11...PlantsImagePercent.TWO.rawValue : plantsImageView.image = UIImage(named: "two")
        case 21...PlantsImagePercent.THREE.rawValue : plantsImageView.image = UIImage(named: "three")
        case 31...PlantsImagePercent.FOUR.rawValue : plantsImageView.image = UIImage(named: "four")
        case 41...PlantsImagePercent.FIVE.rawValue : plantsImageView.image = UIImage(named: "five")
        case 51...PlantsImagePercent.SIX.rawValue : plantsImageView.image = UIImage(named: "six")
        case 61...PlantsImagePercent.SEVEN.rawValue : plantsImageView.image = UIImage(named: "seven")
        case 71...PlantsImagePercent.EIGHT.rawValue : plantsImageView.image = UIImage(named: "eight")
        case 81...100 : plantsImageView.image = UIImage(named: "nine")
        case _ where percent > 100 : plantsImageView.image = UIImage(named: "nine")
        default:
            plantsImageView.image = UIImage(named: "nine")
        }
    }
    
    
    func changePlantsImageFromPercent(_ percent : Int) {
        
    }
        

}
