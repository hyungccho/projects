function Clock () {
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS
  var hours = this.currentTime.getHours();
  var minutes = this.currentTime.getMinutes();
  var seconds = this.currentTime.getSeconds();

  console.log(hours + ":" + minutes + ":" + seconds);
};

Clock.prototype.run = function () {
  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
  this.currentTime = new Date();
  this.printTime();

  setInterval(this._tick.bind(this), Clock.TICK);
};

Clock.prototype._tick = function () {
  // 1. Increment the currentTime.
  // 2. Call printTime.
  this.currentTime.setMilliseconds(Clock.TICK);
  this.printTime();
};

var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers (sum, numsLeft, completionCallback) {
  if (numsLeft > 0) {
    reader.question("Enter a number:  ", function (numString1) {
      var num = parseInt(numString1);

      sum += num;
      console.log(sum);
      addNumbers(sum, numsLeft - 1, completionCallback);
    });
  } else {
    completionCallback(sum);
  }
}

// addNumbers(0, 3, function (sum) {
//   console.log("Total Sum: " + sum);
// });

function askIfGreaterThan(el1, el2, callback) {
  reader.question("Is " + el1 + " greater than " + el2 + "?", function (response) {
    if (response === "yes") {
      callback(true);
    } else {
      callback(false);
    }
  });
}

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i < (arr.length - 1)) {
    askIfGreaterThan(arr[i], arr[i + 1], function (isGreaterThan) {
      if (isGreaterThan) {
        var holder = arr[i];
        arr[i] = arr[i + 1];
        arr[i + 1] = holder;
        madeAnySwaps = true;
      }
      innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outerBubbleSortLoop);
    });
  } else if (i === (arr.length - 1)) {
    outerBubbleSortLoop(madeAnySwaps);
  }
}

function absurdBubbleSort (arr, sortCompletionCallback) {
  function outerBubbleSortLoop (madeAnySwaps) {
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    }
    else {
      sortCompletionCallback(arr);
    }
  }
  outerBubbleSortLoop(true);
}

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
