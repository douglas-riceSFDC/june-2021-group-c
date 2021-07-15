@isTest
private class RecommendationListAuraServiceTest {

    @isTest
    static void getRentalsFromCustomer_givenNothing_shouldReturnRentalsFromCustomer(){
        Title__c testTitle = new Title__c();
        testTitle.Name = 'Test Movie';
        testTitle.Genre__c = 'Action';
        insert testTitle;

        Stock__c testStock = new Stock__c();
        testStock.Title__c = testTitle.Id;
        testStock.Status__c = 'Rented';
        insert testStock;

        Rental__c testRental = new Rental__c();
        testRental.Stock__c = testStock.Id;
        testRental.Customer__c = UserInfo.getUserId();
        insert testRental;
        
        Stock__c testStock2 = new Stock__c();
        testStock2.Title__c = testTitle.Id;
        testStock2.Status__c = 'Rented';
        insert testStock2;

        Rental__c testRental2 = new Rental__c();
        testRental2.Stock__c = testStock2.Id;
        insert testRental2;

        Test.startTest();

        List<Rental__c> rentals = recommendationListAuraService.getRentalsFromCustomer();

        Test.stopTest();

        System.assertEquals(1, rentals.size(), 'Only one record should have been returned');
    }

    @isTest
    static void getRecommendedTitlesFromGenresList_givenGenres_shouldReturnTitles(){
        Title__c testTitle = new Title__c();
        testTitle.Name = 'Test Movie';
        testTitle.Genre__c = 'Action;Horror';
        insert testTitle;

        Title__c testTitle2 = new Title__c();
        testTitle2.Name = 'Test Movie 2';
        testTitle2.Genre__c = 'Action';
        insert testTitle2;

        Title__c testTitle3 = new Title__c();
        testTitle3.Name = 'Test Movie 3';
        testTitle3.Genre__c = 'Horror';
        insert testTitle3;

        Title__c testTitle4 = new Title__c();
        testTitle4.Name = 'Test Movie 4';
        testTitle4.Genre__c = 'Comedy';
        insert testTitle4;

        List<String> genreList = new List<String>();
        String v1 = 'Action';
        genreList.add(v1);

        Test.startTest();
        
        List<Title__c> titles = recommendationListAuraService.getRecommendedTitlesFromGenresList(genreList);

        Test.stopTest();

        System.assertEquals(2, titles.size(), 'Two titles should have been returned');
    }

    @AuraEnabled
    public static void fullReturnSetup(){
        Title__c testTitle = new Title__c();
        testTitle.Name = 'Test Movie';
        testTitle.Genre__c = 'Action;Horror';
        insert testTitle;

        Stock__c testStock = new Stock__c();
        testStock.Title__c = testTitle.Id;
        testStock.Status__c = 'Rented';
        insert testStock;

        Rental__c testRental = new Rental__c();
        testRental.Stock__c = testStock.Id;
        testRental.Customer__c = UserInfo.getUserId();
        insert testRental;
        
        Stock__c testStock2 = new Stock__c();
        testStock2.Title__c = testTitle.Id;
        testStock2.Status__c = 'Rented';
        insert testStock2;

        Rental__c testRental2 = new Rental__c();
        testRental2.Stock__c = testStock2.Id;
        insert testRental2;

        Title__c testTitle2 = new Title__c();
        testTitle2.Name = 'Test Movie 2';
        testTitle2.Genre__c = 'Action;Comedy';
        insert testTitle2;

        Title__c testTitle3 = new Title__c();
        testTitle3.Name = 'Test Movie 3';
        testTitle3.Genre__c = 'Horror';
        insert testTitle3;

        Title__c testTitle4 = new Title__c();
        testTitle4.Name = 'Test Movie 4';
        testTitle4.Genre__c = 'Comedy';
        insert testTitle4;

    }

    @isTest
    static void recommendationListPopulationTest_givenUser_returnRecommendations(){
        fullReturnSetup();
        List<String> genreList = new List<String>();
        String genreString = '';

        Integer limiter = 5;
        Test.startTest();

        List<Rental__c> rentals = recommendationListAuraService.getRentalsFromCustomer();

        // List<Stock__c> stock = recommendationListAuraService.getStockFromRentals(rentals);

        for(Title__c t : recommendationListAuraService.getTitlesFromRentals(rentals)){
            genreList.addAll(t.Genre__c.split(';'));
        }

        Set<Title__c> titleSet = new Set<Title__c>();
        titleSet.addAll(recommendationListAuraService.getRecommendedTitlesFromGenresList(genreList));

        List<Title__c> titlesUnlimited = new List<Title__c>();
        titlesUnlimited.addAll(titleSet);
        
        List<Title__c> titlesLimited = new List<Title__c>();

        Integer recommendationLimit = Math.min(limiter, titlesUnlimited.size());

        for(Integer i = 0; i < recommendationLimit; i++){
            titlesLimited.add(titlesUnlimited[i]);
        }
        Test.stopTest();

        System.assertEquals(3, titlesLimited.size(), 'Three titles should have been recommended');
    }

    @isTest
    static void getTitleFromRental_givenRental_returnTitle(){
        Title__c testTitle = new Title__c();
        testTitle.Name = 'Test Movie';
        testTitle.Genre__c = 'Action;Horror';
        insert testTitle;

        Stock__c testStock = new Stock__c();
        testStock.Title__c = testTitle.Id;
        testStock.Status__c = 'Rented';
        insert testStock;

        Rental__c testRental = new Rental__c();
        testRental.Stock__c = testStock.Id;
        testRental.Customer__c = UserInfo.getUserId();
        insert testRental;

        List<Title__c> titleList = new List<Title__c>();

        Test.startTest();

        titleList = recommendationListAuraService.getTitleFromRental(testRental);

        Test.stopTest();
        System.assertEquals('Test Movie', titleList[0].Name, 'The movie Test Movie should have been returned');

    }

    @isTest
    static void getRecommendedTitlesFromUser_givenUser_returnRecommendations(){
        fullReturnSetup();

        Integer limiter = 5;
        List<Title__c> recList = new List<Title__c>();

        Test.startTest();

        recList = recommendationListAuraService.getRecommendedTitlesFromUser(limiter);

        Test.stopTest();
        System.assertEquals(3, recList.size(), 'Three titles should have been recommended');

    }
}