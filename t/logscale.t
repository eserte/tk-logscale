# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..2\n"; }
END {print "not ok 1\n" unless $loaded;}
use Tk::LogScale;
$loaded = 1;
print "ok 1\n";

use Tk;
my $top = new MainWindow;

foreach my $orient ('horizontal', 'vertical') {
    foreach my $showvalue (0, 1) {
	$top->LogScale(-variable => \$bla,
		       -showvalue => $showvalue,
		       -resolution => 0.01,
		       -orient => $orient,
		       -from => 1000,
		       -to => 100000,
		       -background => "red",
		       -valuefmt => sub { sprintf("1:%d", $_[0]) },
		       -func    => sub { eval { log($_[0])/log(10) } },
		       -invfunc => sub { 10**$_[0] },
		      )->pack;
    }
}

$top->Label(-width => 30,
	    -textvariable => \$bla,
	   )->pack;

print "ok 2\n";

MainLoop;
