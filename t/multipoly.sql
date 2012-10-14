begin;
	select plan(1);

select results_eq(
	$have$
	SELECT path, ST_AsText(geom) 
	FROM (
	  SELECT (dp.ST_DumpPoints(g.geom)).* 
	  FROM
	    (SELECT 
	       'MULTIPOLYGON (((
			0 0, 
			0 3, 
			4 3, 
			4 0, 
			0 0
		    )), ((
			2 4, 
			1 6, 
			4 5, 
			2 4
		    ), (
			7 6, 
			6 8, 
			8 8, 
			7 6
		    )))'::geometry AS geom
	    ) AS g
	  ) j;
	$have$,
	$want$
	    values 
		('{1,1,1}'::int[], 'POINT(0 0)'),
		('{1,1,2}'::int[], 'POINT(0 3)'),
		('{1,1,3}'::int[], 'POINT(4 3)'),
		('{1,1,4}'::int[], 'POINT(4 0)'),
		('{1,1,5}'::int[], 'POINT(0 0)'),
		('{2,1,1}'::int[], 'POINT(2 4)'),
		('{2,1,2}'::int[], 'POINT(1 6)'),
		('{2,1,3}'::int[], 'POINT(4 5)'),
		('{2,1,4}'::int[], 'POINT(2 4)'),
		('{2,2,1}'::int[], 'POINT(7 6)'),
		('{2,2,2}'::int[], 'POINT(6 8)'),
		('{2,2,3}'::int[], 'POINT(8 8)'),
		('{2,2,4}'::int[], 'POINT(7 6)');
	$want$,
	'multipolygon'
);

select finish();

rollback;
\q

