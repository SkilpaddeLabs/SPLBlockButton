# SPLBlockButton
UIButton subclass that allows assigning blocks of CoreGraphics code to draw their content. Great for creating widgets that scale to different screens
without having to constantly regenerate PNG's.


![alt tag](https://cloud.githubusercontent.com/assets/193383/14549024/300e675e-028a-11e6-97f3-ebe3d1cbd80f.png)

## Create a new Button

```swift

let roundedButton = SPLBlockButton()
roundedButton.setBlockForState( .Normal ) { (rect, tintColor) in

    let context = UIGraphicsGetCurrentContext()

    let stroke:CGFloat = 4.0
    let inset:CGFloat  = stroke / 2.0
    let shadowInset:CGFloat = 4.0
    let drawRect = CGRectInset(rect, inset, inset)
    let rectPath = UIBezierPath(roundedRect: drawRect, cornerRadius: stroke)
    rectPath.lineWidth = stroke

    let offsetSize = CGSize(width: shadowOffset, height: shadowOffset)
    CGContextSetShadow(context, offsetSize, 3.0)

    tintColor.setStroke()
    rectPath.stroke()
}

```

## FAQ

### Hey, they're not called blocks in Swift.

I originally made this in Obj-C and SPLClosureButton just doesn't roll off the tounge.
