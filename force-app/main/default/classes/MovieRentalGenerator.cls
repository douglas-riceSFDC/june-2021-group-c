public with sharing class MovieRentalGenerator {
    public MovieRentalGenerator() {

    }

    public void generateRentalForMovie(Id movieId){

        //Find Available Stock for Movie
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
