\d .config

domain:"pop.co";
loggedincookie:"pop_weasel";

/ visiting this url generates a stats report
/ defaults to "stats-{hostname}"
/ so if your machine is web01, the url is /stats-web01
url.stats:`$("stats-",string .z.h)
