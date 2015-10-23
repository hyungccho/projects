function range (start, finish) {
  if (finish <= start) {
    return [];
  }

  return [start].concat(range(start + 1, finish));
}

function exp (b, n) {
  if (n === 0) {
    return 1;
  }

  return b * exp(b, n - 1);
}

function fibonacci (n) {
  if (n <= 2) {
    return [1, 1];
  }

  var prev = fibonacci(n - 1);
  return prev.concat([prev[prev.length - 1] + prev[prev.length - 2]]);
}

function bsearch(arr, target, start, finish) {
  start = (start === undefined) ? 0 : start;
  finish = (finish === undefined) ? arr.length : finish;

  if (start > finish) {
    return null;
  }

  var mid = Math.floor((finish + start)/2);
  var midValue = arr[mid];

  if (midValue === target) {
    return mid;
  } else if (target > midValue) {
    return bsearch(arr, target, mid + 1, finish);
  } else if (target < midValue) {
    return bsearch(arr, target, 0, mid - 1);
  }
}

Array.prototype.merge = function (arr2) {
  var merged = [];

  while (this.length > 0 && arr2.length > 0) {
    if (this[0] > arr2[0]) {
      merged.push(arr2.shift());
    } else if (this[0] <= arr2[0]) {
      merged.push(this.shift());
    }
  }
  merged = merged.concat(this);
  return merged.concat(arr2);
};

Array.prototype.mergeSort = function () {
  if (this.length === 1) {
    return this;
  }

  var mid = Math.floor((this.length)/2);
  var left = this.slice(0,mid).mergeSort();
  var right = this.slice(mid).mergeSort();

  return left.merge(right);
};

function subSets(array) {
  if (array.length === 0) {
    return [[]];
  }
  var last_element = array[array.length - 1];
  var smaller_subsets = subSets(array.slice(0,array.length-1));
  var larger_subsets = [];

  smaller_subsets.forEach(function(subset) {
    larger_subsets.push(subset.concat([last_element]));
  });

  return smaller_subsets.concat(larger_subsets);
}

console.log(subSets([1, 2, 3]));
