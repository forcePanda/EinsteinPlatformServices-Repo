public class JWT {
    
    public String alg {get;set;}
    public String iss {get;set;}
    public String sub {get;set;}
    public String aud {get;set;}
    public String exp {get;set;}
    public String iat {get;set;}
    public Map<String,String> claims {get;set;}
    public Integer validFor {get;set;}
    public String cert {get;set;}
    public String pkcs8 {get;set;}
    public String privateKey {get;set;}
    
    public static final String HS256 = 'HS256';
    public static final String RS256 = 'RS256';
    public static final String NONE = 'none';
    
    public JWT(String alg, Integer duration) {
        this.alg = alg;
        this.validFor = duration;
    }
    
    public String issue() {
        
        String jwt = '';
        
        JSONGenerator header = JSON.createGenerator(false);
        header.writeStartObject();
        header.writeStringField('alg', this.alg);
        header.writeEndObject();
        blob b = Blob.valueOf(header.getAsString());
        String encodedHeader = base64URLencode(b);
        
        JSONGenerator body = JSON.createGenerator(false);
        body.writeStartObject();
        body.writeStringField('iss', this.iss);
        body.writeStringField('sub', this.sub);
        body.writeStringField('aud', this.aud);
        Long rightNow = (dateTime.now().getTime()/1000)+1;
        body.writeNumberField('iat', rightNow);
        body.writeNumberField('exp', (rightNow + validFor));
        
        body.writeEndObject();
        
        jwt = encodedHeader + '.' + base64URLencode(Blob.valueOf(body.getAsString()));
        
        if ( this.alg == HS256 ) {
            Blob key = EncodingUtil.base64Decode(privateKey);
            Blob signature = Crypto.generateMac('hmacSHA256',Blob.valueof(jwt),key);
            jwt += '.' + base64URLencode(signature);  
        } 
        else if ( this.alg == RS256 ) {
            Blob signature = null;
            Blob privateKey = EncodingUtil.base64Decode(pkcs8);
            signature = Crypto.sign('rsa-sha256', Blob.valueOf(jwt), privateKey);
            
            jwt += '.' + base64URLencode(signature);  
        } 
        else if ( this.alg == NONE ) {
            jwt += '.';
        }
        //system.debug('JWT: '+jwt);
        return jwt;
    }
    
    public String base64URLencode(Blob input){ 
        String output = encodingUtil.base64Encode(input);
        output = output.replace('+', '-');
        output = output.replace('/', '_');
        while ( output.endsWith('=')){
            output = output.subString(0,output.length()-1);
        }
        return output;
    }
}