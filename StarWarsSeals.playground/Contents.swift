import UIKit
import PlaygroundSupport
import XCPlayground

func createCircle(_ diameter:CGFloat) -> UIView {
    
    let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: diameter, height: diameter))
    circle.layer.cornerRadius = diameter * 0.5
    
    return circle
}

func createLine(_ length:CGFloat, thickness:CGFloat) -> UIView {
    return UIView(frame: CGRect(x: 0.0, y: 0.0, width: thickness, height: length))
}

func createArcPath() -> UIBezierPath {
    
        let path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 15, startAngle: 0, endAngle: CGFloat(Double.pi * 0.5), clockwise: true)

        return path
}

class Arc: UIView {

    let fillColor:UIColor
    var arcHeight:CGFloat = 10

    init(frame: CGRect, fillColor: UIColor) {
        
        self.fillColor = fillColor
        super.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        
        self.fillColor = .black
        super.init(frame: frame)
    }
    
    required init?(coder decoder: NSCoder) {
        
        self.fillColor = .black
        super.init(coder: decoder)
    }
    
    private var halfWidth: CGFloat {
        return bounds.width * 0.5
    }
    
    private var halfHeight: CGFloat {
        return bounds.height * 0.5
    }
    
    override func draw(_ rect: CGRect) {
        
        let drawingPath = UIBezierPath()

        drawingPath.move(to: CGPoint(x: halfWidth, y: halfHeight))
        drawingPath.addLine(to: CGPoint(x: 0, y: arcHeight))
        drawingPath.addQuadCurve(to: CGPoint(x: bounds.width, y: arcHeight), controlPoint: CGPoint(x: halfWidth, y: 0))
        drawingPath.addLine(to: CGPoint(x: halfWidth, y: halfHeight))
        fillColor.setFill()
        drawingPath.fill()
    }
}

func createEmpireLogoArc(symbolDiameter:CGFloat) -> UIView {
    
    let arcHeighMultiplier:CGFloat = 0.066666667
    
    let outerArc = createEmpireLogoSingleArc(symbolDiameter: symbolDiameter, radiusMultipler: CGFloat(0.45), frameWidthMultipler: CGFloat(0.2), arcHeightMultiplier: arcHeighMultiplier, fillColor: .black)
    outerArc.backgroundColor = .clear
    
    let innerArc = createEmpireLogoSingleArc(symbolDiameter: symbolDiameter, radiusMultipler: CGFloat(0.30), frameWidthMultipler: CGFloat(0.1), arcHeightMultiplier: arcHeighMultiplier, fillColor: .white)
    innerArc.backgroundColor = .clear
    innerArc.center = outerArc.center
    outerArc.addSubview(innerArc)
    
    return outerArc
}

func createEmpireLogoSingleArc(symbolDiameter:CGFloat, radiusMultipler:CGFloat, frameWidthMultipler:CGFloat, arcHeightMultiplier:CGFloat, fillColor:UIColor) -> Arc {
    
    let arcRadius:CGFloat = symbolDiameter * radiusMultipler
    let arcFrameWidth:CGFloat = symbolDiameter * frameWidthMultipler
    let arc = Arc(frame: CGRect(x: 0, y: 0, width: arcFrameWidth, height: arcRadius * 2), fillColor: fillColor)
    
    arc.arcHeight = arcRadius * arcHeightMultiplier
    arc.backgroundColor = .clear
    
    return arc
}

func addEmpireLines(symbolDiameter:CGFloat, containerView:UIView) {
    
    let lineThickness:CGFloat = symbolDiameter * 0.05
    let verticalLine = createLine(symbolDiameter
        , thickness: lineThickness)
    verticalLine.center = containerView.center
    verticalLine.backgroundColor = .black
    containerView.addSubview(verticalLine)
    
    let slashLine = createLine(symbolDiameter
        , thickness: lineThickness)
    slashLine.center = containerView.center
    slashLine.backgroundColor = .black
    let slashTranform = slashLine.transform.rotated(by: CGFloat(Double.pi/3.0))
    slashLine.transform = slashTranform
    containerView.addSubview(slashLine)
    
    let backslashLine = createLine(symbolDiameter
        , thickness: lineThickness)
    backslashLine.center = containerView.center
    backslashLine.backgroundColor = .black
    let backslashTransform = backslashLine.transform.rotated(by: CGFloat(-Double.pi/3.0))
    backslashLine.transform = backslashTransform
    containerView.addSubview(backslashLine)
}

func addEmpireArcs(symbolDiameter:CGFloat, containerView:UIView) {
    
    let topArc = createEmpireLogoArc(symbolDiameter: symbolDiameter)
    topArc.center = containerView.center
    containerView.addSubview(topArc)
    
    let topRightArc = createEmpireLogoArc(symbolDiameter: symbolDiameter)
    topRightArc.center = containerView.center
    containerView.addSubview(topRightArc)
    let topRightArcTransform = topRightArc.transform.rotated(by: CGFloat(Double.pi/3))
    topRightArc.transform = topRightArcTransform

    let bottomRightArc = createEmpireLogoArc(symbolDiameter: symbolDiameter)
    bottomRightArc.center = containerView.center
    containerView.addSubview(bottomRightArc)
    let bottomRightArcTransform = bottomRightArc.transform.rotated(by: CGFloat(2 * Double.pi/3))
    bottomRightArc.transform = bottomRightArcTransform

    let bottomArc = createEmpireLogoArc(symbolDiameter: symbolDiameter)
    bottomArc.center = containerView.center
    containerView.addSubview(bottomArc)
    let bottomArcTransform = bottomArc.transform.rotated(by: CGFloat(Double.pi))
    bottomArc.transform = bottomArcTransform

    let topLeftArc = createEmpireLogoArc(symbolDiameter: symbolDiameter)
    topLeftArc.center = containerView.center
    containerView.addSubview(topLeftArc)
    let topLeftArcTransform = topLeftArc.transform.rotated(by: CGFloat(-Double.pi/3))
    topLeftArc.transform = topLeftArcTransform

    let bottomLeftArc = createEmpireLogoArc(symbolDiameter: symbolDiameter)
    bottomLeftArc.center = containerView.center
    containerView.addSubview(bottomLeftArc)
    let bottomLeftArcTransform = bottomLeftArc.transform.rotated(by: CGFloat(-2 * Double.pi/3))
    bottomLeftArc.transform = bottomLeftArcTransform
}

let symbolDiameter:CGFloat = 350

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: symbolDiameter, height: symbolDiameter))
containerView.backgroundColor = .white
PlaygroundPage.current.liveView = containerView

let arcHeighMultiplier:CGFloat = 0.066666667

let baseCircle = createCircle(symbolDiameter)
baseCircle.backgroundColor = .black
baseCircle.center = containerView.center
containerView.addSubview(baseCircle)

let circle2 = createCircle(symbolDiameter * 0.90)
circle2.backgroundColor = .white
circle2.center = containerView.center
containerView.addSubview(circle2)

addEmpireLines(symbolDiameter: symbolDiameter, containerView: containerView)

let circle3 = createCircle(symbolDiameter * 0.75)
circle3.backgroundColor = .black
circle3.center = containerView.center
containerView.addSubview(circle3)

addEmpireArcs(symbolDiameter: symbolDiameter, containerView:containerView)

let circle4 = createCircle(symbolDiameter * 0.3)
circle4.backgroundColor = .white
circle4.center = containerView.center
containerView.addSubview(circle4)
