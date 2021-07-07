@isTest
private class MovieReviewAuraServiceTest {
    @isTest
    static void getMovieReviews_givenMovieReviewsForSpecificTitle_shouldReturnMovieReviewsFromDesiredTitle()
    {
        List<Movie_Review__c> testList = new List<Movie_Review__c>();

        Title__c testTitle = new Title__c();
        testTitle.Name = 'First Title';

        Movie_Review__c firstReview = new Movie_Review__c();
        firstReview.Title__r = testTitle;
        testList.add(firstReview);

        Movie_Review__c secondReview = new Movie_Review__c();
        secondReview.Title__r = testTitle;
        testList.add(secondReview);

        Title__c secondTestTitle = new Title__c();
        secondTestTitle.Name = 'Second Title';
        Movie_Review__c thirdReview = new Movie_Review__c();
        thirdReview.Title__r = secondTestTitle;
        testList.add(thirdReview);

        Test.startTest();
        
        insert testList;

        Test.stopTest();

        List<Movie_Review__c> generatedMovieReviews = 
                [SELECT Name, Rating__c, Review__c, Reviewer__c, Reviewer__r.SmallPhotoURL, 
                        Reviewer__r.FirstName, Reviewer__r.LastName, Title__c, CreatedDate
                FROM Movie_Review__c
                WHERE Title__r.Id = :testTitle.Id
                ORDER BY CreatedDate DESC];

        system.assertEquals(1, generatedMovieReviews.size(), 'One movie review should have been returned');
    }
}