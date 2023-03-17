global class PokeBatch implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
    private static List<Pokemon__c> pokeList = new List<Pokemon__c>();
    public static Pokemon__c pokeObject = new Pokemon__c();
    public String query = 'Select ID,FirstName, LastName, Email, Name from Contact LIMIT 9';
    public Integer pokemonId = 1;
    global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug('pokemon Id' + pokemonId);
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Contact> records) {   
        String endpoint;
        System.debug('pokemon Id' + pokemonId);
        for (integer i = 1; i <= records.size(); i++ ) {
            for(Integer j = 1; j <= 100 && pokemonId <= 900; j++) {
              try {
                Pokemon poke = new Pokemon();
                HttpRequest req = new HttpRequest();
                HttpResponse res = new HttpResponse();
                Http http = new Http();
                endpoint = 'https://pokeapi.co/api/v2/pokemon/' + pokemonId + '/';
                req.setEndpoint(endpoint);
                req.setMethod('GET');
                res = http.send(req);
                //String Response = res.getBody();
                if(res.getStatusCode() == 200){
                poke = (Pokemon) JSON.deserialize(res.getBody(), Pokemon.Class);
                
                pokeList.add(new Pokemon__c(Name = poke.name, PokeIndex__c = poke.id, Height__c = String.valueOf(poke.height/10 + 'mt'), Weight__c = String.valueOf(poke.weight/10 + 'kg'),
                                           Photo__c = poke.sprites.front_default));

/*
    if (poke.id <= 151){
      poke.Generation__c = 1;
    } else if (poke.id >= 152 && poke.id <= 251) {
      poke.Generation__c = 2;
    } else if (poke.id >= 252 && poke.id <= 386) {
      poke.Generation__c = 3;
    } else if (poke.id >= 387 && poke.id <= 493) {
      poke.Generation__c = 4;
    } else if (poke.id >= 494 && poke.id <= 649) {
      poke.Generation__c = 5;
    } else if (poke.id >= 650 && poke.id <= 721) {
      poke.Generation__c = 6;
    } else if (poke.id >= 722 && poke.id <= 809) {
      poke.Generation__c = 7;
    } else if (poke.id >= 810) {
      poke.Generation__c = 8;
    }    
        
                    
    /*for (Integer p = 0; i < poke.types.size(); p++) {
      pokeObject.Type__c = pokeObject.Type__c == null 
        ? poke.types[i].type.name
        : pokeObject.Type__c + ';' + poke.types[i].type.name;
      }*/           

            } else {
                System.debug('Falha ao carregar: ' + res.getStatusCode());  
            }
              
                System.debug('pokemon Id' + pokemonId);
                System.debug('Response:' + res.getBody());      
                           
              }
              catch (Exception e) {       
                System.debug('Error is :' + e.getMessage() + 'LN:' + e.getLineNumber());         
              }
              pokemonId++;
            }
            insert pokeList;
        }
    } 
  public class Pokemon {
  public Integer height;
  public Integer id;
  public String name;
  public String url;
  public Integer order;
  public Integer weight;
  public sprites sprites = new sprites();
  public List<types> types = new List<types>();
  }
    public class sprites {
        public String front_default;
    }
    public class types {
      public cls_type type = new cls_type();
    } 
    public class cls_type {
      public Integer slot;
      public String name;
    }
    global void finish(Database.BatchableContext BC){ }
}