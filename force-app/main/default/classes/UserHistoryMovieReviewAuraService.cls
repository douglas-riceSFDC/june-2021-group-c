public with sharing class UserHistoryMovieReviewAuraService {
    @AuraEnabled
    public static List<Movie_Review__c> getUserMovieReviews(Id recordId){

        List<Movie_Review__c> reviewList = [SELECT Name, Rating__c, Review__c, Reviewer__c, Reviewer__r.SmallPhotoURL, 
                                                Reviewer__r.FirstName, Reviewer__r.LastName, Title__c, CreatedDate
                                            FROM Movie_Review__c
                                            WHERE Reviewer__c = :recordId
                                            ORDER BY CreatedDate DESC];

        return reviewList;
    }

    @AuraEnabled
    public static List<Title__c> getTitleFromId(Id titleId){
        return [SELECT Name, Id, Poster__c, Thumbnail__c
                FROM Title__c
                WHERE Id =: titleId];
    }
}