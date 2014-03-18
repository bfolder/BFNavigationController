### Readme

This is basically an approach to bring the popular UINavigationController to Mac OS X.

---

### Installation

Include all files manually or add the following to your podfile:

```Ruby
pod 'BFNavigationController'
```

## How it works

BFNavigationController is easy to use and works almost exactly like a UINavigationController. All method names (and respective functionalities) have been derived from UINavigationController. You can therefore just look into 
Apple's UIKit online documentation (http://developer.apple.com/library/ios/#documentation/uikit/reference/UINavigationController_Class/Reference/Reference.html) for further references.

In contrast to their iOS counterparts, Mac apps should of course be more flexible when it comes to custom window sizes and layouts. Hence, you can intialize your BFNavigationController by providing an NSRect:


	_navigationController = [[BFNavigationController alloc] initWithFrame: YOUR_RECT rootViewController: YOUR_VIEW_CONTROLLER];
	[_window.contentView addSubview: _navigationController.view];


Navigation- and toolbars haven't been implemented yet. However, you can easily hook in some custom bars. 
Setting a BFNavigationControllerDelegate and implementing the methods `-navigationController:willShowViewController:animated:` and `-navigationController:didShowViewController:animated:` 
could be the perfect way to do this.

---
### Licensing

BFNavigationController is licensed under MIT License. 
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.