//
//  Depth.swift
//  MoMo
//
//  Created by 초이 on 2021/01/27.
//

import UIKit

enum AppDepth: Int {
    case depth2m = 0, depth30m, depth100m, depth300m, depth700m, depth1005m, depthSimhae
    
    func toString() -> String {
        switch self {
        case .depth2m:
            return "2m"
        case .depth30m:
            return "30m"
        case .depth100m:
            return "100m"
        case .depth300m:
            return "300m"
        case .depth700m:
            return "700m"
        case .depth1005m:
            return "1,005m"
        case .depthSimhae:
            return "심해"
        }
    }
    
    func toGradientColor() -> [CGColor] {
        switch self {
        case .depth2m:
            return [UIColor.Gradient1.cgColor, UIColor.Gradient2.cgColor]
        case .depth30m:
            return [UIColor.Gradient2.cgColor, UIColor.Gradient3.cgColor]
        case .depth100m:
            return [UIColor.Gradient3.cgColor, UIColor.Gradient4.cgColor]
        case .depth300m:
            return [UIColor.Gradient4.cgColor, UIColor.Gradient5.cgColor]
        case .depth700m:
            return [UIColor.Gradient5.cgColor, UIColor.Gradient6.cgColor]
        case .depth1005m:
            return [UIColor.Gradient6.cgColor, UIColor.Gradient7.cgColor]
        case .depthSimhae:
            return [UIColor.Gradient7.cgColor, UIColor.Gradient8.cgColor]
        }
    }
    
    func toLabelImage() -> UIImage? {
        switch self {
        case .depth2m:
            return Constants.Design.Image.label2m
        case .depth30m:
            return Constants.Design.Image.label30m
        case .depth100m:
            return Constants.Design.Image.label100m
        case .depth300m:
            return Constants.Design.Image.label300m
        case .depth700m:
            return Constants.Design.Image.label700m
        case .depth1005m:
            return Constants.Design.Image.label1005m
        case .depthSimhae:
            return Constants.Design.Image.labelDeepSea
        }
    }
}
