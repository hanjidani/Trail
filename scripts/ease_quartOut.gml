///ease_quartOut(start,end,current time, total time);
var b = argument0, e = argument1, //start value, end value
    t = argument2, d = argument3, //current time, duration
    c = e - b; //change

t /= d;
t--;
return -c * (t*t*t*t - 1) + b;
