var body, canvas, color, ctx, grad, canvasAdjust=true;
canvas = document.getElementsByTagName("canvas")[0];
ctx = null;
grad = null;
body = document.getElementsByTagName("body")[0];
color = 255;
if (canvas.getContext("2d")) {
  var w = canvas.width;
  var h = canvas.height;
  ctx = canvas.getContext("2d");
  ctx.clearRect(0, 0, w, h);
  ctx.save();
  grad = ctx.createRadialGradient(0, 0, 0, 0, 0, w);
  grad.addColorStop(0, "#eee");
  grad.addColorStop(1, "rgb(" + color + ", " + color + ", " + color + ")");
  ctx.fillStyle = grad;
  ctx.fillRect(0, 0, w, h);
  ctx.save();
  body.onmousemove = function(event) {
    if (canvasAdjust) {
      var height, rx, ry, width, x, xc, y, yc;
      width = window.innerWidth;
      height = window.innerHeight;
      x = event.clientX;
      y = event.clientY;
      rx = w * x / width;
      ry = h * y / height;
      xc = ~~(256 * x / width);
      yc = ~~(256 * y / height);
      grad = ctx.createRadialGradient(rx, ry, 0, rx, ry, w);
      grad.addColorStop(0, "#fff");
      grad.addColorStop(1, ["rgb(", xc, ", ", 255 - xc, ", ", yc, ")"].join(""));
      ctx.fillStyle = grad;
      return ctx.fillRect(0, 0, w, h);
    }
  };

  body.onclick = function(event) {
    if (canvasAdjust) {
      canvasAdjust = false;
    }
    else {
      canvasAdjust = true;
    }
  };

}