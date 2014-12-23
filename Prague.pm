package Map::Tube::Prague;

# Pragmas.
use strict;
use warnings;
use 5.006;

# Modules.
use File::Share ':all';
use Moo;
use namespace::clean;

# Version.
our $VERSION = 0.07;

# Get XML.
has xml => (
	'is' => 'ro',
	'default' => sub {
		return dist_file('Map-Tube-Prague', 'prague-map.xml');
	},
);

with 'Map::Tube';

1;

__END__

=encoding utf8

=head1 NAME

Map::Tube::Prague - Interface to the Prague Metro Map.

=head1 SYNOPSIS

 use Map::Tube::Prague;
 my $obj = Map::Tube::Prague->new;
 my $routes_ar = $obj->get_all_routes($from, $to);
 my $station = $obj->get_node_by_id($station_id);
 my $station = $obj->get_node_by_name($station_name);
 my $route = $obj->get_shortest_route($from, $to);
 my $metro_name = $obj->name;
 my $xml_file = $obj->xml;

=head1 DESCRIPTION

It currently provides functionality to find the shortest route between the two
given nodes.

For more information about Prague Map, click L<here|https://en.wikipedia.org/wiki/Prague_Metro>.

=head1 METHODS

=over 8

=item C<new()>

 Constructor.

=item C<get_all_routes($from, $to)> [EXPERIMENTAL]

 Get all routes from station to station.
 Returns reference to array with Map::Tube::Route objects.

=item C<get_node_by_id($station_id)>

 Get station node by id.
 Returns Map::Tube::Node object.

=item C<get_node_by_name($station_name)>

 Get station node by name.
 Returns Map::Tube::Node object.

=item C<get_shortest_route($from, $to)>

 Get shortest route between $from and $to node names. Node names in $from and $to are case insensitive.
 Returns Map::Tube::Route object.

=item C<name()>

 Get metro name.
 Returns string with metro name.

=item C<xml()>

 Get XML specification of Prague metro.
 Returns string with XML.

=back

=head1 EXAMPLE1

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use Encode qw(decode_utf8 encode_utf8);
 use Map::Tube::Prague;

 # Object.
 my $obj = Map::Tube::Prague->new;

 # Get route.
 my $route = $obj->get_shortest_route(decode_utf8('Dejvická'), decode_utf8('Ládví'));

 # Print out type.
 print "Route: ".encode_utf8($route)."\n";

 # Output:
 # Route: Dejvická (Linka A), Hradčanská (Linka A), Malostranská (Linka A), Staroměstská (Linka A), Můstek (Linka A,Linka B), Muzeum (Linka A,Linka C), Hlavní nádraží (Linka C), Florenc (Linka C), Vltavská (Linka C), Nádraží Holešovice (Linka C), Kobylisy (Linka C), Ládví (Linka C)

=head1 EXAMPLE2

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use Map::Tube::Prague;

 # Object.
 my $obj = Map::Tube::Prague->new;

 # Get XML file.
 my $xml_file = $obj->xml;

 # Print out XML file.
 print "XML file: $xml_file\n";

 # Output like:
 # XML file: .*/prague-map.xml

=head1 EXAMPLE3

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use Map::Tube::GraphViz;
 use Map::Tube::GraphViz::Utils qw(node_color_without_label);
 use Map::Tube::Prague;

 # Object.
 my $obj = Map::Tube::Prague->new;

 # GraphViz object.
 my $g = Map::Tube::GraphViz->new(
         'callback_node' => \&node_color_without_label,
         'driver' => 'neato',
         'tube' => $obj,
 ); 

 # Get graph to file.
 $g->graph('Prague.png');

 # Print file.
 system "ls -l Prague.png";

 # Output like:
 # -rw-r--r-- 1 skim skim 292500 Dec 21 17:25 Prague.png

=begin html

<a href="https://raw.githubusercontent.com/tupinek/Map-Tube-Prague/master/images/Prague.png">
  <img src="https://raw.githubusercontent.com/tupinek/Map-Tube-Prague/master/images/Prague.png" alt="Pražské metro" width="300px" height="300px" />
</a>

=end html

=head1 DEPENDENCIES

L<File::Share>,
L<Map::Tube>,
L<Moo>,
L<namespace::clean>.

=head1 SEE ALSO

L<Map::Tube>,
L<Map::Tube::GraphViz>,
L<Map::Tube::Text::Table>.

L<Map::Tube::Barcelona>,
L<Map::Tube::Berlin>,
L<Map::Tube::Bucharest>,
L<Map::Tube::Delhi>,
L<Map::Tube::Dnipropetrovsk>,
L<Map::Tube::Kazan>,
L<Map::Tube::Kharkiv>,
L<Map::Tube::Kiev>,
L<Map::Tube::London>,
L<Map::Tube::Minsk>,
L<Map::Tube::Moscow>,
L<Map::Tube::Novosibirsk>,
L<Map::Tube::NYC>,
L<Map::Tube::SaintPetersburg>,
L<Map::Tube::Samara>,
L<Map::Tube::Sofia>,
L<Map::Tube::Tbilisi>,
L<Map::Tube::Tokyo>,
L<Map::Tube::Vienna>,
L<Map::Tube::Warsaw>,
L<Map::Tube::Yekaterinburg>.

=head1 REPOSITORY

L<https://github.com/tupinek/Map-Tube-Prague>

=head1 AUTHOR

Michal Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

 © 2014 Michal Špaček
 Artistic License
 BSD 2-Clause License

=head1 VERSION

0.07

=cut
