begin;
	select plan(1);

select results_eq(
	$have$
	SELECT path, ST_AsEWKT(geom) 
	FROM (
	  SELECT (ST_DumpPoints(g.geom)).* 
	   FROM
	     (SELECT 
	       'POLYHEDRALSURFACE (((
			0 0 0, 
			0 0 1, 
			0 1 1, 
			0 1 0, 
			0 0 0
		    )), ((
			0 0 0, 
			0 1 0, 
			1 1 0, 
			1 0 0, 
			0 0 0
		    ))
		    )'::geometry AS geom
	   ) AS g
	  ) j;
	$have$,
	$want$
		values
		('{1,1,1}'::int[], 'POINT(0 0 0)'),
		('{1,1,2}'::int[], 'POINT(0 0 1)'),
		('{1,1,3}'::int[], 'POINT(0 1 1)'),
		('{1,1,4}'::int[], 'POINT(0 1 0)'),
		('{1,1,5}'::int[], 'POINT(0 0 0)'),
		('{2,1,1}'::int[], 'POINT(0 0 0)'),
		('{2,1,2}'::int[], 'POINT(0 1 0)'),
		('{2,1,3}'::int[], 'POINT(1 1 0)'),
		('{2,1,4}'::int[], 'POINT(1 0 0)'),
		('{2,1,5}'::int[], 'POINT(0 0 0)');
	$want$,
	'polyhedralsurface'
);

select finish();

rollback;
\q

