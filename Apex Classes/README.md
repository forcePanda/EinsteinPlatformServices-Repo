# Utility Classes to interact with Einstein Platform Services APIs
This directory contains some apex classes that you can use to interact with Einstein Language and Vision API.

### Related Blog posts links:
- [Introduction to Einstein OCR](https://forcepanda.wordpress.com/2020/05/30/say-hi-to-the-new-einstein-ocr-summer20/)
- [Authentication with Einstein Vision and Language APIs](https://forcepanda.wordpress.com/2020/07/04/authentication-with-einstein-vision-and-language-apis/)
- [Einstein OCR - Extract Text from Image](https://forcepanda.wordpress.com/2020/06/02/extract-text-from-image-einstein-ocr/)
- [Live Face Detection and Identification using Einstein Vision API & OpenCV](https://forcepanda.wordpress.com/2020/01/03/live-face-detection-and-identification-using-opencv-salesforces-einstein-vision-api/)

### Custom Metadata Type Definition
[JWT MDT Definition.png](https://github.com/forcePanda/EinsteinPlatformServices-Repo/blob/master/Apex%20Classes/JWT%20MDT%20Definition.png)

### List of all the Apex classes
|Class Name| Description
|-|-|
| JWT | Used for generation of Assertion Signing Key |
| JWTBearerFlow | Used for making callout to Einstein APIs for authentication |
| EinsteinServicesAPIAuthenticationHandler | Main class that calls the 'JWTBearerFlow' class to get the authentication token | 
| HttpFormBuilder | Utility class used to create multipart/form-data type request |
| EinsteinOCRPredictionResponseWrapper | Wrapper class for deserialization of response from the Einstein OCR callout |
| EinsteinOCRPredictionHandler | Main class to perform callout to Einstein OCR and process the response |

