use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'	=> 'Tk::LogScale',
    'VERSION_FROM' => 'LogScale.pm', # finds $VERSION
    'dist'      => {'COMPRESS'=>'gzip -9f', 'SUFFIX' => '.gz',
                    'POSTOP'=>'-$(CHMOD) 644 $(DISTVNAME).tar$(SUFFIX)'},
    'PREREQ_PM'    => {'Tie::Watch' => 1.00 }, # not really necessary...
    'ABSTRACT_FROM' => 'LogScale.pm',
    'AUTHOR' => 'Slaven Rezic (eserte@cs.tu-berlin.de)',
);
