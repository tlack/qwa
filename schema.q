/ if[not `views in tables[]; pageviews:([] at:(); domain:(); ip:(); sess:(); loggedin:())];
tbls:()!()
tbls[`pageviews]:([] at:(); domain:(); url:(); ip:(); sess:(); loggedin:());

/ build tables in . if they dont exist
{n:tbls?x;if[not n in tables[];n set 0#x]} each tbls;

