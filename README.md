![Meets logo](http://meets.io/assets/logo_ios_meets_magento-f5e2c8be46c4cfbb1bef8d588c6ff993.png "Meets")

# Overview

iOS Meets is a native SDK designed to ease communication between mobile apps and Magento stores.
It allows you to access Magento's data as if it were local data.

You don't have to worry about learning Magento's SOAP and REST APIs or dealing with low level details.
Instead, you can only focus on building a rich native mobile shopping experience.

# Main features

- Native library that works with your project out of the box.
- Allows you to forget complexities and focus on what really matters.
- Access to Magento users, categories and products as if they were local data.
- Easily implement a fully native shopping experience.
- Continuously updated [API documentation](http://meets.io/docs) with examples.
- Direct contact with Meets programmers to resolve issues.

# Learn more

You can learn more about Meets in the official web page, <http://meets.io/>, and in the [API documentation](http://meets.io/docs)

# How to install

> **WARNING:**
>
>_Note that this is a alpha version of Meets so it's not intended to use in productions environments.
>We are working hard to have a stable version as soon as possible._
>
> _Also note that all data sent and retrieved to/from the server goes in plain text. If you want to use Meets to work
> with sensitive information be sure to be under a secure connection._

We are working hard to make the installation process as easy as possible. Future releases will be published in CocoaPods dependency manager
so you will only have to add the Meets library dependency to your project.

Right now you have to follow this steps:

1. Download Meets project.
1. Unzip `Meets.framework-<version number>.zip (located in bin folder) and drag `Meets.framework` inside your Xcode project.
1. Add `#import <Meets/Meets/Meets.h>`to your project's `.pch` file.

Meets works with several CocoaPods dependencies. Add them to your `podfile`:

        platform :ios, '7.0'
        pod 'AFNetworking', '~> 2.1.0'
        pod 'AFXMLDictionarySerializer', '~> 0.0.1'


# Meets at Meet Magento Spain conference

![Meet Magento Spain logo](http://es.meet-magento.com/wp-content/uploads/2012/10/blogi4mm14es.jpg "Meet Magento Spain")

Meets have been announced at [Meet Magento Spain](http://es.meet-magento.com/), a Magento eCommerce conference
where merchants, Magento agencies, Magento service provider and the Magento community exchange knowledge and
experiences with enthusiastic decision maker and experts according the topics Magento and eCommerce.

[Meets at Meet Magento Spain.](http://es.meet-magento.com/meets/)

# Open source projects that have helped Meets to come a reality

Special thanks to people involved in the following projects. They have made easier to achieve the goals of Meets:

- [AFNetworking](http://afnetworking.com)
- [Wsdl2Code](http://www.wsdl2code.com/pages/home.aspx)
- [NSHash](https://github.com/jerolimov/NSHash)
- [XPathQuery](https://github.com/Backcountry/XPathQuery)

# License

This project uses the MIT license. See LICENSE.txt

# Next steps

1. Improve the installation process via CocoaPods
1. Add appledoc
1. Keep on adding more Magento API use cases
1. Build a generic SOAP Parser to get rid of all the Wsdl2Code generated code
1. Add tests
