public with sharing class MovieReviewAuraService {
    @AuraEnabled
    public static List<Movie_Review__c> getMovieReviews(Integer limiter, Id recordId){
        
        List<Movie_Review__c> reviewList = [SELECT Name, Rating__c, Review__c, Reviewer__c, Reviewer__r.SmallPhotoURL, 
                                                Reviewer__r.FirstName, Reviewer__r.LastName, Title__c, CreatedDate
                                            FROM Movie_Review__c
                                            WHERE Title__r.Id = :recordId
                                            ORDER BY CreatedDate DESC
                                            LIMIT :limiter];

        for (Integer i = 0; i < reviewList.size(); ++i){
            reviewList[i].Reviewer__r.LastName = reviewList[i].Reviewer__r.LastName.substring(0,1); 
        }

        return reviewList;
    }
}
