@isTest
private class RecommendationListAuraServiceTest {
    
    @AuraEnabled
    public static List<Rental__c> getRentalsFromCustomer(){
        return [SELECT Stock__c
                FROM Rental__c
                WHERE Customer__c = :UserInfo.getUserId()];
    }

    @AuraEnabled
    public static List<Title__c> getRecommendedTitlesFromGenresList(List<String> genres){
        List<Title__c> newTitles = new List<Title__c>();
        for(String s : genres){
            newTitles.addAll([SELECT Id, Name, Thumbnail__c, Genre__c
                                FROM Title__c
                                WHERE Genre__c includes (:s)]);
        }
        return newTitles;
    }

    @AuraEnabled
    public static List<Title__c> getRecommendedTitlesFromGenres(String genres){
        return [SELECT Id, Name, Thumbnail__c, Genre__c
                FROM Title__c
                WHERE Genre__c includes (:genres)];
    }

    @AuraEnabled
    public static List<Stock__c> getStockFromRentals(List<Rental__c> rentals){
        List<Stock__c> stocks = new List<Stock__c>();
        for (Rental__c r : rentals) {
            stocks.add([SELECT Id, Name, Title__c
                        FROM Stock__c
                        WHERE Id = :r.Stock__c]);
        }
        return stocks;
    }

    @AuraEnabled
    public static List<Title__c> getTitlesFromStock(List<Stock__c> stock){
        List<Title__c> titles = new List<Title__c>();
        for (Stock__c s : stock) {
            titles.add([SELECT Id, Name, Genre__c
                        FROM Title__c
                        WHERE Id = :s.Title__c]);
        }
        return titles;
    }

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

        List<Rental__c> rentals = getRentalsFromCustomer();

        Test.stopTest();

        System.assertEquals(1, rentals.size(), 'Only one record should have been returned');
    }

    @isTest
    static void getRecommendedTitlesFromGenres_givenGenres_shouldReturnTitles(){
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
        
        List<Title__c> titles = getRecommendedTitlesFromGenresList(genreList);

        Test.stopTest();

        System.assertEquals(2, titles.size(), 'Two titles should have been returned');
    }

    @isTest
    static void recommendationListPopulationTest_givenUser_returnRecommendations(){
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

        List<String> genreList = new List<String>();
        String genreString = '';


        Test.startTest();

        List<Rental__c> rentals = getRentalsFromCustomer();

        List<Stock__c> stock = getStockFromRentals(rentals);

        for(Title__c t : getTitlesFromStock(stock)){
            genreList.addAll(t.Genre__c.split(';'));
        }

        Set<Title__c> titleSet = new Set<Title__c>();
        titleSet.addAll(getRecommendedTitlesFromGenresList(genreList));

        List<Title__c> titles= new List<Title__c>();
        titles.addAll(titleSet);

        Test.stopTest();

        System.assertEquals(3, titles.size(), 'Three titles should have been recommended');
    }

}
