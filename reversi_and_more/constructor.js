function Cat (name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function () {
  return this.owner + " loves " + this.name;
};

var breakfast = new Cat("Breakfast", "Ned");
var curie = new Cat("Curie", "Ned");

Cat.prototype.cuteStatement = function () {
  return "Everyone loves " + this.name;
};

Cat.prototype.meow = function () {
  return "All cats say meow";
};


breakfast.meow = function() {
  return this.name + " meows";
};
console.log(breakfast.meow());
