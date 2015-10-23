function Student(fname, lname) {
  this.fname = fname;
  this.lname = lname;
  this.enrolledCourses = [];
}

Student.prototype.name = function() {
  return this.fname + " " + this.lname;
};

Student.prototype.courses = function() {
  return this.enrolledCourses;
};

Student.prototype.enroll = function(course) {

  if(this.enrolledCourses.indexOf(course) !== -1) {
    this.enrolledCourses.push(course);
    course.enrolledStudents.push(this);
  }
};

Student.prototype.courseLoad = function () {
  var courseInfo = {};

  this.enrolledCourses.forEach (function (course) {
    if (courseInfo[course.department] === undefined) {
      courseInfo[course.department] = course.credits;
    } else {
      courseInfo[course.department] += course.credits;
    }
  });

  return courseInfo;
};


function Course(name, department, credits, block, days) {
  this.name = name;
  this.department = department;
  this.credits = credits;
  this.enrolledStudents = [];
  this.days = days;
  this.block = block;
}

Course.prototype.students = function() {
  return this.enrolledStudents;
};

Course.prototype.addStudent = function(student) {
  student.enroll(this);
};

Course.prototype.isConflictsWith = function (newCourse) {
  var self = this;
  var conflicts = false;
  newCourse.days.forEach (function (day) {
    if (self.days.indexOf(day) !== -1 && newCourse.block === self.block) {
      conflicts = true;
    }
  });

  return conflicts;
};

var firstCourse = new Course("a", "sci", 2, 1, ["mon", "tue"]);
var secondCourse = new Course("b", "sci", 3, 1, ["mon", "fri"]);
