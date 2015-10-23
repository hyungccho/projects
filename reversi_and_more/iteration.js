Array.prototype.bubbleSort = function() {
  var sorted = false;
  var finish = this.length - 1;
  while (!sorted) {
    sorted = true;
    for(var i = 0; i < finish; i++) {
      if(this[i] > this[i+1]) {
        sorted = false;
        var temp = this[i+1];
        this[i+1] = this[i];
        this[i] = temp;
      }
    }
    finish--;
  }
  return this;
};

String.prototype.substrings = function() {
  var result = [];

  for (var i = 0; i < this.length; i++) {
    for (var j = i + 1; j <= this.length; j++) {
      result.push(this.slice(i, j));
    }
  }

  return result;
};
