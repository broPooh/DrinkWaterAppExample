//
//  ProfileViewController.swift
//  DrinkWaterAppExample
//
//  Created by bro on 2022/05/01.
//

import UIKit
import TextFieldEffects

class ProfileViewController: UIViewController {
    
    
    @IBOutlet var userProfileImageView: UIImageView!

    @IBOutlet var infoStackView: UIStackView!
    @IBOutlet var nickNameTextField: HoshiTextField!
    @IBOutlet var heightTextField: HoshiTextField!
    @IBOutlet var weightTextField: HoshiTextField!
    
    
    @IBOutlet var saveBtnItem: UIBarButtonItem!
    
    // backgroundColor
    let backgroundGreenColor: UIColor = UIColor(red: 0, green: 151/255, blue: 111/255, alpha: 1.0)
    
    
    let userDefault = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        initUIConfig()
        initInfo()
    }
    
    func initInfo() {
        let nickName = userDefault.string(forKey: "nickName") ?? ""
        let height = userDefault.string(forKey: "height") ?? ""
        let weight = userDefault.string(forKey: "weight") ?? ""
        
        nickNameTextField.text = nickName
        heightTextField.text = height
        weightTextField.text = weight
    }
    
    func initUIConfig() {
        setBackgroundColor()
        setNavigationConfig()
        setStackViewConfig(stackView: infoStackView)
        setInfoTextFieldConfig()
    }
    
    
    func setBackgroundColor() {
        view.backgroundColor = backgroundGreenColor
    }
    
    func setNavigationConfig() {
        //title 지정
        self.title = "프로필 설정"
        
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
    
    
    func setStackViewConfig(stackView : UIStackView) {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
    }
    
    func setInfoTextFieldConfig() {
        setHosiTextFieldConfig(hosiTextField: nickNameTextField, placeholder: "닉네임을 입력해주세요", keyboardType: .default)
        setHosiTextFieldConfig(hosiTextField: heightTextField, placeholder: "키(cm)를 설정해주세요", keyboardType: .decimalPad)
        setHosiTextFieldConfig(hosiTextField: weightTextField, placeholder: "몸무게(kg)를 설정해주세요", keyboardType: .decimalPad)
    }
    
    func setHosiTextFieldConfig(hosiTextField : HoshiTextField, placeholder : String, keyboardType : UIKeyboardType) {
        
        hosiTextField.placeholder = placeholder
        hosiTextField.placeholderFontScale = 0.8
        hosiTextField.placeholderColor = .white
        
        hosiTextField.borderActiveColor = UIColor(red: 255/255, green: 204/255, blue: 102/255, alpha: 1.0)
        hosiTextField.borderInactiveColor = .white
        
        hosiTextField.keyboardType = keyboardType
    }
    
    
    
    func showNumberCheckNotiAlert(title : String, message : String) {
        let numberAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        numberAlert.addAction(UIAlertAction(title: "예", style: .default, handler: nil))
        present(numberAlert, animated: true)
    }
    
    func checkStringToNumber(_ checkString : String) -> Bool {
        return Double(checkString) != nil && Double(checkString)! > 0.0 ? true : false
    }
    

    @IBAction func textFieldEditingDidEnd(_ sender: HoshiTextField) {
        if sender == heightTextField || sender == weightTextField {
            let userInputText = sender.text ?? ""
            if !checkStringToNumber(userInputText) {
                showCheckNotiAlert(title: "숫자를 입력하세요!", message: "키와 몸무게는 1이상의 숫자만 입력 가능합니다😱")
            }
            
        }
    }
    
    
    func showCheckNotiAlert(title : String, message : String) {
        let numberAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        numberAlert.addAction(UIAlertAction(title: "예", style: .default, handler: nil))
        present(numberAlert, animated: true)
    }
    
    
    @IBAction func saveBtnItemClicked(_ sender: UIBarButtonItem) {
        saveUserInfo()
        
    }
    
    func checkInputComplete() -> Bool {
        (nickNameTextField.text != nil && heightTextField.text != nil && weightTextField.text != nil && nickNameTextField.text != "" && checkStringToNumber(heightTextField.text ?? "") && checkStringToNumber(weightTextField.text ?? ""))
    }
    
    
    func saveUserInfo() {
        if !checkInputComplete() {showCheckNotiAlert(title: "입력 오류!", message: "입력하신 값을 재확인하세요"); return }
        
        let nickName = nickNameTextField.text!
        let height = Double(heightTextField.text!)!
        let weight = Double(weightTextField.text!)!
        let recommendAmount = Double(String(format: "%.1f", calculateRecommendAmout(height: height, weight: weight)))
        
        userDefault.set(nickName, forKey: "nickName")
        userDefault.set(height, forKey: "height")
        userDefault.set(weight, forKey: "weight")
        userDefault.set(recommendAmount, forKey: "recommendAmount")
        
        showCheckNotiAlert(title: "저장 성공!", message: "입력하신 정보를 저장하였습니다! 😆")
    }
    
    func calculateRecommendAmout(height : Double, weight : Double) -> Double {
        (height + weight) / 100
    }
}
