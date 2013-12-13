This is Subversion for Win32, version 1.8.5. Read the CHANGES file to
see what changed in this release:

    http://svn.apache.org/repos/asf/subversion/branches/1.8.x/CHANGES

These binaries were built with:

    APR 1.4.8
    APR-util 1.5.2
    APR-ICONV 1.2.1
    Berkeley DB 4.8.30
    OpenSSL 1.0.1e
    ZLib 1.2.8
    Apache 2.4.6
    PCRE 8.33
    Python 2.6.6 and 2.7.6 (2.6.9 is source only release)
    Perl 5.16.3 (ActivePerl)
    libintl 0.14.1 (patched)
    Java 1.7.0_45
    Ruby 1.8.6
    Cyrus SASL 2.1.23
    serf 1.3.2
    sqlite 3.8.1.0
    SWIG 1.3.40

The patched libintl is at

    http://subversion.tigris.org/files/documents/15/20739/svn-win32-libintl.zip

Please read the Subversion INSTALL file for more information:

    http://svn.apache.org/repos/asf/subversion/trunk/INSTALL
    


Package contents:

    svn-win32-1.8.x/
       README.txt           -- This file
       bin/                 -- All Subversion binaries and supporting DLLs,
          *.exe                including APR DLLs
          *.dll
          *.pdb
          mod_*_svn.so      -- Apache modules
          mod_*_svn.pdb
       doc/                 -- Doxygen documentation
          *.html
          *.css
          *.png
       iconv/               -- All apr-iconv loadable modules
          *.so
          *.pdb
       include/             -- Include files (for development)
          *.h
          apr/
             *.h
          apr-util/
             *.h
          apr-iconv/
             *.h
       javahl/              -- Java HighLevel wrapper library
          *.jar
          *.dll
          *.pdb
       lib/                 -- Library files (for development)
          libsvn*.lib
          apr/
             *.lib
             *.pdb
          apr-util/
             *.lib
             *.pdb
          apr-iconv/
             *.lib
             *.pdb
          serf/
             *.lib
             *.pdb
          sasl/
             *.lib
             *.pdb
       licenses/            -- Various license files
       perl/                -- Perl language bindings
          site/lib/SVN/
             *.pm
          site/lib/auto/SVN/
             *.dll
             *.pdb
       python/              -- Python language bindings
          libsvn/
             *.py
             *.pyd
             *.dll
             *.pdb
          svn/
             *.py
       ruby/                -- Ruby language bindings
       share/
          locale/           -- Message translations

For a nice description of setting up Subversion on a server on Windows, see the
developer edition of the TortoiseSVN Manual, Chapter 3, Setting Up A Server:

    http://tortoisesvn.net/docs/nightly/TortoiseSVN_en/index.html

or the "Version Control with Subversion" book, Chapter 6, Server Configuration:

    http://svnbook.red-bean.com/en/1.8/index.html

