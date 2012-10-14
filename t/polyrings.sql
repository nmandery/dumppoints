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
		    ), (
			1 1, 
			1 3, 
			3 2, 
			1 1
		    ), (
			7 6, 
			6 8, 
			8 8, 
			7 6
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
		('{1,5}'::int[], 'POINT(0 0)'),
		('{2,1}'::int[], 'POINT(1 1)'),
		('{2,2}'::int[], 'POINT(1 3)'),
		('{2,3}'::int[], 'POINT(3 2)'),
		('{2,4}'::int[], 'POINT(1 1)'),
		('{3,1}'::int[], 'POINT(7 6)'),
		('{3,2}'::int[], 'POINT(6 8)'),
		('{3,3}'::int[], 'POINT(8 8)'),
		('{3,4}'::int[], 'POINT(7 6)');
	$want$,
	'polygon with rings'
);

select finish();

rollback;
\q

