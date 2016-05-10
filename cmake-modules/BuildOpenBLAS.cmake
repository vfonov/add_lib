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
        URL "http://github.com/xianyi/OpenBLAS/archive/v0.2.18.tar.gz"
        URL_MD5 "805e7f660877d588ea7e3792cda2ee65"
        SOURCE_DIR OpenBLAS
        BUILD_IN_SOURCE 1
        #BINARY_DIR OpenBLAS-build
        INSTALL_DIR     "${CMAKE_BINARY_DIR}/external"
        BUILD_COMMAND      $(MAKE) PREFIX=${install_prefix} USE_THREAD=0 USE_OPENMP=0 CC=${CMAKE_C_COMPILER} FC=${CMAKE_Fortran_COMPILER}
        CONFIGURE_COMMAND  $(MAKE) PREFIX=${install_prefix} USE_THREAD=0 USE_OPENMP=0 CC=${CMAKE_C_COMPILER} FC=${CMAKE_Fortran_COMPILER}
        INSTALL_COMMAND    $(MAKE) DESTDIR=${CMAKE_BINARY_DIR}/external install PREFIX=${install_prefix}
      )

SET(OpenBLAS_INCLUDE_DIRS ${staging_prefix}/${install_prefix}/include )
SET(OpenBLAS_LIBRARIES  ${staging_prefix}/${install_prefix}/lib${LIB_SUFFIX}/libopenblas.so )
SET(OpenBLAS_FOUND ON)

endmacro(build_open_blas)
  