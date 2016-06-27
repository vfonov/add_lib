#! /bin/sh

CXXFLAGS="@CXXFLAGS@" CFLAGS="@CFLAGS@" CC=@CC@ CXX=@CXX@ \
 ./bootstrap.sh \
 --without-libraries=atomic,chrono,context,date_time,exception,filesystem,graph,graph_parallel,iostreams,locale,mpi,python,random,regex,signals,timer,wave --prefix=@install_prefix@
