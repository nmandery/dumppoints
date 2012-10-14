begin;
	select plan(1);

select results_eq(
	$have$
	SELECT path, ST_AsText(geom) 
	FROM (
	  SELECT (dp.ST_DumpPoints(g.geom)).* 
	  FROM
	    (SELECT 
	       'POLYGON ((
			0 0, 
			0 9, 
			9 9, 
			9 0, 
			0 0
		    ))'::geometry AS geom
	    ) AS g
	  ) j;
	$have$,
	$want$
	    values 
		('{1,1}'::int[], 'POINT(0 0)'),
		('{1,2}'::int[], 'POINT(0 9)'),
		('{1,3}'::int[], 'POINT(9 9)'),
		('{1,4}'::int[], 'POINT(9 0)'),
		('{1,5}'::int[], 'POINT(0 0)');
	$want$,
	'polygon'
);

select finish();

rollback;
\q

