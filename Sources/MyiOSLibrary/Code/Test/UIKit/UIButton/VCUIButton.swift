//
//  File.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 5/28/25.
//
import Foundation
import UIKit
public class VCUIButton:BaseVC{
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var button1:UIButton!
    public static func newInstance() -> VCUIButton{
        return instantiate(storyboardName: Constants.StoryBoard.filename(for: .uiKit), vcType: self)
    }
    public override func viewDidLoad(){
        super.viewDidLoad()
        button1.imageView?.contentMode = .scaleAspectFit
        // MARK: Type
        var arrType:[(UIButton.ButtonType,String)]=[]
        arrType.append((.system,"system"))
        arrType.append((.close,"close"))
        arrType.append((.contactAdd,"contactAdd"))
        arrType.append((.detailDisclosure,"detailDisclosure"))
        arrType.append((.infoLight,"infoLight"))
        arrType.append((.infoDark,"infoDark"))
        arrType.append((.custom,"custom"))
        // MARK: Configuration / Style
        var arrStyle:[(UIButton.Configuration,String)]=[]
        arrStyle.append((UIButton.Configuration.plain(),"plain"))
        arrStyle.append((UIButton.Configuration.gray(),"gray"))
        arrStyle.append((UIButton.Configuration.tinted(),"tinted"))
        arrStyle.append((UIButton.Configuration.filled(),"filled"))
        arrStyle.append((UIButton.Configuration.borderless(),"borderless"))
        arrStyle.append((UIButton.Configuration.bordered(),"bordered"))
        arrStyle.append((UIButton.Configuration.borderedTinted(),"borderedTinted"))
        arrStyle.append((UIButton.Configuration.borderedProminent(),"borderedProminent"))
        for type in arrType {
            for style in arrStyle {
                let btn=UIButton(type: type.0)
                btn.titleLabel?.font=UIFont.systemFont(ofSize: 15)
                btn.contentHorizontalAlignment = .left
                btn.setTitle("Type : \(type.1), Configuration / Style : \(style.1)", for: .normal)
                btn.configuration=style.0
                stackView.addArrangedSubview(btn)
            }
        }
        
        
    }
}
