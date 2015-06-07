\l config.q
\l schema.q /table dfns and upd[]
\l statsui.q
\l web.q

\c 9999 9999

lastreq:();
mksessid:{s:first -1?0Ng;show(`newsess;s);upd[`sessions;(s;.z.P)];s}

noop:{[r;h]""} /no-logging handler for URLs we dont want to track
stats:{[r;h]count pageviews}

gethost:{
	p:x[1];
	dbg:(p`h;y`Host);
	show(`gethost;dbg;type each dbg);
	`$$[`h in key p;p`h;y`Host]}

logreq:{[req;hdrs]
	url:req[0];params:req[1];
	cookies:.web.ck.get[hdrs[`Cookie]];
	/ show (`cookies;cookies);
	sess:$[not (sess in key sessions) or null~sess:"G"$cookies `qwas;mksessid[];sess];
	/ show (`sess;sess);
	show(`req;req;hdrs);
	ip:.web.ip[hdrs];
	host:gethost[req;hdrs];
	show(`reqh;host);
	loggedin:(`$.config.loggedincookie) in key cookies;
	upd[`pageviews;(.z.P; host; url; ip; `sessions$sess; loggedin)];
	/ show (`pageviews;pageviews);
	(`web;enlist .web.ck.set[`qwas;string sess];"//qwa")}

boot:{
	oldzph::.z.ph;
	routes:()!();
	routes[.config.url.stats]:.statsui.handler[pageviews];
	routes[`favicon.ico]:noop; / >:o cant believe this is a thing
	.z.ph:.web.serve[routes;logreq];
	show "booted";}

boot[]

