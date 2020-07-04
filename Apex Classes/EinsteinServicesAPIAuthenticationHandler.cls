public class EinsteinServicesAPIAuthenticationHandler {
    public static String getAccessToken(String cmdtDeveloperName) {

        JSON_Web_Token__mdt jwtMdt = [
            SELECT Id,Algorithm__c,Audiences__c,Endpoint__c,Issuer__c,RSA_Key__c,Subscriber__c,Token_Duration__c
            FROM JSON_Web_Token__mdt
            WHERE DeveloperName = :cmdtDeveloperName
        ];

        JWT jwt = new JWT(jwtMdt.Algorithm__c,Integer.valueOf(jwtMdt.Token_Duration__c));
        jwt.pkcs8 =jwtMdt.RSA_Key__c;
        jwt.iss = jwtMdt.Issuer__c;
        jwt.sub = jwtMdt.Subscriber__c;
        jwt.aud = jwtMdt.Audiences__c;
        
        String accessToken = JWTBearerFlow.getAccessToken(jwtMdt.Endpoint__c, jwt);
        return accessToken;
    }
}
