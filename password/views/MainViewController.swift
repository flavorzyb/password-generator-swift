//
//  MainViewController.swift
//  password
//
//  Created by 朱彦斌 on 2019/3/10.
//  Copyright © 2019 朱彦斌. All rights reserved.
//

import Cocoa
import SnapKit

class MainViewController: NSViewController {
    private var boxPasswordOptions: NSBox!
    private var cbUpperCharacter: NSButton!
    private var cbLowerCharacter: NSButton!
    private var cbNumberCharacter: NSButton!
    private var cbSpecialCharacter: NSButton!
    private var slPasswordLength: NSSlider!
    private var scStepper: NSStepper!
    private var tfPasswordLengthValue: NSTextField!
    
    private var boxResult: NSBox!
    private var tfPassword: NSTextField!
    private var btnCopy: NSButton!
    
    private var boxOperator: NSBox!
    private var btnGenerator: NSButton!
    private var btnExit: NSButton!
    
    private let boxSpace = 60
    // 在密码中每个字符允许出现的最大次数
    private let maxTimes = 3
    private let minLength: Double = 6
    private let defaultLength: Int32 = 32
    private let maxLength: Double = 50
    private let minType = 2
    
    override func loadView() {
        let view = NSView(frame: AppConfig.windowRect)
        view.wantsLayer = true
        self.view = view
        
        initPasswordOptionPanel()
        initResultPanel()
        initOperatorPanel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addEvents()
    }
    
    override func viewWillDisappear() {
        removeEvents()
        super.viewWillDisappear()
    }
    
    private func initPasswordOptionPanel() {
        boxPasswordOptions = NSBox()
        boxPasswordOptions.title = NSLocalizedString("PasswordOptions", comment: "")
        boxPasswordOptions.titleFont = NSFont.mainBoldFont(size: 16)
        view.addSubview(boxPasswordOptions)
        
        let tfUsedCharacter = NSTextField(string: NSLocalizedString("UsedCharacters", comment: ""))
        tfUsedCharacter.isEditable = false
        tfUsedCharacter.isSelectable = false
        tfUsedCharacter.isBordered = false
        tfUsedCharacter.drawsBackground = false
        tfUsedCharacter.font = NSFont.mainFont(size: 14)
        boxPasswordOptions.addSubview(tfUsedCharacter)
        tfUsedCharacter.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(40)
        }
        
        let spaceSize = 80
        
        cbUpperCharacter = NSButton()
        cbUpperCharacter.title = "A-Z"
        cbUpperCharacter.font = NSFont.mainFont(size: 14)
        cbUpperCharacter.setButtonType(.switch)
        cbUpperCharacter.state = .on
        boxPasswordOptions.addSubview(cbUpperCharacter)
        
        cbUpperCharacter.snp.makeConstraints { make in
            make.left.equalTo(tfUsedCharacter.snp.right).offset(30)
            make.centerY.equalTo(tfUsedCharacter)
        }
        
        cbLowerCharacter = NSButton()
        cbLowerCharacter.title = "a-z"
        cbLowerCharacter.font = NSFont.mainFont(size: 14)
        cbLowerCharacter.setButtonType(.switch)
        cbLowerCharacter.state = .on
        boxPasswordOptions.addSubview(cbLowerCharacter)
        
        cbLowerCharacter.snp.makeConstraints { make in
            make.left.equalTo(cbUpperCharacter.snp.right).offset(spaceSize)
            make.centerY.equalTo(cbUpperCharacter)
        }
        
        cbNumberCharacter = NSButton()
        cbNumberCharacter.title = "0-9"
        cbNumberCharacter.font = NSFont.mainFont(size: 14)
        cbNumberCharacter.setButtonType(.switch)
        cbNumberCharacter.state = .on
        boxPasswordOptions.addSubview(cbNumberCharacter)
        
        cbNumberCharacter.snp.makeConstraints { make in
            make.left.equalTo(cbLowerCharacter.snp.right).offset(spaceSize)
            make.centerY.equalTo(cbLowerCharacter)
        }
        
