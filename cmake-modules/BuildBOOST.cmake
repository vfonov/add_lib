macro(build_BOOST install_prefix staging_prefix)

  ExternalProject_Add(BOOST
    URL  "http://sourceforge.net/projects/boost/files/boost/1.60.0/boost_1_60_0.tar.bz2"
    URL_MD5 "65a840e1a0b13a558ff19eeb2c4f0cbe"
    GIT_TAG ""
    UPDATE_COMMAND ""
    SOURCE_DIR BOOST
    LIST_SEPARATOR :::  
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND /bin/sh ${CMAKE_BINARY_DIR}/BOOST/configure_boost.sh #TODO: make this more universal?
    INSTALL_DIR     "${staging_prefix}"
    BUILD_COMMAND   ./b2 
    INSTALL_COMMAND ./b2 stage --stagedir=${staging_prefix}/${install_prefix}
 )
 
  ExternalProject_Add_Step(BOOST SetConfig 
    COMMAND ${CMAKE_COMMAND} -DCFLAGS=${EXT_C_FLAGS} -DCXXFLAGS=${EXT_C_FLAGS} -DCC=${CMAKE_C_COMPILER} -DCXX=${CMAKE_CXX_COMPILER} -Dinstall_prefix=${install_prefix} -DSOURCE_DIR=${CMAKE_SOURCE_DIR} -DBINARY_DIR=${CMAKE_BINARY_DIR} -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake-modules/ConfigureBOOST.cmake
    COMMENT "Configuring boost"
    DEPENDEES update
    DEPENDERS configure
    )
 

SET(BOOST_DIR ${CMAKE_CURRENT_BINARY_DIR}/BOOST)

endmacro(build_BOOST)
