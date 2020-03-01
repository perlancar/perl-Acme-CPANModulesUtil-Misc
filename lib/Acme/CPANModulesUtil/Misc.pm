package Acme::CPANModulesUtil::Misc;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict 'subs', 'vars';
use warnings;

our %SPEC;

use Exporter qw(import);
our @EXPORT_OK = qw(populate_entries_from_module_links_in_description);

sub populate_entries_from_module_links_in_description {
    my $list;
    if (@_) {
        $list = $_[0];
    } else {
        my $caller = caller;
        $list = ${"$caller\::LIST"};
    }
    die 'Please specify list (either in argument or in caller\'s $LIST'
        unless $list;

    for my $mod (
        do { my %seen; grep { !$seen{$_}++ }
                 ($list->{description} =~ /<pm:(\w+(?:::\w+)*)>/g)
             }) {
        next unless grep { $_->{module} eq $mod } @{ $list->{entries} };
        push @{ $list->{entries} }, {module=>$mod};
    }
    $list;
}

1;
# ABSTRACT:

=head1 FUNCTIONS

=head2 populate_entries_from_module_links_in_description


=head1 SEE ALSO

C<Acme::CPANModules>
