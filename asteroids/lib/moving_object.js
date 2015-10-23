(function () {

  if (typeof window.Asteroids === 'undefined') {
    window.Asteroids = {};
  }

  var Asteroids = window.Asteroids;

  var MovingObject = Asteroids.MovingObject = function (params) {
    this.pos = params.pos;
    this.vel = params.vel;
    this.radius = params.radius;
    this.color = params.color;
    this.game = params.game;
  };


  MovingObject.prototype.draw = function (ctx) {
    ctx.fillStyle = this.color;
    ctx.beginPath();

    ctx.arc(
      this.pos[0],
      this.pos[1],
      this.radius,
      0,
      2 * Math.PI,
      false
    );

    ctx.fill();
  };

  MovingObject.prototype.move = function () {
    this.pos[0] += this.vel[0];
    this.pos[1] += this.vel[1];

    if (this.game.isOutOfBounds(this.pos)) {
      if (this instanceof Asteroids.Bullet) {
        this.game.remove(this);
      }
    }

    if (this instanceof Asteroids.Asteroid) {
      this.pos = this.game.wrap(this.pos);
    }
  };

  MovingObject.prototype.isCollidedWith = function (otherObject) {
    return (this.radius + otherObject.radius > Asteroids.Util.objDistance(this.pos, otherObject.pos));
  };

  MovingObject.prototype.collideWith = function (otherObject) {
    if (otherObject instanceof Asteroids.Ship) {
      otherObject.relocate();
    } else if (otherObject instanceof Asteroids.Bullet) {
      this.game.remove(this);
      this.game.remove(otherObject);
    }
  };

})();
