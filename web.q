// web.q - Miscellaneous web development-related functions, usually dealing with
// the drudgery of the HTTP or HTML specs

\d .web

// decode Cookie: headers into ((c1;v1);(c2;v2)...)
cookie.decode:{("=" vs) each "; " vs x}

path:`$;
qs:{"=" vs x}
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

