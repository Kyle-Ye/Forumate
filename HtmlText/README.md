# HtmlText

SwiftUI View to present formatted html content with clickable links, that fits content size.

<table>
<tr>
<td><img src="Examples/demo1.png"/></td>
</tr>
</table>

## Features
- view size is fitted by height, so you can use it as a part of content 
- user is able to tap on a link (http/https/tel/mailto)
- you can use CSS Constructor to customise html presenting

# Installing
Swift Package Manager:
```
https://github.com/Jnis/HtmlText.git
```

# Usage

1) manually control body, css and link taps.

``` swift
import HtmlText

HtmlText(body: "<p>text1</p><p>text2</p>",
         css: .init(fontFaces: [],
                    css: "* {color:#FF00FF}"),
         linkTap: { url in
    // handle link tap
})
```

2) Use default link taps handler and CSS constructor.

``` swift
import HtmlText

// make a convenient wrapper
extension HtmlText {
    init(body: String, font: FrontNames, size: CGFloat, lineHeight: CGFloat, textColor: Color) {
        self.init(body: body,
                  css: .init(constructor: CSS.Constructor()
                        .text(fontName: font.fontName,
                              fileName: font.fileName,
                              size: size,
                              lineHeight: lineHeight,
                              letterSpacing: 0,
                              textIndent: 10,
                              color: textColor)
                        .link(color: .red, underlined: false)
                        .paragraph(padding: .init(top: 10, left: 0, bottom: 0, right: 0))
                        .list(padding: .init(top: 10, left: 24, bottom: 10, right: 0))
                  ),
                  linkTap: HtmlText.defaultLinkTapHandler(httpLinkTap: .openSFSafariModal))
    }
}

HtmlText(body: Constants.demoHtml,
         font: .bold,
         size: 12,
         lineHeight: 20,
         textColor: Color.gray)
```

You can find more examples inside `/Examples` folder.

# License 
MIT
