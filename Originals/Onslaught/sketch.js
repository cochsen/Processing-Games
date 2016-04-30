var player;
var bdroid;
var h, w;

function setup() {
    createCanvas(800, 600);
    h = 600;
    w = 800;
    player = new Player(width / 8, height / 2);
    bdroid = new BasicDroid(width * 7 / 8, height / 2);
}

function draw() {
    background('#000');
    player.displayBasic();
    bdroid.displayBasic();
}

function Player(x, y) {

    // position
    this.xpos = x;
    this.ypos = y;

    // colors
    this.c1 = color('#000');        // outline
    this.c2 = color('#D59071');     // fill 1
    this.c3 = color('#EEE');        // fill 2

    this.displayBasic = function () {
        push();
        translate(this.xpos, this.ypos);
        this.drawBasicPlayer();
        pop();
    }

    this.drawBasicPlayer = function () {
        stroke(this.c2);
        fill(this.c2);
        rect(0, 0, 6, 6);
        rect(0, 12, 6, 22);
        beginShape();
        vertex(-4, 12);
        vertex(12, 12);
        vertex(3, 18);
        vertex(-4, 12);
        endShape();
        rect(-6, 15, 2, 6);
        rect(10, 15, 2, 6);
        beginShape();
        vertex(0, 35);
        vertex(10, 35);
        vertex(10, 33);
        vertex(0, 30);
        endShape();
    }

}

function BasicDroid(x, y) {

    // position
    this.xpos = x;
    this.ypos = y;

    // colors
    this.c1 = color('#000');        // outline
    this.c2 = color('#952C0A');     // fill 1
    this.c3 = color('#EEE');        // fill 2

    this.displayBasic = function () {
        push();
        translate(this.xpos, this.ypos);
        this.drawBasic();
        pop();
    }

    this.drawBasic = function () {
        stroke(this.c2);
        fill(this.c2);
        rect(0, 0, 12, 18);
        rect(12, 4, 2, 8);
        rect(12, 8, 8, 4);
        rect(18, 8, 2, 12);
        rect(0, 8, -8, 4);
        rect(-6, 8, -2, 12);
        rect(0, 18, 2, 12);
        rect(10, 18, 2, 12);
        rect(-2, 30, 4, 2);
        rect(8, 30, 4, 2);
    }
}