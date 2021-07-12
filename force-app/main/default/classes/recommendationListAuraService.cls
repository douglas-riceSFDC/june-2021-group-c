public with sharing class recommendationListAuraService {
    
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
            newTitles.addAll([SELECT Id, Name, Thumbnail__c, Genre__c, Available_Stock__c, Total_Stock__c
                                FROM Title__c
                                WHERE Genre__c includes (:s)]);
        }
        return newTitles;
    }

    @AuraEnabled
    public static List<Title__c> getRecommendedTitlesFromGenres(String genre){
        return [SELECT Id, Name, Thumbnail__c, Genre__c
                FROM Title__c
                WHERE Genre__c includes (:genre)];
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
    public static List<Title__c> getTitlesFromStock(List<Stock__c> stocks){
        List<Title__c> titles = new List<Title__c>();
        for (Stock__c s : stocks) {
            titles.add([SELECT Id, Name, Genre__c
                        FROM Title__c
                        WHERE Id = :s.Title__c]);
        }
        return titles;
    }

    @AuraEnabled
    public static List<Title__c> getRecommendedTitlesFromUser(Integer limiter){

        List<Stock__c> stock = getStockFromRentals(getRentalsFromCustomer());

        List<String> genreList = new List<String>();

        for(Title__c t : getTitlesFromStock(stock)){
            genreList.addAll(t.Genre__c.split(';'));
        }

        Set<Title__c> titleSet = new Set<Title__c>();
        titleSet.addAll(getRecommendedTitlesFromGenresList(genreList));

        List<Title__c> titlesUnlimited = new List<Title__c>();
        titlesUnlimited.addAll(titleSet);

        List<Title__c> titlesLimited = new List<Title__c>();
        Integer recommendationLimit = Math.min(limiter, titlesUnlimited.size());

        for(Integer i = 0; i < recommendationLimit; i++){
            titlesLimited.add(titlesUnlimited[i]);
        }
        // titles.addAll(titleSet);
        return titlesLimited;
    }
}
