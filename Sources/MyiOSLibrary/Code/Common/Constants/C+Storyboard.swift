//
//  C+Storyboard.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 5/28/25.
//
import UIKit
extension Constants{
    struct StoryBoard{
        static func filename(for type: StoryboardName) -> String {
            return type.name
        }
        @MainActor
        static func storyboard(for type: StoryboardName) -> UIStoryboard {
            return UIStoryboard(name: filename(for: type), bundle: nil)
        }
        enum StoryboardName{
            case uiKit
            var name:String{
                switch self{
                case .uiKit: return "UIKit"
                }
            }
        }
    }
}
