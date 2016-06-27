macro(build_open_blas install_prefix staging_prefix)

  if(CMAKE_EXTRA_GENERATOR)
    set(CMAKE_GEN "${CMAKE_EXTRA_GENERATOR} - ${CMAKE_GENERATOR}")
  else()
    set(CMAKE_GEN "${CMAKE_GENERATOR}")
  endif()
  
  set(CMAKE_OSX_EXTERNAL_PROJECT_ARGS)
  if(APPLE)
    list(APPEND CMAKE_OSX_EXTERNAL_PROJECT_ARGS
      -DCMAKE_OSX_ARCHITECTURES:STRING=${CMAKE_OSX_ARCHITECTURES}
      -DCMAKE_OSX_SYSROOT:STRING=${CMAKE_OSX_SYSROOT}
      -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING=${CMAKE_OSX_DEPLOYMENT_TARGET}
    )
  endif()

  set_property(DIRECTORY PROPERTY EP_STEP_TARGETS configure build test)

  SET(EXT_CMAKE_CXX_FLAGS_RELEASE ${CMAKE_CXX_FLAGS_RELEASE})
  SET(EXT_CMAKE_C_FLAGS_RELEASE   ${CMAKE_C_FLAGS_RELEASE})
  
  SET(EXT_CMAKE_CXX_FLAGS_DEBUG   ${CMAKE_CXX_FLAGS_DEBUG})
  SET(EXT_CMAKE_C_FLAGS_DEBUG     ${CMAKE_C_FLAGS_DEBUG})
  
  SET(EXT_CMAKE_CXX_FLAGS "-fPIC ${CMAKE_CXX_FLAGS}")
  SET(EXT_CMAKE_C_FLAGS   "-fPIC ${CMAKE_C_FLAGS}")


ExternalProject_Add(OpenBLAS
        URL "http://github.com/xianyi/OpenBLAS/archive/v0.2.15.tar.gz"
        URL_MD5 "b1190f3d3471685f17cfd1ec1d252ac9"
        SOURCE_DIR OpenBLAS
        BUILD_IN_SOURCE 1
        #BINARY_DIR OpenBLAS-build
        INSTALL_DIR     "${CMAKE_BINARY_DIR}/external"
        BUILD_COMMAND   $(MAKE) USE_THREAD=0 PREFIX=${install_prefix}
        #CONFIGURE_COMMAND  $(MAKE) PREFIX=${install_prefix} USE_THREAD=0
        CONFIGURE_COMMAND ""
        INSTALL_COMMAND    $(MAKE) install PREFIX=${install_prefix} DESTDIR=${CMAKE_BINARY_DIR}/external USE_THREAD=0
      )

SET(OpenBLAS_INCLUDE_DIRS ${staging_prefix}/${install_prefix}/include )
SET(OpenBLAS_LIBRARIES    ${staging_prefix}/${install_prefix}/lib${LIB_SUFFIX}/libopenblas.a gfortran )
SET(OpenBLAS_FOUND ON)

endmacro(build_open_blas)
  