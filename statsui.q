\d .statsui

decode:{[k;v]
	/show(`decode;k;v);
	$[`ip~k;.Q.host[v];v]}

header:{[row]
	/show(`header;row);
	"<thead><tr>",({"<th>",(string x),"</th>"}each key row),"</tr></thead>"}

render:{[pageviews;req;hdrs;viewcfg]
	/show(`render;pageviews;req;hdrs;viewcfg);
	rows:viewcfg[1][pageviews;req;hdrs];
	"<section><h2>",viewcfg[0],"</h2>",table[rows]}

row:{[r]
	"<tr>",(raze {[x;r]"<td>",(string decode[x;r[x]]),"</td>"}[;r] each key r),"</tr>"}

table:{[rows]
	/show(`table;rows);
	"<table>",(raze header first rows),(raze row each rows),"</table>"}

handler:{[pageviews;req;hdrs]
	/show(`handler;pageviews;req;hdrs);
	(`web;();
		"<!doctype html><html><head><title>qwa reports</title></head>",
		"<body>",(raze render[pageviews;req;hdrs] each V),"</body></html>")}

V:()

V,:enlist ("Top domains (last 24hr)";{[pageviews;req;hdrs]
	pageviews:`.[`pageviews];
	result: select[100;>nview] first domain,nview:count domain,nuniq:count distinct ip by domain from pageviews where (.z.P-at)<1D;
	show (`topdomains;result);
	result});

V,:enlist ("Most recent page views";{[pageviews;req;hdrs]
	pageviews:`.[`pageviews];
	result: select[100;>at] at,domain,ip from pageviews;
	show (`lastpageviews;result);
	result});

