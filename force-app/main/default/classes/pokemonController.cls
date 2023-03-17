public with sharing class pokemonController {
  @AuraEnabled(Cacheable=true)
  public static Pokemon__c[] getAllPokemons() {
    return [
      SELECT
        Id,
        Name,
        Height__c,
        Weight__c,
        Generation__c,
        Type__c,
        Photo__c,
        PokeIndex__c
      FROM Pokemon__c
      WITH SECURITY_ENFORCED
      ORDER BY PokeIndex__c
      LIMIT 899
    ];
  }

  @AuraEnabled(Cacheable=true)
  public static Pokemon__c[] searchPokemons(
    String type,
    Integer generation,
    String searchTerm
  ) {
    // Return all pokemons when no search term
    searchTerm = searchTerm.trim();

    searchTerm = '%' + searchTerm + '%';

    String query = 'SELECT Id, Name, Height__c, Weight__c, Generation__c, Type__c, Photo__c, PokeIndex__c FROM Pokemon__c';

    if (searchTerm != '') {
      query += ' WHERE Name LIKE :searchTerm ';
    }
    if (type != 'Todos') {
      query += ' AND Type__c INCLUDES(:type) ';
    }
    if (generation != 0) {
      query += ' AND Generation__c =:generation ';
    }
    query += ' ORDER BY PokeIndex__c';

    return Database.query(query);
  }
}