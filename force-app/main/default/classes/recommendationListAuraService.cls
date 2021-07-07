public with sharing class recommendationListAuraService {
    
    @AuraEnabled
    public static List<Rental__c> getRentalsFromCustomer(){
        return [SELECT Stock__c
                FROM Rental__c
                WHERE Customer__c = :UserInfo.getUserId()];
    }

    @AuraEnabled
    public static List<Title__c> getRecommendedTitlesFromGenres(List<String> genres){
        return [SELECT Id, Name, Thumbnail__c
                FROM Title__c
                WHERE Genre__c IN :genres];
    }
}