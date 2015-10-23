var myUniq = function (array) {
  var uniqArray = [];
  var uniqNums = {};

  for (var i = 0; i < array.length; i++) {
    if (!uniqNums[array[i]]) {
      uniqArray.push(array[i]);
      uniqNums[array[i]] = true;
    }
  }

  return uniqArray;
};

var twoSum = function (array) {
  var difference = {};
  var result = [];

  for (var i = 0; i < array.length; i++) {
    if (difference[0 - array[i]] !== undefined) {
      result.push([difference[0 - array[i]], i]);
    } else {
      difference[array[i]] = i;
    }
  }

  return result.sort();
};

var myTranspose = function(matrix) {
  var newMatrix = [];
  rows = matrix.length;
  columns = matrix[0].length;
  for (var row = 0; row < rows; row++) {
    for (var column = 0; column < columns; column++) {
      if (newMatrix[column] === undefined) {
        newMatrix[column] = [];
      }
      newMatrix[column].push(matrix[row][column]);
    }
  }
  return newMatrix;
};

Array.prototype.myEach = function(callback) {
  for (var i = 0; i < this.length; i++) {
    callback(this[i], i, this);
  }
};

Array.prototype.myMap = function(callback) {
  var newArray = [];
  this.myEach(function (el, index, array) {
    newArray.push(callback(el))
  });
  return newArray;
};

Array.prototype.myInject = function(callback, acc) {
  arr = this;
  if (acc === undefined) {
    acc = this[0];
    arr = this.slice(1);
  }
  arr.myEach (function (el, index, array) {
    acc = callback(acc, el);
  });
  return acc;
};

Array.prototype.select = function(callback) {
  var result = [];
  this.myEach(function(el) {
    if (callback(el)) {
      result.push(el);
    }
  });
  return result;
}
