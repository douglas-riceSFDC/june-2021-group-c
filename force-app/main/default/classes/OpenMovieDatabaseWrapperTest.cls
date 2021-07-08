@isTest
public class OpenMovieDatabaseWrapperTest {
    
    @isTest
    static void getTitleDetails_givenTitleWithFullDetailsOnInsertTrigger_shouldUpdateDirectorWriterNobatableActorsFields() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetOpenMovieDatabaseResourceFullDetails');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        Title__c batman = new Title__c(Name = 'Batman');
        insert batman;
        Test.stopTest();

        List<Title__c> results = [SELECT Name, Director__c, Writer__c, Notable_Actors__c FROM Title__c];
		System.assertEquals('Tim Burton', results[0].Director__c);
        System.assertEquals('Bob Kane (Batman characters), Sam Hamm (story), Sam Hamm (screenplay), Warren Skaaren (screenplay)', results[0].Writer__c);
        System.assertEquals('Michael Keaton, Jack Nicholson, Kim Basinger, Robert Wuhl', results[0].Notable_Actors__c);
    }
    
    @isTest
    static void getTitleDetails_givenTitleWithoutDetailsOnInsertTrigger_shouldNotUpdateTitleFields() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetOpenMovieDatabaseResourceNoDetails');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        Title__c superman = new Title__c(Name = 'Superman');
        insert superman;
        Test.stopTest();
        
        List<Title__c> results = [SELECT Name, Director__c, Writer__c, Notable_Actors__c FROM Title__c];
		System.assertEquals(Null, results[0].Director__c);
        System.assertEquals(Null, results[0].Writer__c);
        System.assertEquals(Null, results[0].Notable_Actors__c);
    }
    
    @isTest
    static void getTitleDetails_givenTitleWithSomeDetailsOnInsertTrigger_shouldUpdateDirectorFields() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetOpenMovieDatabaseResourceLittleDetails');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        Title__c wW = new Title__c(Name = 'Wonder Woman');
        insert wW;
        Test.stopTest();
        
        List<Title__c> results = [SELECT Name, Director__c, Writer__c, Notable_Actors__c FROM Title__c];
		System.assertEquals('Patty Jenkins', results[0].Director__c);
        System.assertEquals(Null, results[0].Writer__c);
        System.assertEquals(Null, results[0].Notable_Actors__c);
    }
    
    @isTest
    static void getTitleDetails_given404_shouldPrintDebugMsgAndNotUpdateFields() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetOpenMovieDatabaseResourceFullDetails');
        mock.setStatusCode(404);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        Title__c batman = new Title__c(Name = 'Batman');
        insert batman;
        Test.stopTest();
        
       	List<Title__c> results = [SELECT Name, Director__c, Writer__c, Notable_Actors__c FROM Title__c];
		System.assertEquals(Null, results[0].Director__c);
        System.assertEquals(Null, results[0].Writer__c);
        System.assertEquals(Null, results[0].Notable_Actors__c);
    }


}