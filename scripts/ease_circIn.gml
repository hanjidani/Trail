///ease_circIn(start,end,current time, total time);
var b = argument[0], e = argument[1], //start value, end value
    t = argument[2], d = argument[3], //current time, duration
    c = e - b; //change

t /= d;
return -c * (sqrt(1 - t*t) - 1) + b;
