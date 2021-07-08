public with sharing class OpenMovieDatabaseWrapper {

    @future (callout=true)
    public static void getTitleDetails(Set<Id> titleIds) {
        Http http = new Http();
        List<Title__c> titles = [SELECT Name, Director__c, Writer__c, Notable_Actors__c FROM Title__c WHERE Id IN :titleIds];

        for(Title__c title : titles) {
            try{
                HttpRequest request = new HttpRequest();
                request.setEndpoint('http://www.omdbapi.com/?t=' + EncodingUtil.urlEncode(title.Name, 'UTF-8') + '&apikey=8b1c0cf6');
                request.setMethod('GET');
    
                HttpResponse response = http.send(request);
    
                if(response.getStatusCode() == 200) {
                    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    
                    title.Director__c = title.Director__c == null ? (String)results.get('Director') : title.Director__c;
                    title.Writer__c = title.Writer__c == null ? (String)results.get('Writer') : title.Writer__c;
                    title.Notable_Actors__c = title.Notable_Actors__c == null ? (String)results.get('Actors') : title.Notable_Actors__c;
                } else {
                    System.debug('Response was not as expected; Status code: ' + response.getStatusCode());
                }
            } catch(Exception e) {
                System.debug('There was an exception retreiving data for the title ' + title.Name);
                System.debug(e.getTypeName());
                System.debug(e.getMessage());
                
            }
        }

        update titles;
    }

}