        cbSpecialCharacter = NSButton()
        cbSpecialCharacter.title = "!@#$%^&*"
        cbSpecialCharacter.font = NSFont.mainFont(size: 14)
        cbSpecialCharacter.setButtonType(.switch)
        cbSpecialCharacter.state = .off
        boxPasswordOptions.addSubview(cbSpecialCharacter)
        
        cbSpecialCharacter.snp.makeConstraints { make in
            make.left.equalTo(cbNumberCharacter.snp.right).offset(spaceSize)
            make.centerY.equalTo(cbNumberCharacter)
        }
        
        let tfPasswordLength = NSTextField(string: NSLocalizedString("PasswordLength", comment: ""))
        tfPasswordLength.isEditable = false
        tfPasswordLength.isSelectable = false
        tfPasswordLength.isBordered = false
        tfPasswordLength.drawsBackground = false
        tfPasswordLength.font = NSFont.mainFont(size: 14)
        boxPasswordOptions.addSubview(tfPasswordLength)
        tfPasswordLength.snp.makeConstraints { make in
            make.left.equalTo(tfUsedCharacter)
            make.top.equalTo(tfUsedCharacter.snp.bottom).offset(30)
        }
        
        tfPasswordLengthValue = NSTextField(string: "\(defaultLength)")
        tfPasswordLengthValue.isEditable = false
        tfPasswordLengthValue.isSelectable = false
        tfPasswordLengthValue.isBordered = true
        tfPasswordLengthValue.font = NSFont.mainFont(size: 14)
        boxPasswordOptions.addSubview(tfPasswordLengthValue)
        tfPasswordLengthValue.snp.makeConstraints { make in
            make.left.equalTo(cbUpperCharacter)
            make.width.equalTo(70)
            make.centerY.equalTo(tfPasswordLength)
        }
        
        scStepper = NSStepper()
        scStepper.minValue = minLength
        scStepper.autorepeat = false
        scStepper.valueWraps = false
        scStepper.increment = 1
        scStepper.maxValue = maxLength
        scStepper.intValue = defaultLength
        boxPasswordOptions.addSubview(scStepper)
        
        scStepper.snp.makeConstraints { make in
            make.left.equalTo(tfPasswordLengthValue.snp.right).offset(10)
            make.centerY.equalTo(tfPasswordLengthValue)
        }
        
        slPasswordLength = NSSlider()
        slPasswordLength.sliderType = .linear
        slPasswordLength.numberOfTickMarks = 25
        slPasswordLength.tickMarkPosition = .below
        slPasswordLength.minValue = minLength
        slPasswordLength.maxValue = maxLength
        slPasswordLength.intValue = defaultLength
        slPasswordLength.isContinuous = true
        
        boxPasswordOptions.addSubview(slPasswordLength)
        slPasswordLength.snp.makeConstraints { make in
            make.left.equalTo(cbLowerCharacter)
            make.centerY.equalTo(scStepper)
            make.width.equalTo(300)
        }
        
