/ instead of regular insert we send a message to 0 to be sure it's logged
upd:{show(`upd;x;y;type each y);0 ("insert";x;y)}

/ create tables and insert b.s. first value so q knows the types
dfnsess:{
	sessions::([id:()] at:());
	`sessions insert (first 1?0Ng;.z.P)}
dfnpvs:{
	pageviews::([] at:(); domain:(); url:(); ip:(); sess:`sessions$(); loggedin:());
	`pageviews insert (enlist .z.P; `; `; .z.a; 0Ng; 0b)}

if[not `sessions in tables[]; dfnsess[]];
if[not `pageviews in tables[]; dfnpvs[]];




