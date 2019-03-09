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
    
    override func loadView() {
        let view = NSView(frame: AppConfig.windowRect)
        view.wantsLayer = true
        self.view = view
        
        initPasswordOptionPanel()
        initResultPanel()
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
        
        tfPasswordLengthValue = NSTextField(string: "32")
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
        scStepper.minValue = 1
        scStepper.autorepeat = false
        scStepper.valueWraps = false
        scStepper.increment = 1
        scStepper.maxValue = 50
        scStepper.intValue = 32
        boxPasswordOptions.addSubview(scStepper)
        
        scStepper.snp.makeConstraints { make in
            make.left.equalTo(tfPasswordLengthValue.snp.right).offset(10)
            make.centerY.equalTo(tfPasswordLengthValue)
        }
        
        slPasswordLength = NSSlider()
        slPasswordLength.sliderType = .linear
        slPasswordLength.numberOfTickMarks = 25
        slPasswordLength.tickMarkPosition = .below
        slPasswordLength.minValue = 1
        slPasswordLength.maxValue = 50
        slPasswordLength.intValue = 32
        slPasswordLength.isContinuous = true
        
        boxPasswordOptions.addSubview(slPasswordLength)
        slPasswordLength.snp.makeConstraints { make in
            make.left.equalTo(cbLowerCharacter)
            make.centerY.equalTo(scStepper)
            make.width.equalTo(300)
        }
        
        boxPasswordOptions.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
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
        
        btnCopy = NSButton()
        btnCopy.title = NSLocalizedString("CopyPassword", comment: "")
        btnCopy.font = NSFont.mainFont(size: 14)
        btnCopy.setButtonType(.momentaryPushIn)
        btnCopy.isBordered = true
        btnCopy.bezelStyle = .rounded
        btnCopy.translatesAutoresizingMaskIntoConstraints = false
        boxResult.addSubview(btnCopy)
        
        btnCopy.snp.makeConstraints { make in
            make.left.equalTo(tfPassword.snp.right).offset(20)
            make.centerY.equalTo(tfPassword)
        }
        
        boxResult.snp.makeConstraints { make in
            make.top.equalTo(boxPasswordOptions.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(750)
            make.bottom.equalTo(btnCopy).offset(30)
        }
    }
    
    private func addEvents() {
        slPasswordLength.target = self
        slPasswordLength.action = #selector(onChangedPasswordLength(sender:))
        
        scStepper.target = self
        scStepper.action = #selector(onChangeStepper(sender:))
    }
    
    private func removeEvents() {
        slPasswordLength.target = nil
        slPasswordLength.action = nil
        
        scStepper.target = nil
        scStepper.action = nil
    }
    
    @objc func onChangedPasswordLength(sender: NSSlider) {
        tfPasswordLengthValue.stringValue = "\(sender.integerValue)"
        scStepper.intValue = sender.intValue
    }
    
    @objc func onChangeStepper(sender: NSStepper) {
        tfPasswordLengthValue.stringValue = "\(sender.integerValue)"
        slPasswordLength.intValue = sender.intValue
    }
}
