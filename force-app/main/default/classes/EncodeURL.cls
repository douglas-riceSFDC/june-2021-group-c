public class EncodeURL {
    
    @InvocableMethod(label='Encode Url' description='Encodes the URL for use in API calls')
    public static List<String> encodeURL(List<String> urlStrings){
        List<String> encodedUrls = new List<String>();
        for(String urlString: urlStrings) {
        	encodedUrls.add(EncodingUtil.urlEncode(urlString, 'UTF-8'));
        }
        return encodedUrls;
    }
}