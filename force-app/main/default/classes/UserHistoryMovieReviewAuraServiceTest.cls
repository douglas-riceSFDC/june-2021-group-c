@isTest
private class UserHistoryMovieReviewAuraServiceTest {

    @isTest
    static void getMovieReviews_givenMovieReviewsForSpecificUser_shouldReturnMovieReviewsForSpecificUser(){
        List<Movie_Review__c> testList = new List<Movie_Review__c>();

        Title__c testTitle = new Title__c();
        testTitle.Name = 'First Title';
        insert testTitle;

        Movie_Review__c firstReview = new Movie_Review__c();
        firstReview.Title__c = testTitle.Id;
        firstReview.Reviewer__c = UserInfo.getUserId();
        testList.add(firstReview);

        Title__c testTitle2 = new Title__c();
        testTitle2.Name = 'Second Title';
        insert testTitle2;

        Movie_Review__c secondReview = new Movie_Review__c();
        secondReview.Title__c = testTitle2.Id;
        secondReview.Reviewer__c = UserInfo.getUserId();
        testList.add(secondReview);

        Test.startTest();
        
        insert testList;
        List<Movie_Review__c> returnedMovieReviews = UserHistoryMovieReviewAuraService.getUserMovieReviews(UserInfo.getUserId());

        Test.stopTest();

        system.assertEquals(2, returnedMovieReviews.size(), 'Two movie review should have been returned');
    }


    @isTest
    static void getMovieReviews_givenNoMovieReviewsForSpecificUser_shouldNotReturnMovieReviewsForSpecificUser(){
        Title__c testTitle = new Title__c();
        testTitle.Name = 'First Title';
        insert testTitle;

        Movie_Review__c firstReview = new Movie_Review__c();
        firstReview.Title__c = testTitle.Id;
        insert firstReview;
        
        Test.startTest();

        List<Movie_Review__c> returnedMovieReviews = UserHistoryMovieReviewAuraService.getUserMovieReviews(UserInfo.getUserID());

        Test.stopTest();

        system.assertEquals(0, returnedMovieReviews.size(), 'No movie reviews should have be returned');
    }
}
