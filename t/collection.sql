begin;
	select plan(1);

select results_eq(
	$have$
	SELECT path, ST_AsText(geom) 
	FROM (
	  SELECT (dp.ST_DumpPoints(g.geom)).* 
	  FROM
	    (SELECT 
	       'GEOMETRYCOLLECTION(
		  POINT(99 98), 
		  LINESTRING(1 1, 3 3),
		  POLYGON((0 0, 0 1, 1 1, 0 0)),
		  POLYGON((0 0, 0 9, 9 9, 9 0, 0 0), (5 5, 5 6, 6 6, 5 5)),
		  MULTIPOLYGON(((0 0, 0 9, 9 9, 9 0, 0 0), (5 5, 5 6, 6 6, 5 5)))
		)'::geometry AS geom
	    ) AS g
	  ) j;
	$have$,
	$want$
	    values 
		('{1,1}'::int[], 'POINT(99 98)'),
		('{2,1}'::int[], 'POINT(1 1)'),
		('{2,2}'::int[], 'POINT(3 3)'),
		('{3,1,1}'::int[], 'POINT(0 0)'),
		('{3,1,2}'::int[], 'POINT(0 1)'),
		('{3,1,3}'::int[], 'POINT(1 1)'),
		('{3,1,4}'::int[], 'POINT(0 0)'),
		('{4,1,1}'::int[], 'POINT(0 0)'),
		('{4,1,2}'::int[], 'POINT(0 9)'),
		('{4,1,3}'::int[], 'POINT(9 9)'),
		('{4,1,4}'::int[], 'POINT(9 0)'),
		('{4,1,5}'::int[], 'POINT(0 0)'),
		('{4,2,1}'::int[], 'POINT(5 5)'),
		('{4,2,2}'::int[], 'POINT(5 6)'),
		('{4,2,3}'::int[], 'POINT(6 6)'),
		('{4,2,4}'::int[], 'POINT(5 5)'),
		('{5,1,1,1}'::int[], 'POINT(0 0)'),
		('{5,1,1,2}'::int[], 'POINT(0 9)'),
		('{5,1,1,3}'::int[], 'POINT(9 9)'),
		('{5,1,1,4}'::int[], 'POINT(9 0)'),
		('{5,1,1,5}'::int[], 'POINT(0 0)'),
		('{5,1,2,1}'::int[], 'POINT(5 5)'),
		('{5,1,2,2}'::int[], 'POINT(5 6)'),
		('{5,1,2,3}'::int[], 'POINT(6 6)'),
		('{5,1,2,4}'::int[], 'POINT(5 5)');
	$want$,
	'collection'
);

select finish();

rollback;
\q

