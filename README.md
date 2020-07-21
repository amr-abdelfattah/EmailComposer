# EmailComposer

[![License](https://img.shields.io/cocoapods/l/OptionMenu.svg?style=flat)](/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/OptionMenu.svg?style=flat)](https://cocoapods.org/pods/OptionMenu)

Send an email using multiple providers Gmail, outlook, Apple Email, ... .

## Usage

```swift
private func openEmailComposer(from viewController: parentViewController,
                               to: String, subject: String, body: String) {
	let emailcomposer = EmailComposer(
      parentViewController: parentViewController,
      to: to,
      subject: subject,
      body: body)
  emailcomposer.open()
}
```

## Requirements
iOS 10+

## License

EmailComposer is available under the MIT license. See the LICENSE file for more info.
