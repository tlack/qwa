if[not `views in tables[]; pageviews:([] at:(); domain:(); ip:(); sess:(); loggedin:())];

\l config.q
\l cookie.q

lastreq:();
mksessid:{.Q.s1[first 1?0Ng]}

logreq:{[req]
	lastreq::req;
	hdrs:req[1];
	show hdrs;
	cookies:.cookie.decode[hdrs[`Cookie]];
	sess:mksessid[];
	`pageviews insert (.z.P; ""; .z.a; ""; 0b);
	resp:();
	resp,:"HTTP/1.0 200 kk\r\n";
	resp,:"Connection: close\r\n";
	resp,:"Content-Type:text/html; charset=iso-8859-1\r\n";
	resp,:"Content-length: 7\r\n";
	resp,:"Cache-Control: max-age=0, no-cache, no-store\r\n";
	resp,:"Pragma: no-cache\r\n";
	resp,:"Set-Cookie: qwas=",sess,"; expires=Wednesday, 01-Jan-2020 00:00:00 GMT; path=/; domain=",.config.domain,"\r\n";
	resp,"\r\n//qwa\r\n"}

boot:{
	oldzph::.z.ph;
	.z.ph:logreq;
	show "booted";}

boot[]

