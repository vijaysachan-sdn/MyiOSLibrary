//
//  BaseVC.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 5/28/25.
//
import UIKit
public class BaseVC: UIViewController{
    public override func viewDidLoad(){
        super.viewDidLoad()
    }
    static func instantiate<T: UIViewController>(storyboardName: String,vcType: T.Type) -> T{
        let identifier = String(describing: vcType)
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.module)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }

}
