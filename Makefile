# written by nathan wagner and placed in the public domain

EXTENSION=dumppoints
MODULES= dumppoints
DATA= dumppoints--1.0.sql
#DOCS=
SHLIB_LINK= 
MODULE_big= dumppoints
OBJS= dp.o

PG_CPPFLAGS := -I..
PG_CONFIG= pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

ifeq ($(PORTNAME), darwin)
LDFLAGS_SL += -flat_namespace -undefined suppress
endif

TESTDB=contrib_regression

# doesn't create or drop regression db
test:	clean all
	sudo make install
	psql -d $(TESTDB) -1 -c 'alter database $(TESTDB) set search_path to public,dp,tap'
	pg_prove -d $(TESTDB) --ext .sql t/*.sql

# newtest to create a regression db
newtest: clean all
	sudo make install
	-dropdb $(TESTDB)
	createdb $(TESTDB)
	psql -d $(TESTDB) -1 -c 'create schema tap'
	psql -d $(TESTDB) -1 -c 'create extension pgtap schema tap'
	psql -d $(TESTDB) -1 -c 'drop extension if exists dumppoints'
	psql -d $(TESTDB) -1 -c 'create extension postgis'
	psql -d $(TESTDB) -1 -c 'create schema dp'
	psql -d $(TESTDB) -1 -c 'create extension dumppoints schema dp'
	psql -d $(TESTDB) -1 -c 'alter database $(TESTDB) set search_path to public,dp,tap'
	pg_prove -d $(TESTDB) --ext .sql t/*.sql

# newtest to create a regression db and drop it after
droptest: clean all
	sudo make install
	-dropdb $(TESTDB)
	createdb $(TESTDB)
	psql -d $(TESTDB) -1 -c 'create schema tap'
	psql -d $(TESTDB) -1 -c 'create extension pgtap schema tap'
	psql -d $(TESTDB) -1 -c 'drop extension if exists dumppoints'
	psql -d $(TESTDB) -1 -c 'create extension postgis'
	psql -d $(TESTDB) -1 -c 'create schema dp'
	psql -d $(TESTDB) -1 -c 'create extension dumppoints schema dp'
	psql -d $(TESTDB) -1 -c 'alter database $(TESTDB) set search_path to public,dp,tap'
	pg_prove -d $(TESTDB) --ext .sql t/*.sql
	dropdb $(TESTDB)
