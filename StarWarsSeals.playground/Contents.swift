import UIKit
import XCPlayground

func createCircle(diameter:CGFloat) -> UIView {
    let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: diameter, height: diameter))
    circle.layer.cornerRadius = diameter * 0.5
    
    return circle
}

func createLine(length:CGFloat, thickness:CGFloat) -> UIView {
    return UIView(frame: CGRectMake(0, 0, thickness, length))
}

func createArcPath() -> UIBezierPath {
        let path = UIBezierPath(arcCenter: CGPointMake(0, 0), radius: 15, startAngle: 0, endAngle: CGFloat(M_PI_2), clockwise: true)

        return path
}

class Arc: UIView {
    var fillColor:UIColor = UIColor.blackColor()
    var arcHeight:CGFloat = 10
    override func drawRect(rect: CGRect) {
        
        let graphicsContext = UIGraphicsGetCurrentContext()
        CGContextSaveGState(graphicsContext)
        
        let drawingPath = CGPathCreateMutable()
        let halfHeight:CGFloat = frame.size.height * 0.5
        CGPathMoveToPoint(drawingPath, nil, frame.width * 0.5, halfHeight)
        CGPathAddLineToPoint(drawingPath, nil, 0, arcHeight)
        CGPathAddQuadCurveToPoint(drawingPath, nil, frame.width * 0.5, 0, frame.width, arcHeight)
        CGPathAddLineToPoint(drawingPath, nil, frame.width * 0.5, halfHeight)
        CGContextAddPath(graphicsContext, drawingPath)
        CGContextSetFillColorWithColor(graphicsContext,fillColor.CGColor)
        CGContextDrawPath(graphicsContext, .Fill)
        
        CGContextRestoreGState(graphicsContext)
    }
}

func createEmpireLogoArc(symbolDiameter:CGFloat) -> UIView {
    
    let arcHeighMultiplier:CGFloat = 0.066666667
    
    let outerArc = createEmpireLogoSingleArc(symbolDiameter, radiusMultipler: CGFloat(0.45), frameWidthMultipler: CGFloat(0.2), arcHeightMultiplier: arcHeighMultiplier)
    
    outerArc.fillColor = .blackColor()
    
    let innerArc = createEmpireLogoSingleArc(symbolDiameter, radiusMultipler: CGFloat(0.30), frameWidthMultipler: CGFloat(0.1), arcHeightMultiplier: arcHeighMultiplier)
    innerArc.fillColor = .whiteColor()
    innerArc.center = outerArc.center
    outerArc.addSubview(innerArc)
    
    return outerArc
}

func createEmpireLogoSingleArc(symbolDiameter:CGFloat, radiusMultipler:CGFloat, frameWidthMultipler:CGFloat, arcHeightMultiplier:CGFloat) -> Arc {
    
    let arcRadius:CGFloat = symbolDiameter * radiusMultipler
    let arcFrameWidth:CGFloat = symbolDiameter * frameWidthMultipler
    let arcHeight = arcRadius * arcHeightMultiplier
    let arc = Arc(frame: CGRectMake(0, 0, arcFrameWidth, arcRadius * 2))
    arc.arcHeight = arcHeight
    arc.backgroundColor = .clearColor()
    
    return arc
}

func addEmpireLines(symbolDiameter:CGFloat, containerView:UIView) {
    
    let lineThickness:CGFloat = symbolDiameter * 0.05
    let verticalLine = createLine(symbolDiameter
        , thickness: lineThickness)
    verticalLine.center = containerView.center
    verticalLine.backgroundColor = .blackColor()
    containerView.addSubview(verticalLine)
    
    let slashLine = createLine(symbolDiameter
        , thickness: lineThickness)
    slashLine.center = containerView.center
    slashLine.backgroundColor = .blackColor()
    let slashTranform = CGAffineTransformRotate(slashLine.transform, CGFloat(M_PI/3.0))
    slashLine.transform = slashTranform
    containerView.addSubview(slashLine)
    
    let backslashLine = createLine(symbolDiameter
        , thickness: lineThickness)
    backslashLine.center = containerView.center
    backslashLine.backgroundColor = .blackColor()
    let backslashTransform = CGAffineTransformRotate(backslashLine.transform, CGFloat(-M_PI/3.0))
    backslashLine.transform = backslashTransform
    containerView.addSubview(backslashLine)

}

func addEmpireArcs(symbolDiameter:CGFloat, containerView:UIView) {
    
    let topArc = createEmpireLogoArc(symbolDiameter)
    topArc.center = containerView.center
    containerView.addSubview(topArc)
    
    let topRightArc = createEmpireLogoArc(symbolDiameter)
    topRightArc.center = containerView.center
    containerView.addSubview(topRightArc)
    let topRightArcTransform = CGAffineTransformRotate(topRightArc.transform, CGFloat(M_PI/3))
    topRightArc.transform = topRightArcTransform
    
    let bottomRightArc = createEmpireLogoArc(symbolDiameter)
    bottomRightArc.center = containerView.center
    containerView.addSubview(bottomRightArc)
    let bottomRightArcTransform = CGAffineTransformRotate(bottomRightArc.transform, CGFloat(2*M_PI/3))
    bottomRightArc.transform = bottomRightArcTransform
    
    let bottomArc = createEmpireLogoArc(symbolDiameter)
    bottomArc.center = containerView.center
    containerView.addSubview(bottomArc)
    let bottomArcTransform = CGAffineTransformRotate(bottomArc.transform, CGFloat(M_PI))
    bottomArc.transform = bottomArcTransform
    
    let topLeftArc = createEmpireLogoArc(symbolDiameter)
    topLeftArc.center = containerView.center
    containerView.addSubview(topLeftArc)
    let topLeftArcTransform = CGAffineTransformRotate(topLeftArc.transform, CGFloat(-M_PI/3))
    topLeftArc.transform = topLeftArcTransform
    
    let bottomLeftArc = createEmpireLogoArc(symbolDiameter)
    bottomLeftArc.center = containerView.center
    containerView.addSubview(bottomLeftArc)
    let bottomLeftArcTransform = CGAffineTransformRotate(bottomLeftArc.transform, CGFloat(-2*M_PI/3))
    bottomLeftArc.transform = bottomLeftArcTransform
    
    let circle4 = createCircle(symbolDiameter * 0.3)
    circle4.backgroundColor = .whiteColor()
    circle4.center = containerView.center
    containerView.addSubview(circle4)
}

let symbolDiameter:CGFloat = 350

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: symbolDiameter, height: symbolDiameter))
containerView.backgroundColor = .whiteColor()
XCPlaygroundPage.currentPage.liveView = containerView

let baseCircle = createCircle(symbolDiameter)
baseCircle.backgroundColor = .blackColor()
baseCircle.center = containerView.center
containerView.addSubview(baseCircle)

let circle2 = createCircle(symbolDiameter * 0.90)
circle2.backgroundColor = .whiteColor()
circle2.center = containerView.center
containerView.addSubview(circle2)

addEmpireLines(symbolDiameter, containerView: containerView)

let circle3 = createCircle(symbolDiameter * 0.75)
circle3.backgroundColor = .blackColor()
circle3.center = containerView.center
containerView.addSubview(circle3)

addEmpireArcs(symbolDiameter, containerView:containerView)














