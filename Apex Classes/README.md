# Utility Classes to interact with Einstein Platform Services APIs
This directory contains some apex classes that you can use to interact with Einstein Language and Vision API.

### Related Blog posts links:
- [Introduction to Einstein OCR](https://forcepanda.wordpress.com/2020/05/30/say-hi-to-the-new-einstein-ocr-summer20/)
- [Einstein OCR - Extract Text from Image](https://forcepanda.wordpress.com/2020/06/02/extract-text-from-image-einstein-ocr/)

### Custom Metadata Settings Details
![alt text](/JWT MDT Definition.png "JWT MDT Definition")

|Classes| Description
|-|-|
| EinsteinServicesAPIAuthenticationHandler | Main class that calls the 'JWTBearerFlow' class to get the authentication token | 
| JWT | Used for generation of Assertion Signing Key |
| JWTBearerFlow | Used for making callout to Einstein APIs for authentication |

