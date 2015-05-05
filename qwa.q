lastreq:();

\l schema.q
\l config.q
\l web.q

lastreq:();
mksessid:{.Q.s1[first 1?0Ng]}

stats:{show `stats;count pageviews}

logreq:{
	lastreq::x;
	hdrs:x[1];
	p:.web.url[x[0]];
	if[p[0]~.config.url.stats;:stats[]];
	cookies:.web.ck.decode[hdrs[`Cookie]];
	sess:mksessid[];
	`pageviews insert (.z.P; ""; `$x[0]; .z.a; sess; 0b);
	.web.resp[enlist .web.ck.set["qwas";sess];"//qwa"]}

boot:{
	oldzph::.z.ph;
	.z.ph:logreq;
	show "booted";}

boot[]

