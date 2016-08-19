# Installation

## cocoapods

1. pod init

2. vim Podfile
 ```
 # Uncomment this line to define a global platform for your project
 # platform :ios, '8.0'
 # Uncomment this line if you're using Swift
 use_frameworks!

 target 'YOUR_APP_TARGET' do
     pod 'NCMB', :git => 'https://github.com/n0guch1/ncmb_swift.git'
 end
 ```
3. pod install


## Carthage

1. vim Cartfile
 ```
 github "n0guch1/ncmb_swift" "master"
 ```

2. carthage update
