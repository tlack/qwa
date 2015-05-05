// web.q - Miscellaneous web development-related functions, usually dealing with
// the drudgery of the HTTP or HTML specs

\d .web

ck.set:{[nam;val]"Set-Cookie: ",nam,"=",val,"; expires=Wednesday, 01-Jan-2020 00:00:00 GMT; path=/; domain=",.config.domain};
// decode Cookie: headers into ((c1;v1);(c2;v2)...)
ck.decode:{("=" vs) each "; " vs x}

/ i could have sworn i saw this in the q source somewhere
repr:{x};

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
str:{if[type x=10h;enlist x;if[-11h=type x;string x;x]]}

