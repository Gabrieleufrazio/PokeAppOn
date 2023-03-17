import { NavigationMixin } from "lightning/navigation";
import { LightningElement, wire } from "lwc";
import searchPokemons from "@salesforce/apex/pokemonController.searchPokemons";
export default class pokemonList extends NavigationMixin(LightningElement) {
  type = "Todos";
  generation = "0";
  searchTerm = "";
  @wire(searchPokemons, {
    type: "$type",
    generation: "$generation",
    searchTerm: "$searchTerm"
  })
  pokemons;

  // Filtros generation e types
  get types() {
    return [
      { label: "Todos", value: "Todos" },
      { label: "Normal", value: "Normal" },
      { label: "Fighting", value: "Fighting" },
      { label: "Flying", value: "Flying" },
      { label: "Poison", value: "Poison" },
      { label: "Ground", value: "Ground" },
      { label: "Bug", value: "Bug" },
      { label: "Ghost", value: "Ghost" },
      { label: "Steel", value: "Steel" },
      { label: "Fire", value: "Fire" },
      { label: "Water", value: "Water" },
      { label: "Grass", value: "Grass" },
      { label: "Electric", value: "Electric" },
      { label: "Psychic", value: "Psychic" },
      { label: "Ice", value: "Ice" },
      { label: "Dragon", value: "Dragon" },
      { label: "Dark", value: "Dark" },
      { label: "Fairy", value: "Fairy" },
      { label: "Rock", value: "Rock" }
    ];
  }

  get generations() {
    return [
      { label: "Todos", value: "0" },
      { label: "One", value: "1" },
      { label: "Two", value: "2" },
      { label: "Three", value: "3" },
      { label: "Four", value: "4" },
      { label: "Five", value: "5" },
      { label: "Six", value: "6" },
      { label: "Seven", value: "7" },
      { label: "Eight", value: "8" }
    ];
  }

  handleSearchTermChange(event) {
    window.clearTimeout(this.delayTimeout);
    const searchTerm = event.target.value;
    this.delayTimeout = setTimeout(() => {
      this.searchTerm = searchTerm;
    }, 300);
  }
  handleGenerationChange(event) {
    window.clearTimeout(this.delayTimeout);
    const generation = event.target.value;
    this.delayTimeout = setTimeout(() => {
      this.generation = generation;
    }, 300);
  }

  handleTypeChange(event) {
    window.clearTimeout(this.delayTimeout);
    const type = event.target.value;
    this.delayTimeout = setTimeout(() => {
      this.type = type;
    }, 300);
  }

  get hasResults() {
    console.log(this.pokemons);
    return this.pokemons.data.length > 0;
  }
  handlePokemonView(event) {
    const pokemonId = event.detail;
    this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        recordId: pokemonId,
        objectApiName: "Pokemon__c",
        actionName: "view"
      }
    });
  }
}