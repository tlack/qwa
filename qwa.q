\l config.q
\l schema.q /table dfns and upd[]
\l web.q

lastreq:();
mksessid:{s:first 1?0Ng;upd[`sessions;(s;.z.P)];s}

noop:{[r;h]""} /no-logging handler for URLs we dont want to track
stats:{[r;h]count pageviews}

logreq:{[req;hdrs]
	cookies:.web.ck.decode[hdrs[`Cookie]];
	sess:mksessid[];
	upd[`pageviews;(.z.P; `$hdrs[`Host]; req[0]; .z.a; `sessions$sess; 0b)];
	(`web;enlist .web.ck.set["qwas";string sess];"//qwa")}

boot:{
	oldzph::.z.ph;
	routes:()!();
	routes[.config.url.stats]:stats;
	routes[`favicon.ico]:noop; / >:o cant believe this is a thing
	.z.ph:.web.serve[routes;logreq];
	show "booted";}

boot[]

