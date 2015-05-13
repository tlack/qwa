// web.q - Miscellaneous web development-related functions, usually dealing with
// the drudgery of the HTTP or HTML specs

\d .web

ck.set:{[nam;val]"Set-Cookie: ",str[nam],"=",val,"; expires=Wednesday, 01-Jan-2020 00:00:00 GMT; path=/; domain=",.config.domain};
// transform Cookie: headers into ((c1;v1);(c2;v2)...)
ck.get:{pairs:("=" vs) each "; " vs x; (`$pairs[;0])!(pairs[;1])}

repr:{str[x]}

/ wrap a response in full http regalia
resp:{[hdrs;body]
	b:repr[body];
	r:();
	r,:"HTTP/1.0 200 kk\r\n";
	r,:"Connection: close\r\n";
	r,:"Content-Type:text/html; charset=iso-8859-1\r\n";
	r,:"Content-length: ",(string 2+count b),"\r\n";
	r,:"Cache-Control: max-age=0, no-cache, no-store\r\n";
	r,:"Pragma: no-cache\r\n";
	r,:nl raze hdrs;
	r,"\r\n",b,"\r\n"}

/ routes called with: f[req;headers]
/ req is (`page;(`qs1;`qs2)!("val1";"val2"))
/ headers is table as per .z.ph x[1]
serve:{[routes;dfl;x]
	lastreq::x;
	hdrs:x[1];
	p:.web.url[x[0]];
	/ f:dfl^routes[p[0]]; /'type. why?
	f:$[not null rm:routes p[0];rm;dfl];
	v: f[p;x[1]];
	$[`web~first v;resp[v[1];v[2]];resp[();v]]}

// URLs and Parsing:

// parse /page?name=tom&age=36 into (`page;(`name`age)!("tom";36))
/ read like so: 
/ "?" vs x - split("?", x)
/ x is actually implied - cool feature
/ 2# pads this out to two characters - by repeating, unfortunately
/ TODO fix this; it should pad out with null
/ next, we use ' to turn @' into a function that is applied to 
/ each element of the arugment list (i.e., the right), rather than
/ with one argument (the entire list).
/ @ looks up and applies each element of the function list in turn
url:{(path;qs) @' 2# "?" vs x}

/ massage a path to symbol - normalize path here if needed
path:`$;

/ parse query string into component parts
qs:{if[0~type v:"=" vs x;v;()]}

// private/boring/low level - not interesting to you

nl:{x,"\r\n"}
ml:{r:x;if[not (type x)=10h;r:enlist x]r}
str:{$[10h=(type x);x;.Q.s1[x]]}


