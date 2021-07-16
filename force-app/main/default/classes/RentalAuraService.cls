public with sharing class RentalAuraService {
    
    @AuraEnabled(cacheable=true)
    public static List<Rental__c> getCurrentUsersRentals(){
        return [SELECT Name, Due_Date__c, Stock__r.Title__r.Name, Stock__r.Title__r.Poster__c
                FROM Rental__c
                WHERE Customer__c = :UserInfo.getUserId()];
    }

}
