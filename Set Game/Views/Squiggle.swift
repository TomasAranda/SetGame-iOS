//
//  Squiggle.swift
//  Set Game
//
//  Created by Tomás Aranda on 22/12/2021.
//

import SwiftUI

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let startingPoint = CGPoint(x: rect.minX, y: rect.midY)

        let firstPoint = CGPoint(x: rect.width * 0.85, y: rect.height * 0.2)
        let curve1controlPoint1 = CGPoint(x: rect.width * 0.0, y: rect.height * -0.5)
        let curve1controlPoint2 = CGPoint(x: rect.width * 0.8, y: rect.height * 0.6)

        let secondPoint = CGPoint(x: rect.width, y: rect.midY)
        let curve2controlPoint1 = CGPoint(x: rect.width * 0.88, y: rect.height * 0.05)
        let curve2controlPoint2 = CGPoint(x: rect.width, y: rect.height * 0.2)

        path.move(to: startingPoint)
        path.addCurve(to: firstPoint, control1: curve1controlPoint1, control2: curve1controlPoint2)
//        path.addCurve(to: secondPoint, control1: curve2controlPoint1, control2: curve2controlPoint2)
        path.addCurve(to: secondPoint, control1: curve2controlPoint1, control2: curve2controlPoint2)

        var lowerCurve = path
        lowerCurve = lowerCurve.applying(CGAffineTransform.identity.rotated(by: CGFloat.pi))
        lowerCurve = lowerCurve.applying(CGAffineTransform.identity
                    .translatedBy(x: rect.size.width, y: rect.size.height))

        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addPath(lowerCurve)

        return path
    }
}

struct Squiggle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
//            Rectangle().stroke()
            Squiggle()
        }
        .frame(width: 350, height: 200, alignment: .center)
    }
}

//    func path(in rect: CGRect)-> Path{
//            
//            let width  = rect.maxX - rect.minX
//            let height = rect.maxY - rect.minY
//            
//            let bottomLeft      = CGPoint(x:  rect.minX + width*indentFactor,       y: rect.maxY-yIndentFactor*height)
//            let topLeft         = CGPoint(x:  rect.minX + width*doubleIndentFactor, y: rect.minY+yIndentFactor*height)
//            let topRight        = CGPoint(x:  rect.maxX - width*indentFactor,       y: rect.minY+yIndentFactor*height)
//            let bottomRight     = CGPoint(x:  rect.maxX - width*doubleIndentFactor, y: rect.maxY-yIndentFactor*height)
//            
//            let controlTopTop       = CGPoint(x: topLeft.x+(topRight.x-topLeft.x)/(2.6), y:topLeft.y-yControlOffset*height)
//            let controlTopBottom    = CGPoint(x: topLeft.x+(topRight.x-topLeft.x)/(2.6), y:topLeft.y+yControlOffset*height)
//            
//            let controlBottomTop       = CGPoint(x: bottomLeft.x+(bottomRight.x-bottomLeft.x)/(1.6), y:bottomLeft.y-yControlOffset*height)
//            let controlBottomBottom    = CGPoint(x: bottomLeft.x+(bottomRight.x-bottomLeft.x)/(1.6), y:bottomLeft.y+yControlOffset*height)
//            
//            var p = Path()
//            p.move(to: bottomLeft)
//            p.addLine(to: topLeft)
//            p.addCurve(to: topRight,control1: controlTopBottom,control2:controlTopTop )
//            p.addLine(to: bottomRight)
//            p.addCurve(to: bottomLeft,control1:controlBottomTop,control2:controlBottomBottom )
//
//            return p
//        }
//        private let indentFactor : CGFloat = 0.05
//        private let doubleIndentFactor : CGFloat = 0.2
//        private let yIndentFactor : CGFloat = 0.2
//        private let yControlOffset: CGFloat = 0.3