        boxPasswordOptions.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(boxSpace - 20)
            make.centerX.equalToSuperview()
            make.width.equalTo(750)
            make.bottom.equalTo(tfPasswordLength).offset(40)
        }
    }
    
    private func initResultPanel() {
        boxResult = NSBox()
        boxResult.title = NSLocalizedString("Result", comment: "")
        boxResult.titleFont = NSFont.mainBoldFont(size: 16)
        view.addSubview(boxResult)
        
        let tfGenerateResult = NSTextField(string: NSLocalizedString("GenerateResult", comment: ""))
        tfGenerateResult.isEditable = false
        tfGenerateResult.isSelectable = false
        tfGenerateResult.isBordered = false
        tfGenerateResult.drawsBackground = false
        tfGenerateResult.font = NSFont.mainFont(size: 14)
        boxResult.addSubview(tfGenerateResult)
        tfGenerateResult.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(40)
        }
        
        tfPassword = NSTextField(string: NSLocalizedString("GeneratorTips", comment: ""))
        tfPassword.isEditable = false
        tfPassword.isSelectable = false
        tfPassword.font = NSFont.mainFont(size: 14)
        tfPassword.textColor = NSColor.gray
        boxResult.addSubview(tfPassword)
        tfPassword.snp.makeConstraints { make in
            make.left.equalTo(tfGenerateResult.snp.right).offset(20)
            make.centerY.equalTo(tfGenerateResult)
            make.width.equalTo(480)
        }
        
        btnCopy = createButton(title: NSLocalizedString("CopyPassword", comment: ""))
        btnCopy.isEnabled = false
        boxResult.addSubview(btnCopy)
        
        btnCopy.snp.makeConstraints { make in
            make.left.equalTo(tfPassword.snp.right).offset(20)
            make.width.equalTo(100)
            make.centerY.equalTo(tfPassword)
        }
        
        boxResult.snp.makeConstraints { make in
            make.top.equalTo(boxPasswordOptions.snp.bottom).offset(boxSpace)
            make.centerX.equalToSuperview()
            make.width.equalTo(750)
            make.bottom.equalTo(btnCopy).offset(30)
        }
    }
    
    private func initOperatorPanel() {
        boxOperator = NSBox()
        boxOperator.title = NSLocalizedString("OperatorOptions", comment: "")
        boxOperator.titleFont = NSFont.mainBoldFont(size: 16)
        view.addSubview(boxOperator)
        
        btnGenerator = createButton(title: NSLocalizedString("GeneratorPassword", comment: ""))
        boxOperator.addSubview(btnGenerator)
        
        btnGenerator.snp.makeConstraints { make in
            make.left.equalTo(tfPassword)
            make.top.equalToSuperview().offset(40)
        }
        
        btnExit = createButton(title: NSLocalizedString("ExitProgram", comment: ""))
        boxOperator.addSubview(btnExit)
        
        btnExit.snp.makeConstraints { make in
            make.right.equalTo(tfPassword)
            make.width.equalTo(btnGenerator)
            make.centerY.equalTo(btnGenerator)
        }
        
        boxOperator.snp.makeConstraints { make in
            make.top.equalTo(boxResult.snp.bottom).offset(boxSpace)
            make.centerX.equalToSuperview()
            make.width.equalTo(750)
            make.bottom.equalTo(btnGenerator).offset(30)
        }
    }
    
    private func createButton(title: String) -> NSButton {
        let result = NSButton()
        result.title = title
        result.font = NSFont.mainFont(size: 14)
        result.setButtonType(.momentaryPushIn)
        result.isBordered = true
        result.bezelStyle = .rounded
        result.translatesAutoresizingMaskIntoConstraints = false
        
        return result
    }
    
    private func addEvents() {
        slPasswordLength.target = self
        slPasswordLength.action = #selector(onChangedPasswordLength(sender:))
        
        scStepper.target = self
        scStepper.action = #selector(onChangeStepper(sender:))
        
        btnGenerator.target = self
        btnGenerator.action = #selector(onClickBtnGenerator(sender:))
        
        btnExit.target = self
        btnExit.action = #selector(onClickBtnExit(sender:))
    }
    
    private func removeEvents() {
        slPasswordLength.target = nil
        slPasswordLength.action = nil
        
        scStepper.target = nil
        scStepper.action = nil
        
        btnGenerator.target = nil
        btnGenerator.action = nil
        
        btnExit.target = nil
        btnGenerator.action = nil
    }
    
    @objc private func onChangedPasswordLength(sender: NSSlider) {
        tfPasswordLengthValue.stringValue = "\(sender.integerValue)"
        scStepper.intValue = sender.intValue
    }
    
    @objc private func onChangeStepper(sender: NSStepper) {
        tfPasswordLengthValue.stringValue = "\(sender.integerValue)"
        slPasswordLength.intValue = sender.intValue
    }
    
    @objc private func onClickBtnGenerator(sender: NSButton) {
        btnCopy.isEnabled = false
        tfPassword.isEnabled = false
        
        if !isEnableGenerator() {
            let alert = NSAlert()
            alert.messageText = NSLocalizedString("ErrorTitle", comment: "")
            alert.informativeText = NSLocalizedString("ErrorPasswordType", comment: "")
            alert.alertStyle = .critical
            alert.addButton(withTitle: NSLocalizedString("OK", comment: ""))
            alert.runModal()
            return
        }
        
        btnCopy.isEnabled = true
        tfPassword.isEnabled = true
        tfPassword.textColor = NSColor.black
        tfPassword.stringValue = generatorPassword()
    }
    
    @objc private func onClickBtnExit(sender: NSButton) {
        AppFacade.getInstance().sendNotification(NotificationName.S_MEDIATOR_MAIN_WINDOW_EXIT)
    }
    
    private func isEnableGenerator() -> Bool {
        var passwordType = 0
        let stateList = [
            cbUpperCharacter.state,
            cbLowerCharacter.state,
            cbNumberCharacter.state,
            cbSpecialCharacter.state,
        ]
        
        for state: NSControl.StateValue  in stateList {
            if state == .on {
                passwordType = passwordType + 1
            }
        }
        
        return passwordType >= minType
    }
    
    /**
     * 生成密码的可选字符集
     */
    private func buildPasswordSlate() -> [String] {
        var result: [String] = []
        if cbUpperCharacter.state == .on {
            result.append(contentsOf: appendString(from: "A", to: "Z"))
        }
        
        if cbLowerCharacter.state == .on {
            result.append(contentsOf: appendString(from: "a", to: "z"))
        }
        
        if cbNumberCharacter.state == .on {
            result.append(contentsOf: appendString(from: "0", to: "9"))
        }
        
        if cbSpecialCharacter.state == .on {
            result.append(contentsOf: ["!", "@", "#", "$", "%", "^", "&", "*"])
        }
        
        return result
    }
    
    /**
     * 密码中至少包含下列字符
     * 从每种字符集中取出至少3个 即: minLength / maxType = 6 / 4 = 2
     */
    private func generatorBasePassword() -> [String] {
        var result: [String] = []
        if cbUpperCharacter.state == .on {
            let data = appendString(from: "A", to: "Z")
            result.append(contentsOf: randomString(data: data, len: 2))
        }
        
        if cbLowerCharacter.state == .on {
            let data = appendString(from: "a", to: "z")
            result.append(contentsOf: randomString(data: data, len: 2))
        }
        
        if cbNumberCharacter.state == .on {
            let data = appendString(from: "0", to: "9")
            result.append(contentsOf: randomString(data: data, len: 2))
        }
        
        if cbSpecialCharacter.state == .on {
            let data = ["!", "@", "#", "$", "%", "^", "&", "*"]
            result.append(contentsOf: randomString(data: data, len: 2))
        }
        
        return result
    }
    
    private func randomString(data: [String], len: Int) -> [String] {
        var result: [String] = []
        let count = UInt32(data.count)
        
        while result.count < len {
            let index = arc4random() % count
            let value = data[Int(index)]
            if !result.contains(value) {
                result.append(value)
            }
        }
        
        return result
    }
    
    private func generatorPassword() -> String {
        let length = slPasswordLength.intValue
        var source = buildPasswordSlate()
        var data: [String] = generatorBasePassword()

        let count = UInt32(source.count)
        while data.count < length {
            let index = arc4random() % count
            let value = source[Int(index)]
            if !isMoreThanMaxTimes(value: value, data: data) {
                data.append(value)
            }
        }
        
        var result = ""
        data = data.shuffled()
        for str: String in data {
            if result.count < length {
                result.append(contentsOf: str)
            }
        }
        
        return result
    }
    
    private func isMoreThanMaxTimes(value: String, data: [String]) -> Bool {
        var times = 0
        for str: String in data {
            if value == str {
                times += 1
            }
            
            if (times >= maxTimes) {
                return true
            }
        }
        
        return false
    }
    
    private func appendString(from: String, to: String) -> [String] {
        var result: [String] = []
        let uniFrom = NSString(string: from).character(at: 0)
        let uniTo = NSString(string: to).character(at: 0)
        for value: unichar in uniFrom ... uniTo {
            let str = String(format: "%c", value)
            result.append(str)
        }
        
        return result
    }
}
