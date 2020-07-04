public class EinsteinOCRPredictionHandler {

    final static String VISION_API = 'https://api.einstein.ai/v2/vision';
    final static String OCREndpoint = VISION_API + '/ocr';
    final static String cmdtDeveloperName = 'Einstein_Vision_API_JWT';
    
    public class EinsteinOCRPredictionHandlerException extends Exception {}
    
    public static String extractTextFromOCRResponse(EinsteinOCRPredictionResponseWrapper response, String separator) {
        String extractedWords;
        for(EinsteinOCRPredictionResponseWrapper.ProbabilityWrapper extractedWord : response.probabilities) {
            if(String.isNotEmpty(extractedWords)) {
                extractedWords += (separator + extractedWord.label);
            } else {
                extractedWords = extractedWord.label;
            }
        }
        return extractedWords;
    }

    public static EinsteinOCRPredictionResponseWrapper predictViaURL(String fileURL, String detectionType, String accessToken, String model) {
        String response = detectText(fileURL, detectionType, accessToken, model, false);
        return parseResponse(response);
    }

    public static EinsteinOCRPredictionResponseWrapper predictViaBase64(String base64String, String detectionType, String accessToken, String model) {
        String response = detectText(base64String, detectionType, accessToken, model, true);
        return parseResponse(response);
    }
    
    public static EinsteinOCRPredictionResponseWrapper predictViaBlob(Blob fileBlob, String detectionType, String accessToken, String model) {
        String response = detectText(EncodingUtil.base64Encode(fileBlob), detectionType, accessToken, model, true);
        return parseResponse(response);
    }
    
    public static String detectText(String sample, String detectionType, String accessToken, String model, boolean isBase64) {
        string contentType = HttpFormBuilder.GetContentType();
        //  Compose the form
        string form64 = '';
        form64 += HttpFormBuilder.WriteBoundary();
        form64 += HttpFormBuilder.WriteBodyParameter('modelId', EncodingUtil.urlEncode(model, 'UTF-8'));
        form64 += HttpFormBuilder.WriteBoundary();
        form64 += HttpFormBuilder.WriteBodyParameter('task', EncodingUtil.urlEncode(detectionType, 'UTF-8'));
        form64 += HttpFormBuilder.WriteBoundary();
        if(isBase64) {
            form64 += HttpFormBuilder.WriteBodyParameter('sampleBase64Content', sample);
        } else {
            form64 += HttpFormBuilder.WriteBodyParameter('sampleLocation', sample);
        }
        form64 += HttpFormBuilder.WriteBoundary(HttpFormBuilder.EndingType.CrLf);
        blob formBlob = EncodingUtil.base64Decode(form64);
        string contentLength = string.valueOf(formBlob.size());
        //  Compose the http request
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setBodyAsBlob(formBlob);
        httpRequest.setHeader('Connection', 'keep-alive');
        httpRequest.setHeader('Content-Length', contentLength);
        httpRequest.setHeader('Content-Type', contentType);
        httpRequest.setMethod('POST');
        //httpRequest.setTimeout(120000);
        httpRequest.setHeader('Authorization','Bearer ' + accessToken);
        httpRequest.setEndpoint(OCREndpoint);
        
        Http http = new Http();
        HTTPResponse res = http.send(httpRequest);
        System.debug(res.getStatus());
        String responseBody;
        if (res.getStatusCode() == 200) {
            responseBody = res.getBody();
        }
        return responseBody;
    }

    static EinsteinOCRPredictionResponseWrapper parseResponse(String response) {
        return (EinsteinOCRPredictionResponseWrapper)JSON.deserialize(response, EinsteinOCRPredictionResponseWrapper.class);
    }
}