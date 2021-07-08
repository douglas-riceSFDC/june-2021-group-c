public with sharing class TitleAuraService {
    
    @AuraEnabled
    public static List<Title__c> getLatestTitles(Integer limiter){
        return [SELECT Name, Genre__c, Thumbnail__c, Available_Stock__c, Total_Stock__c
                FROM Title__c
                ORDER BY CreatedDate DESC
                LIMIT :limiter];
    }

    @AuraEnabled
    public static List<Title__c> getOutOfStockTitles(){
        return [SELECT Name, Genre__c, Thumbnail__c, Available_Stock__c, Total_Stock__c
                FROM Title__c
                WHERE Available_Stock__c = 0
                ORDER BY CreatedDate DESC];

    }

    @AuraEnabled
    public static List<Title__c> getTitleInformation(Id recordId){
        return [SELECT Id, Name, Available_Stock__c, Director__c, Genre__c, Language__c, 
                        Notable_Actors__c, Plot_Description__c, Poster__c, Rating__c, Release_Date__c, 
                        Runtime__c, Thumbnail__c, Total_Stock__c, Writer__c
                FROM Title__c
                WHERE Id = :recordId];
    }
}