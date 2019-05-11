//
//  ViewController.swift
//  Calculator
//
//  Created by 조서현 on 2019. 1. 6..
//  Copyright © 2019년 조서현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var oldNum: String = ""
    var newNum: String = ""
    var result:String = "0"
    var Operator:String = ""
    var Decimal:Int = 0
    var oldDecimal:Int = 0
    var opclear:Bool = false
    var cnt:Int = 0
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var ClearBtn: UIButton!
    @IBOutlet weak var NegativeBtn: UIButton!
    @IBOutlet weak var PercentBtn: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var DecBtn: UIButton!
    @IBOutlet weak var resultBtn: UIButton!
    @IBOutlet weak var PlusBtn: UIButton!
    @IBOutlet weak var MinusBtn: UIButton!
    @IBOutlet weak var MulBtn: UIButton!
    @IBOutlet weak var DivBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRoundUI()
    }
    
    
    func setupRoundUI() {
        resultLabel.text = "0"
        
        ClearBtn.layer.cornerRadius = ClearBtn.frame.width / 2
        
        btn0.layer.cornerRadius = 40
        btn1.layer.cornerRadius = btn1.frame.width / 2
        btn2.layer.cornerRadius = btn2.frame.width / 2
        btn3.layer.cornerRadius = btn3.frame.width / 2
        btn4.layer.cornerRadius = btn4.frame.width / 2
        btn5.layer.cornerRadius = btn5.frame.width / 2
        btn6.layer.cornerRadius = btn6.frame.width / 2
        btn7.layer.cornerRadius = btn7.frame.width / 2
        btn8.layer.cornerRadius = btn8.frame.width / 2
        btn9.layer.cornerRadius = btn9.frame.width / 2
        DecBtn.layer.cornerRadius = DecBtn.frame.width / 2
        resultBtn.layer.cornerRadius = resultBtn.frame.width / 2
        PlusBtn.layer.cornerRadius = PlusBtn.frame.width / 2
        MinusBtn.layer.cornerRadius = MinusBtn.frame.width / 2
        MulBtn.layer.cornerRadius = MulBtn.frame.width / 2
        DivBtn.layer.cornerRadius = DivBtn.frame.width / 2
        NegativeBtn.layer.cornerRadius = NegativeBtn.frame.width / 2
        PercentBtn.layer.cornerRadius = PercentBtn.frame.width / 2
    }
    
    //상태바 색상 밝게
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    //AC버튼 클릭 시 초기화
    @IBAction func Clear(_ sender: Any) {
        ClearBtn.titleLabel?.text = "AC"
        result = "0"
        resultLabel.text = result
        newNum = ""
        Operator = ""
        Decimal = 0
        cnt = 0
    }
    
    
    //숫자, 소수점 클릭
    @IBAction func NumClick(_ btn: UIButton) {
        
        //소수점 클릭하지 않았고 시작수가 0일때
        if resultLabel.text == "0" && btn.tag == 0 {
            if btn.titleLabel?.text != "0" {
                result = (btn.titleLabel?.text)!
                ClearBtn.titleLabel?.text = " C" //AC를 C로 바꿔줌
                //0으로 시작할 때 0을 눌렀을 경우와 AC 버튼을 클릭했을 경우만 AC로 유지, 변경해줌
            }
        }
        else { //소수점 누르면 시작숫자가 0이더라도 뒤에 이어붙여지게 되므로 따로 처리가 필요
                if btn.tag == 1 && Decimal == 0 { //소수점 누를 때 한번에 두개의 점이 들어갈 수 없음
                    Decimal = 1
                    if opclear == true { //연산자 클릭 후, 숫자가 이어지지 않고 한번 초기화하는 과정이 필요
                        result = (btn.titleLabel?.text)!
                        opclear = false
                    } else { result += (btn.titleLabel!.text)! }
                }
                else if btn.tag == 0 { //시작수가 0이 아니며, 일반 숫자를 눌렀을 때
                    if opclear == true {
                        result = (btn.titleLabel?.text)!
                        opclear = false
                    } else { result += (btn.titleLabel!.text)! }
                }
            }
        resultLabel.text = result
    }
    
    //음수,양수 버튼 클릭
    @IBAction func NagativeClick(_ sender: Any) {
        
        if (resultLabel.text?.contains("."))! { //소수점의 포함 여부를 확인한 후 정수형과 실수형으로 나눠서 계산해 넣어줌
            if resultLabel.text != "0" {
                resultLabel.text = String(Double(resultLabel.text!)! * -1)
            }
        } else {
            if resultLabel.text != "0" {
                resultLabel.text = String(Int(resultLabel.text!)! * -1)
            }
        }
    }
    
    //퍼센트 버튼 클릭
    @IBAction func Percent(_ sender: Any) {
        if resultLabel.text != "0" {
            resultLabel.text = String(Double(resultLabel.text!)! * 0.01)
            
        }
    }
    
    //나누기 버튼 클릭
    @IBAction func DivClick(_ sender: Any) {
        
        if cnt == 0 {
            Operator = "/"
            Decimal = 0
            oldNum = resultLabel.text!
        } else {
            oldNum = Cal() //연산 후 결과값을 oldNum에 담아줌
        }
        opclear = true
    }
    
    //곱하기 버튼 클릭
    @IBAction func MulClick(_ sender: Any) {
        if cnt == 0 {
            Operator = "*"
            Decimal = 0
            oldNum = resultLabel.text!
        } else {
            oldNum = Cal() //연산 후 결과값을 oldNum에 담아줌
        }
        opclear = true
    }
    
    //뺴기 버튼 클릭
    @IBAction func MinusClick(_ sender: Any) {
        if cnt == 0 {
            Operator = "-"
            Decimal = 0
            oldNum = resultLabel.text!
        } else {
            oldNum = Cal() //연산 후 결과값을 oldNum에 담아줌
        }
        opclear = true
    }
    
    //더하기 버튼 클릭
    @IBAction func PlusClick(_ sender: Any) {
        //처음 + 를 클릭했을경우 = 을 누르기 전까지 결과를 표시해주지 않아도 됨
        //하지만 + 를 두번이상 클릭하게되면 = 을 누르지 않더라도 연산결과를 화면에 표시해 주어야한다.
        if cnt == 0 {
        Operator = "+"
        Decimal = 0
        oldNum = resultLabel.text!
        } else {
            oldNum = Cal() //연산 후 결과값을 oldNum에 담아줌
        }
        opclear = true
        
    }
    
    //결과 버튼 클릭
    @IBAction func resultClick(_ sender: Any) {
        oldNum = Cal()
        cnt = 0 // = 버튼을 눌렀으므로 카운트 초기화
    }
    
    //연산 함수,, 매개변수 없이 전역변수의 값을 가져와 계산하고 결과값을 String으로 반환
    func Cal() -> String {
        var resultNum:Double = 0
        
        //새로 클릭한 수 담아줌
        newNum = resultLabel.text!
        //연산에 필요한 수가 소수인지 판별
        let newdec = newNum.contains(".")
        let olddec = oldNum.contains(".")
        
        //수 연산
        switch Operator { //연산자 종류에 따른 연산. Double로 게산
        case "+":
            resultNum = Double(oldNum)! + Double(newNum)!
        case "-":
            resultNum = Double(oldNum)! - Double(newNum)!
        case "*":
            resultNum = Double(oldNum)! * Double(newNum)!
        case "/":
            resultNum = Double(oldNum)! / Double(newNum)!
        default:
            break
        }
        
        //소수가 하나라도 있으면 Double로 결과출력, 둘다 정수일때만 Int출력
        if olddec != true && newdec != true{
            resultLabel.text = String(Int(resultNum))
        }
        else {
            resultLabel.text = String(resultNum)
        }
        Decimal = 0
        //+ 등 연산자로 계산할 경우도 있으므로 cnt++
        cnt += 1
        return String(resultNum)
    }
    
    
    
    
    
    //AC, +/-, % 버튼 클릭 시 색변경
    
    //버튼 누를때
    @IBAction func btnTouchDown(_ btn: UIButton) {
        if btn.tag == 2 { //AC~~
                btn.backgroundColor = UIColor(red:217/255, green:216/255, blue:217/255, alpha:1)
        } else if btn.tag == 3{ // +~~
            btn.backgroundColor = UIColor(red:251/255, green:198/255, blue:145/255, alpha:1)
        } else if btn.tag == 0 || btn.tag == 1{ // 0~~
            btn.backgroundColor = UIColor(red:115/255, green:115/255, blue:115/255, alpha:1)
        }
    }
    
    //버튼 손뗏을때
    @IBAction func btnTouchUpInside(_ btn: UIButton) {
        if btn.tag == 2 { //AC~~
                btn.backgroundColor = UIColor(red:166/255, green:165/255, blue:166/255, alpha:1)
        } else if btn.tag == 3{ // +~~
            btn.backgroundColor = UIColor(red:253/255, green:148/255, blue:38/255, alpha:1)
        } else if btn.tag == 0 || btn.tag == 1{ // 0~~
            btn.backgroundColor = UIColor(red:51/255, green:51/255, blue:51/255, alpha:1)
        }
    }
    
    
    
    
    
}

