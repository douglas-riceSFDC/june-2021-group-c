@isTest
private class MovieRentalGeneratorTest {
    
    @TestSetup
    static void setupStockData(){
        Title__c testTitle = new Title__c();
        testTitle.Name = 'Test Movie';
        insert testTitle;

        Stock__c testStock = new Stock__c();
        testStock.Title__c = testTitle.Id;
        testStock.Status__c = 'Available';
        insert testStock;

        Stock__c testStock2 = new Stock__c();
        testStock2.Title__c = testTitle.Id;
        testStock2.Status__c = 'Available';
        insert testStock2;

        Stock__c testStock3 = new Stock__c();
        testStock3.Title__c = testTitle.Id;
        testStock3.Status__c = 'Rented';
        insert testStock3;    
    }
    
    @isTest
    static void getAllAvailableStockForTitle_givenId_returnAvailableStock(){

        Title__c testTitle = [SELECT Id, Name FROM Title__c WHERE Name = 'Test Movie'];

        Test.startTest();

        List<Stock__c> results = StockAuraService.getAllAvailableStockForTitle(testTitle.Id);

        Test.stopTest();

        System.assertEquals(2, results.size(), 'Two Stock should have been returned.');

    }

    @isTest
    static void getAllChildStockForTitle_givenId_returnAllStock(){

        Title__c testTitle = [SELECT Id, Name FROM Title__c WHERE Name = 'Test Movie'];

        Test.startTest();

        List<Stock__c> results = StockAuraService.getAllChildStockForTitle(testTitle.Id);

        Test.stopTest();

        System.assertEquals(3, results.size(), 'Three Stock should have been returned.');

    }

    @isTest
    static void generateRentalForMovie_givenId_generateNewRental(){
        Title__c testTitle = [SELECT Id, Name FROM Title__c WHERE Name = 'Test Movie'];

        Test.startTest();

        List<Stock__c> availableStock = StockAuraService.getAllAvailableStockForTitle(testTitle.Id);

        Stock__c rentedStock = availableStock[0];
        rentedStock.Status__c = 'Rented';
        update rentedStock;

        Test.stopTest();

        List<Rental__c> generatedRentals = [SELECT Id, Name, Stock__c, Customer__c, Due_Date__c FROM Rental__c];

        System.assertEquals(1, generatedRentals.size(), 'A rental should have been generated');

    }

    @isTest
    static void generateRentalForMovie_givenIdWithNoAvailableStock_generateError(){
        Title__c testTitle = new Title__c();
        testTitle.Name = 'Test Movie 2';
        insert testTitle;

        Stock__c testStock3 = new Stock__c();
        testStock3.Title__c = testTitle.Id;
        testStock3.Status__c = 'Rented';
        insert testStock3;  

        Test.startTest();

        Exception unexpectedException; 

        try{
            List<Stock__c> availableStock = StockAuraService.getAllAvailableStockForTitle(testTitle.Id);
            if(availableStock.isEmpty()){
                throw new System.NoDataFoundException(); 
            }
            Stock__c rentedStock = availableStock[0];
            rentedStock.Status__c = 'Rented';
            update rentedStock;
        }
        catch(Exception e){
            unexpectedException = e;
        }

        Test.stopTest();

        System.assertNotEquals(null, unexpectedException, 'An exception should have been thrown');

    }

}
