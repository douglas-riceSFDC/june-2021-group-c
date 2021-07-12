public with sharing class MovieRentalGenerator {
    public MovieRentalGenerator() {

    }

    @AuraEnabled
    public static void generateRentalForMovie(Id movieId){

        List<Stock__c> availableStock = StockAuraService.getAllAvailableStockForTitle(movieId);

        if(availableStock.isEmpty()){
            throw new NoDataFoundException(); 
        }
        Stock__c rentedStock = availableStock[0];
        rentedStock.Status__c = 'Rented';
        update rentedStock;

        return;
    }


}
