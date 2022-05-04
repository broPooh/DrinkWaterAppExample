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

    
    //description이다
    @IBOutlet var descriptLabel1: UILabel!
    @IBOutlet var descriptLabel2: UILabel!
    @IBOutlet var drinkenWaterLabel: UILabel!
    @IBOutlet var dayWaterPercentLabel: UILabel!

    //Interface Builder
    //@ 어노테이션Annotation
    @IBOutlet var plantsImageView: UIImageView!
    @IBOutlet var mlLabel: UILabel!
    
    @IBOutlet var recommandAmountLabel: UILabel!
    @IBOutlet var drinkBtn: UIButton!
    
    @IBOutlet var refreshBtnItem: UIBarButtonItem!
    @IBOutlet var infoBtnItem: UIBarButtonItem!
    
    @IBOutlet var inputStackView: UIStackView!
    @IBOutlet var drinkWaterTextField: UITextField!
    
    // backgroundColor
    // 명시할 때는 Type Annotation
    // 축약이 가능한 이유 타입 추론
    let backgroundGreenColor = UIColor(red: 0, green: 151/255, blue: 111/255, alpha: 1.0)
    let userDefault = UserDefaults.standard
    let dateToStringFormat = DateFormatter()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkTodayStart()
        updateDrinkState()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        updateDrinkState()
        dateToStringFormat.dateFormat = "yyyy:MM:dd"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        saveLastTime()
    }
    
    func configureView() {
        setBackgroundColor()
        setNavigationConfig()
        setDiscriptLabelConfig()
        setDrinkWaterTextLabelConfig()
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
        setLabelConfig(descriptLabel1, "잘하셨어요!", UIColor.white, .center, UIFont.systemFont(ofSize: 24, weight: .semibold))
        setLabelConfig(descriptLabel2, "오늘 마신 양은", UIColor.white, .center, UIFont.systemFont(ofSize: 24, weight: .regular))
        setLabelConfig(drinkenWaterLabel, "1200ml", UIColor.white, .center, UIFont.systemFont(ofSize: 32, weight: .bold))
        setLabelConfig(dayWaterPercentLabel, "목표의 30%", UIColor.white, .center, UIFont.systemFont(ofSize: 17, weight: .regular))
    }
    
    func setRecommandLabelConfig() {
        setLabelConfig(recommandAmountLabel, "안녕하세요님의 하루 물 권장 섭취량은 2.1L 입니다.", .white, .center, UIFont.systemFont(ofSize: 14))
    }
    
    func setBtnUIConfig() {
        
        setButtonConfig(drinkBtn, "물 마시기💦", .black, UIFont.systemFont(ofSize: 18, weight: .bold))
    }
    
    func setDrinkWaterTextLabelConfig() {
        setTextFieldConfig(drinkWaterTextField, .white, placeHolder: NSAttributedString(string: "200", attributes: [.foregroundColor: UIColor.lightGray]))
    }
    //매개변수, return, 가변 매개변수.
    func setLabelConfig(_ label : UILabel, _ text : String, _ textColor : UIColor, _ textAlignment : NSTextAlignment,_ font : UIFont) {
        label.text = text
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.font = font
    }
    
    func setButtonConfig(_ button: UIButton, _ text : String, _ textColor : UIColor, _ font : UIFont) {
        button.setTitle(text, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = font
    }
    
    func setTextFieldConfig(_ textField: UITextField, _ textColor : UIColor, placeHolder : NSAttributedString) {
        textField.keyboardType = UIKeyboardType.numberPad
        textField.attributedPlaceholder = placeHolder
        textField.textColor = textColor
    }
    
    
    
//    func showDrinkWaterAlert() {
//        let drinkAlert = UIAlertController(title: "물 마시기💦", message: "마신 물 양을 입력해주세요!", preferredStyle: .alert)
//
//        drinkAlert.addTextField { (textField) in
//            textField.placeholder = "500"
//            textField.keyboardType = UIKeyboardType.numberPad
//        }
//
//        let ok = UIAlertAction(title: "확인", style: .default) { action in
////            if let inputDrink = drinkAlert.textFields?.isEmpty {
////
////            }
//        }
//
//        drinkAlert.addAction(ok)
//    }
//
//
//    func changePlantsImage(_ percent : Int) {
//        switch (percent) {
//        case 0...PlantsImagePercent.ONE.rawValue : plantsImageView.image = UIImage(named: "one")
//        case 11...PlantsImagePercent.TWO.rawValue : plantsImageView.image = UIImage(named: "two")
//        case 21...PlantsImagePercent.THREE.rawValue : plantsImageView.image = UIImage(named: "three")
//        case 31...PlantsImagePercent.FOUR.rawValue : plantsImageView.image = UIImage(named: "four")
//        case 41...PlantsImagePercent.FIVE.rawValue : plantsImageView.image = UIImage(named: "five")
//        case 51...PlantsImagePercent.SIX.rawValue : plantsImageView.image = UIImage(named: "six")
//        case 61...PlantsImagePercent.SEVEN.rawValue : plantsImageView.image = UIImage(named: "seven")
//        case 71...PlantsImagePercent.EIGHT.rawValue : plantsImageView.image = UIImage(named: "eight")
//        case 81...100 : plantsImageView.image = UIImage(named: "nine")
//        case _ where percent > 100 : plantsImageView.image = UIImage(named: "nine")
//        default:
//            plantsImageView.image = UIImage(named: "nine")
//        }
//    }
    
    func changePlantsImageFromPercent(_ percent : Int) {
        let plantsLevel = percent >= 100 ? 9 : (percent / 10 <= 1 ? 1 : percent / 10)
        plantsImageView.image = UIImage(named: "1-\(plantsLevel)")
    }
    
    func calculateDrinkPerecent(_ drinkenWater: Int?, _ recommendAmount: Double?) -> Int {
        if (drinkenWater == nil || recommendAmount == nil || drinkenWater == 0 || recommendAmount == 0.0) { return 0 }
        return Int(Double(drinkenWater!) / (recommendAmount! * 1000) * 100)
    }
    
    func updateDrinkState() {
        let nickName = userDefault.string(forKey: "nickName") ?? "닉네임"
        let drinkenWater = userDefault.integer(forKey: "drinkenWater")
        let recommendAmount = userDefault.double(forKey: "recommendAmount")
        let percent = calculateDrinkPerecent(drinkenWater, recommendAmount)
        
        drinkenWaterLabel.text = "\(drinkenWater)ml"
        dayWaterPercentLabel.text = "목표의 \(percent)%"
        changePlantsImageFromPercent(percent)
        recommandAmountLabel.text = "\(nickName)님의 하루 물 권장 섭취량은 \(recommendAmount)입니다"
    }

    //Any로 연결 후 UIBarButtonItem으로 변경했을때 해보고
    //UIBarButtonItem으로 연결후 Any로 바꿨을때 어떤일이 일어나는지?
    @IBAction func refreshItemClicked(_ button: UIBarButtonItem) {
        showRefreshCheckAlert("Data Reset", "데이터를 초기화하시겠습니까?")
    }
    
    
    func showRefreshCheckAlert(_ title: String, _ message: String) {
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        refreshAlert.addAction(UIAlertAction(title: "예", style: .default, handler: { (action) in
            self.userDefault.removeObject(forKey: "drinkenWater")
            self.updateDrinkState()
        }))
        refreshAlert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(refreshAlert, animated: true)
    }
    
    func checkStringToNumber(_ checkString : String) -> Bool {
         Int(checkString) != nil && Int(checkString)! > 0 ? true : false
    }
    
    //Return 생략가능 swift 5.1버전?
    func checkInputUserInfo() -> Bool {
        (userDefault.string(forKey: "nickName") != nil && userDefault.integer(forKey: "height") != 0 && userDefault.integer(forKey: "weight") != 0 && userDefault.double(forKey: "recommendAmount") != 0.0)
    }
    
        
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        if !checkStringToNumber(drinkWaterTextField.text ?? "") {showCheckNotiAlert(title: "숫자를 입력하세요!", message: "마신 물의 양은 숫자만 입력 가능합니다!😱"); return}
        
        if !checkInputUserInfo() { showCheckNotiInfoAlert(title: "정보 입력!", message: "권장량 계산을 위해 정보부터 입력해주세요!"); return}
        
        let userInputDrink = Int(drinkWaterTextField.text!)!
        let drinkenWater = userDefault.integer(forKey: "drinkenWater")
        
        let finalDrinkenWater = drinkenWater + userInputDrink
        
        userDefault.set(finalDrinkenWater, forKey: "drinkenWater")
    
        showCheckNotiAlert(title: "물 마시기💦", message: "\(userInputDrink)ml의 물을 마셨어요!💧")
        updateDrinkState()
    }
    
    func showCheckNotiAlert(title : String, message : String) {
        let numberAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        numberAlert.addAction(UIAlertAction(title: "예", style: .default, handler: nil))
        present(numberAlert, animated: true)
    }
    
    func showCheckNotiInfoAlert(title : String, message : String) {
        let numberAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        numberAlert.addAction(UIAlertAction(title: "예", style: .default, handler: { (action) in
            
            let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController")
            
            self.navigationController?.pushViewController(profileViewController!, animated: true)
        }))
        present(numberAlert, animated: true)
    }
    
    //마지막 시간을 저장
    func saveLastTime() {
        //let now = dateToStringFormat.string(from: Date())
        //let now = Date().dateToString()
        //let finalTime = UserDefaults.standard.string(forKey: "finalTime") ?? now
        let now = Date()
        let finalTime = UserDefaults.standard.string(forKey: "finalTime")?.stringToDate() ?? now
        
        
        if now > finalTime { UserDefaults.standard.set(now.dateToString(), forKey: "finalTime") }
    }
    
    
    func checkTodayStart() {
        
        
        let now = Date().dateToString()
        let finalTime = UserDefaults.standard.string(forKey: "finalTime") ?? now
        
        let nowToDate = now.stringToDate()!
        let finalTimeToDate = finalTime.stringToDate()!
        
        if nowToDate > finalTimeToDate {
            userDefault.removeObject(forKey: "drinkenWater")
        }
    }
    
    @IBAction func drinkTextFieldEditBeginning(_ sender: UITextField) {
        let position = sender.endOfDocument
        sender.selectedTextRange = sender.textRange(from:position, to:position)
    }
}


extension String {
    func stringToDate() -> Date? {
        let dateToStringFormat = DateFormatter()
        dateToStringFormat.dateFormat = "yyyy:MM:dd"
        return dateToStringFormat.date(from: self)
    }
}

extension Date {
    
    func dateToString() -> String {
        let dateToStringFormat = DateFormatter()
        dateToStringFormat.dateFormat = "yyyy:MM:dd"
        return dateToStringFormat.string(from: self)
    }
}

//열거형과 스트럭트를
//값이 변경될 여지가 없다.
//데이터 타입을 명시하지 않으면, 케이스가 rawValue가 된다.
enum UserDefaultsKey: String {
    case nickname
}

//스트럭트로 하면 인스턴스를 만들 수 있지만, 우리는 인스턴스를 만들 필요가 없다.
//불필요하게 인스턴스를 생성하면 값이 변경될 여지가 있다
struct UDKey {
    let nickname = "nickname"
}
