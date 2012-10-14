-- written by nathan wagner and placed in the public domain

-- we have to call a postgis function to force the
-- backend to load the postgis shared object file,
-- otherwise we will get unresolved symbols as this
-- extension calls postgis functions
select postgis_version();

CREATE OR REPLACE FUNCTION ST_DumpPoints(geometry)
        RETURNS SETOF geometry_dump
        AS '$libdir/dumppoints', 'LWGEOM_dumppoints'
        LANGUAGE C IMMUTABLE STRICT;
