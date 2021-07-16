@isTest
private class MovieReviewAuraServiceTest {
    @isTest
    static void getMovieReviews_givenMovieReviewsForSpecificTitle_shouldReturnMovieReviewsForSpecifiedTitle()
    {
        List<Movie_Review__c> testList = new List<Movie_Review__c>();

        Title__c testTitle = new Title__c();
        testTitle.Name = 'First Title';
        insert testTitle;

        Movie_Review__c firstReview = new Movie_Review__c();
        firstReview.Title__c = testTitle.Id;
        firstReview.Reviewer__c = UserInfo.getUserId();
        testList.add(firstReview);

        Movie_Review__c secondReview = new Movie_Review__c();
        secondReview.Title__c = testTitle.Id;
        testList.add(secondReview);

        insert testList;

        Test.startTest();
        
        List<Movie_Review__c> returnedMovieReviews = MovieReviewAuraService.getMovieReviews(5, testTitle.Id);

        Test.stopTest();

        system.assertEquals(2, returnedMovieReviews.size(), 'Two movie reviews should have been returned');
    }

    @isTest
    static void getMovieReviews_givenNoMovieReviewsForSpecificTitle_shouldNotReturnMovieReviews()
    {
        Title__c testTitle = new Title__c();
        testTitle.Name = 'First Title';

        Test.startTest();

        List<Movie_Review__c> returnedMovieReviews = MovieReviewAuraService.getMovieReviews(5, testTitle.Id);

        Test.stopTest();

        system.assertEquals(0, returnedMovieReviews.size(), 'No movie reviews should have be returned');
    }
}
