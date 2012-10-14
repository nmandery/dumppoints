begin;
	select plan(1);

select results_eq(
	$have$
	SELECT path, ST_AsText(geom) 
	FROM (
	  SELECT (dp.ST_DumpPoints(g.geom)).* 
	  FROM
	    (SELECT 
	       'LINESTRING (
			0 0, 
			0 9, 
			9 9, 
			9 0, 
			0 0
		    )'::geometry AS geom
	    ) AS g
	  ) j;
	$have$,
	$want$
		values 
		('{1}'::int[], 'POINT(0 0)'),
		('{2}'::int[], 'POINT(0 9)'),
		('{3}'::int[], 'POINT(9 9)'),
		('{4}'::int[], 'POINT(9 0)'),
		('{5}'::int[], 'POINT(0 0)');
	$want$,
	'linestring'
);

select finish();

rollback;
\q

