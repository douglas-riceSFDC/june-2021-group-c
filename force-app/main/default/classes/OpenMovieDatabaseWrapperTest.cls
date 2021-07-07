@isTest
public class OpenMovieDatabaseWrapperTest {

    @TestSetup
    static void makeData(){
        Title__c batman = new Title__c(Name='Batman');
        insert batman;
    }

    @isTest
    static void getTitleDetails_givenId_shouldUpdateTitleFields() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetOpenMovieDatabaseResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');

        Test.setMock(HttpCalloutMock.class, mock);


        List<Title__c> movies = [SELECT Id FROM Title__c];
        Set<Id> movieIds = new Set<Id>();

        for (Title__c t : movies) {
            movieIds.add(t.Id);
        }

        OpenMovieDatabaseWrapper.getTitleDetails(movieIds);

        List<Title__c> results = [SELECT Name, Director__c, Writer__c, Notable_Actors__c FROM Title__c];
        System.debug(results);

    }


}