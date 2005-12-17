# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..2\n"; }
END {print "not ok 1\n" unless $loaded;}
use Tk;
use Tk::LogScale;
use Tk::LabFrame;
$loaded = 1;
print "ok 1\n";

my $top = new MainWindow;

$bla[$_] = 50000 for (0..3);

my $li = 0;
foreach my $orient ('horizontal', 'vertical') {
    foreach my $showvalue (0, 1) {
	my $f = $top->LabFrame(-label => "-orient: $orient, -showvalue: $showvalue:", -labelside => "acrosstop")->pack(-fill => "x");
	$f->LogScale(-variable => \$bla[$li],
		     -showvalue => $showvalue,
		     -resolution => 0.01,
		     -orient => $orient,
		     -from => 1000,
		     -to => 100000,
		     -background => "red",
		     -valuefmt => sub { sprintf("1:%d", $_[0]) },
		     -func    => sub { eval { log($_[0])/log(10) } },
		     -invfunc => sub { 10**$_[0] },
		     -command => sub { warn "Changed to $_[0]" },
		    )->pack(-fill => ($orient eq 'horizontal' ? "x" : "y"));
	$li++;
    }
}

$top->update;

{
    my $f = $top->LabFrame(-label => "Value of \$bla[3]",
			   -labelside => "acrosstop")->pack(-fill => "x");
    $f->Label(-width => 30,
	      -textvariable => \$bla[3],
	     )->pack;

    $f->Button(-text => "Set to (approx.) 50000",
	       -command => sub { $bla[3] = 50000 })->pack;
}

if (1) {
    # hack to allow only odd numbers from 3 to 13
    my $bla2 = 1;
    my $l;
    my $f = $top->LabFrame(-label => "Allow only odd numbers from 3 to 13",
			   -labelside => "acrosstop")->pack(-fill => "x");
    $l = $f->LogScale(-variable => \$bla2,
		      -showvalue => 1,
		      -resolution => 4,
		      -orient => $orient,
		      -from => 3,
		      -to => 13,
		      -func    => sub { ($_[0]-3)*2 },
		      -invfunc => sub { ($_[0]/2)+3 },
		      -command => sub { warn "Odd number: $_[0]" },
		     )->pack;
}

print "ok 2\n";

$top->Button(-text => "OK",
	     -command => sub {
		 $top->destroy;
	     })->pack;

if ($ENV{BATCH}) {
    $top->after(500, sub { $top->destroy });
}
MainLoop;
