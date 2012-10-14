begin;
	select plan(1);

select results_eq(
	$want$
	SELECT path, ST_AsText(geom) 
	FROM (
	  SELECT (dp.ST_DumpPoints(g.geom)).* 
	  FROM
	    (SELECT 
	       'POINT (0 9)'::geometry AS geom
	    ) AS g
	  ) j;
	$want$,
	$have$
	values ('{1}'::int[], 'POINT(0 9)');
	$have$,
	'single point'
);

select finish();

rollback;
\q

