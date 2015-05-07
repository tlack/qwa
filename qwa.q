\l config.q
\l schema.q
\l web.q

lastreq:();
mksessid:{.Q.s1[first 1?0Ng]}

noop:{[r;h]""}
stats:{[r;h]count pageviews}

logreq:{[req;hdrs]
	cookies:.web.ck.decode[hdrs[`Cookie]];
	sess:mksessid[];
	`pageviews insert (.z.P; ""; req[0]; .z.a; sess; 0b);
	(`web;enlist .web.ck.set["qwas";sess];"//qwa")}

boot:{
	oldzph::.z.ph;
	routes:()!();
	routes[.config.url.stats]:stats;
	routes[`favicon.ico]:noop; / >:o cant believe this is a thing
	.z.ph:.web.serve[routes;logreq];
	show "booted";}

boot[]

