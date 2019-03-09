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
    private var cbUpperCharacter: NSButton!
    private var cbNumberCharacter: NSButton!
    private var cbSpecialCharacter: NSButton!
    private var slPasswordLength: NSSlider!
    private var scStepper: NSStepper!
    private var tfPasswordLengthValue: NSTextField!
    
    override func loadView() {
        let view = NSView(frame: AppConfig.windowRect)
        view.wantsLayer = true
        self.view = view
        
        initPasswordOptionPanel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addEvents()
    }
    
    override func viewWillDisappear() {
        removeEvents()
        super.viewWillDisappear()
    }
    
    func initPasswordOptionPanel() {
        let box = NSBox()
        box.title = NSLocalizedString("PasswordOptions", comment: "")
        box.titleFont = NSFont.mainBoldFont(size: 16)
        view.addSubview(box)
        
        let tfUsedCharacter = NSTextField(string: NSLocalizedString("UsedCharacters", comment: ""))
        tfUsedCharacter.isEditable = false
        tfUsedCharacter.isSelectable = false
        tfUsedCharacter.isBordered = false
        tfUsedCharacter.drawsBackground = false
        tfUsedCharacter.font = NSFont.mainFont(size: 14)
        box.addSubview(tfUsedCharacter)
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
        box.addSubview(cbUpperCharacter)
        
        cbUpperCharacter.snp.makeConstraints { make in
            make.left.equalTo(tfUsedCharacter.snp.right).offset(30)
            make.centerY.equalTo(tfUsedCharacter.snp.centerY)
        }
        
        let cbLowerCharacter = NSButton()
        cbLowerCharacter.title = "a-z"
        cbLowerCharacter.font = NSFont.mainFont(size: 14)
        cbLowerCharacter.setButtonType(.switch)
        cbLowerCharacter.state = .on
        box.addSubview(cbLowerCharacter)
        
        cbLowerCharacter.snp.makeConstraints { make in
            make.left.equalTo(cbUpperCharacter.snp.right).offset(spaceSize)
            make.centerY.equalTo(cbUpperCharacter.snp.centerY)
        }
        
        cbNumberCharacter = NSButton()
        cbNumberCharacter.title = "0-9"
        cbNumberCharacter.font = NSFont.mainFont(size: 14)
        cbNumberCharacter.setButtonType(.switch)
        cbNumberCharacter.state = .on
        box.addSubview(cbNumberCharacter)
        
        cbNumberCharacter.snp.makeConstraints { make in
            make.left.equalTo(cbLowerCharacter.snp.right).offset(spaceSize)
            make.centerY.equalTo(cbLowerCharacter.snp.centerY)
        }
        
        cbSpecialCharacter = NSButton()
        cbSpecialCharacter.title = "!@#$%^&*"
        cbSpecialCharacter.font = NSFont.mainFont(size: 14)
        cbSpecialCharacter.setButtonType(.switch)
        cbSpecialCharacter.state = .off
        box.addSubview(cbSpecialCharacter)
        
        cbSpecialCharacter.snp.makeConstraints { make in
            make.left.equalTo(cbNumberCharacter.snp.right).offset(spaceSize)
            make.centerY.equalTo(cbNumberCharacter.snp.centerY)
        }
        
        let tfPasswordLength = NSTextField(string: NSLocalizedString("PasswordLength", comment: ""))
        tfPasswordLength.isEditable = false
        tfPasswordLength.isSelectable = false
        tfPasswordLength.isBordered = false
        tfPasswordLength.drawsBackground = false
        tfPasswordLength.font = NSFont.mainFont(size: 14)
        box.addSubview(tfPasswordLength)
        tfPasswordLength.snp.makeConstraints { make in
            make.left.equalTo(tfUsedCharacter)
            make.top.equalTo(tfUsedCharacter.snp.bottom).offset(30)
        }
        
        tfPasswordLengthValue = NSTextField(string: "32")
        tfPasswordLengthValue.isEditable = false
        tfPasswordLengthValue.isSelectable = false
        tfPasswordLengthValue.isBordered = true
        tfPasswordLengthValue.font = NSFont.mainFont(size: 14)
        box.addSubview(tfPasswordLengthValue)
        tfPasswordLengthValue.snp.makeConstraints { make in
            make.left.equalTo(tfPasswordLength.snp.right).offset(30)
            make.width.equalTo(70)
            make.centerY.equalTo(tfPasswordLength.snp.centerY)
        }
        
        scStepper = NSStepper()
        scStepper.minValue = 1
        scStepper.autorepeat = false
        scStepper.valueWraps = false
        scStepper.increment = 1
        scStepper.maxValue = 50
        scStepper.intValue = 32
        box.addSubview(scStepper)
        
        scStepper.snp.makeConstraints { make in
            make.left.equalTo(tfPasswordLengthValue.snp.right).offset(10)
            make.centerY.equalTo(tfPasswordLengthValue.snp.centerY)
        }
        
        slPasswordLength = NSSlider(target: self, action: #selector(onChangedPasswordLength(sender:)))
        slPasswordLength.sliderType = .linear
        slPasswordLength.numberOfTickMarks = 25
        slPasswordLength.tickMarkPosition = .below
        slPasswordLength.minValue = 1
        slPasswordLength.maxValue = 50
        slPasswordLength.intValue = 32
        slPasswordLength.isContinuous = true
        
        box.addSubview(slPasswordLength)
        slPasswordLength.snp.makeConstraints { make in
            make.left.equalTo(scStepper.snp.right).offset(40)
            make.centerY.equalTo(scStepper)
            make.width.equalTo(300)
        }
        
        box.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(750)
            make.bottom.equalTo(tfPasswordLength.snp.bottom).offset(40)
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
