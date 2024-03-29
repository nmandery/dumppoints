begin;
	select plan(9);

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
	SELECT path, ST_AsText(geom) 
	FROM (
	  SELECT (public.ST_DumpPoints(g.geom)).* 
	  FROM
	    (SELECT 
	       'POINT (0 9)'::geometry AS geom
	    ) AS g
	  ) j;
	$have$,
	'single point'
);

select results_eq(
	$want$
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
	$want$,
	$have$
	SELECT path, ST_AsText(geom) 
	FROM (
	  SELECT (public.ST_DumpPoints(g.geom)).* 
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
	'linestring'
);

select results_eq(
	$want$
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
	$want$,
	$have$
	SELECT path, ST_AsText(geom) 
	FROM (
	  SELECT (public.ST_DumpPoints(g.geom)).* 
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
	'polygon'
);

select results_eq(
	$want$
	SELECT path, ST_AsText(geom) 
	FROM (
	  SELECT (dp.ST_DumpPoints(g.geom)).* 
	  FROM
	    (SELECT 
	       'TRIANGLE ((
			0 0, 
			0 9, 
			9 0, 
			0 0
		    ))'::geometry AS geom
	    ) AS g
	  ) j;
	$want$,
	$have$
	SELECT path, ST_AsText(geom) 
	FROM (
	  SELECT (public.ST_DumpPoints(g.geom)).* 
	  FROM
	    (SELECT 
	       'TRIANGLE ((
			0 0, 
			0 9, 
			9 0, 
			0 0
		    ))'::geometry AS geom
	    ) AS g
	  ) j;
	$have$,
	'triangle'
);


select results_eq(
	$want$
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
	$want$,
	$have$
	SELECT path, ST_AsText(geom) 
	FROM (
	  SELECT (public.ST_DumpPoints(g.geom)).* 
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
	'polygon with rings'
);

select results_eq(
	$want$
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
	$want$,
	$have$
	SELECT path, ST_AsText(geom) 
	FROM (
	  SELECT (public.ST_DumpPoints(g.geom)).* 
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
	'multipolygon'
);

select results_eq(
	$want$
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
	$want$,
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
	'polyhedralsurface'
);

select results_eq(
	$want$
	SELECT path, ST_AsEWKT(geom) 
	FROM (
	  SELECT (dp.ST_DumpPoints(g.geom)).* 
	   FROM
	     (SELECT 
	       'TIN (((
			0 0 0, 
			0 0 1, 
			0 1 0, 
			0 0 0
		    )), ((
			0 0 0, 
			0 1 0, 
			1 1 0, 
			0 0 0
		    ))
		    )'::geometry AS geom
	   ) AS g
	  ) j;
	$want$,
	$have$
	SELECT path, ST_AsEWKT(geom) 
	FROM (
	  SELECT (public.ST_DumpPoints(g.geom)).* 
	   FROM
	     (SELECT 
	       'TIN (((
			0 0 0, 
			0 0 1, 
			0 1 0, 
			0 0 0
		    )), ((
			0 0 0, 
			0 1 0, 
			1 1 0, 
			0 0 0
		    ))
		    )'::geometry AS geom
	   ) AS g
	  ) j;
	$have$,
	'tin'
);

select results_eq(
	$want$
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
	$want$,
	$have$
	SELECT path, ST_AsText(geom) 
	FROM (
	  SELECT (public.ST_DumpPoints(g.geom)).* 
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
	'collection'
);

select finish();

rollback;
\q

